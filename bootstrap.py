#!/usr/bin/env python3
"""
KibanaQuery environment bootstrap.

Deliberately NOT named setup.py: at a repository root that filename means
"setuptools build script" to pip and every packaging tool, and `pip install .`
would try to execute it as one.

    python bootstrap.py                          # venv + pinned deps
    python bootstrap.py --pull nomic-embed-text  # also pull an embedding model
    python bootstrap.py --build-index nomic-embed-text:latest
    python bootstrap.py --yes                    # unattended
    python bootstrap.py --dry-run                # print the plan only

Ollama is required but never installed by this script - if it is missing you
get an error and a link, per project policy.

Dependencies come from requirements.lock.txt when present. Generate it with:

    uv pip compile --universal requirements.txt -o requirements.lock.txt

The --universal flag matters. A lockfile compiled on Linux pins uvloop, which
has no Windows support, and omits colorama, which click and tqdm require on
Windows. Universal mode emits environment markers so one file serves both.
"""

from __future__ import annotations

import argparse
import os
import shutil
import sqlite3
import subprocess
import sys
import venv
from pathlib import Path

REPO = Path(__file__).resolve().parent
VENV = REPO / ".venv"
LOCKFILE = REPO / "requirements.lock.txt"
REQUIREMENTS = REPO / "requirements.txt"
CSV = REPO / "data" / "ECSFieldsCSV.csv"
ENTRYPOINT = REPO / "scripts" / "main.py"
CHROMA_ROOT = REPO / "chroma_databases"

MIN_PYTHON = (3, 10)
OLLAMA_URL = "https://ollama.com/download"

_COLOR = sys.stdout.isatty() and "NO_COLOR" not in os.environ


def _c(code: str, text: str) -> str:
    return f"\033[{code}m{text}\033[0m" if _COLOR else text


def step(m: str) -> None:
    print(_c("1;36", f"\n==> {m}"))


def ok(m: str) -> None:
    print(_c("32", f"  ok    {m}"))


def warn(m: str) -> None:
    print(_c("33", f"  warn  {m}"))


def bad(m: str) -> None:
    print(_c("1;31", f"  FAIL  {m}"))


def info(m: str) -> None:
    print(f"        {m}")


def confirm(q: str, default: bool, assume_yes: bool) -> bool:
    if assume_yes:
        return default
    try:
        r = input(f"        {q} {'[Y/n]' if default else '[y/N]'} ").strip().lower()
    except EOFError:
        return default
    return default if not r else r.startswith("y")


def venv_python(root: Path = VENV) -> Path:
    return root / ("Scripts/python.exe" if os.name == "nt" else "bin/python")


def run(cmd: list, *, check: bool = True, capture: bool = False,
        dry: bool = False, cwd: Path | None = None) -> subprocess.CompletedProcess:
    if dry:
        info("[dry-run] " + " ".join(str(c) for c in cmd))
        return subprocess.CompletedProcess(cmd, 0, "", "")
    return subprocess.run([str(c) for c in cmd], check=check, text=True,
                          capture_output=capture, cwd=str(cwd) if cwd else None)


# ---------------------------------------------------------------------------

def check_python() -> None:
    step("Python")
    if sys.version_info < MIN_PYTHON:
        bad(f"need >= {MIN_PYTHON[0]}.{MIN_PYTHON[1]}, have "
            f"{sys.version_info.major}.{sys.version_info.minor}")
        sys.exit(1)
    ok(f"{sys.version.split()[0]} ({sys.executable})")
    # 3.12 and 3.14 resolve to identical dependency sets for this project,
    # so there is no reason to hunt for a specific minor version.


def check_layout() -> None:
    step("Repository")
    missing = [p for p in (REQUIREMENTS, CSV, ENTRYPOINT) if not p.exists()]
    if missing:
        for p in missing:
            bad(f"missing {p.relative_to(REPO)}")
        info("run this from inside the KibanaQuery checkout")
        sys.exit(1)
    ok(f"root: {REPO}")


def check_ollama() -> None:
    """Required. Never installed by us - detect and stop."""
    step("Ollama")
    if not shutil.which("ollama"):
        bad("ollama is not installed or not on PATH")
        info(f"install it from {OLLAMA_URL}, then re-run this script")
        sys.exit(1)

    result = run(["ollama", "list"], check=False, capture=True)
    if result.returncode != 0:
        host = os.environ.get("OLLAMA_HOST", "http://localhost:11434")
        bad(f"ollama is installed but the daemon is unreachable at {host}")
        info("start it with 'ollama serve', or launch the desktop app on Windows")
        sys.exit(1)
    ok(f"daemon reachable ({shutil.which('ollama')})")


def installed_models() -> set[str]:
    r = run(["ollama", "list"], check=False, capture=True)
    if r.returncode != 0:
        return set()
    return {line.split()[0] for line in r.stdout.splitlines()[1:] if line.split()}


# ---------------------------------------------------------------------------

def make_venv(dry: bool, recreate: bool) -> Path:
    step("Virtual environment")
    py = venv_python()
    if VENV.exists() and recreate:
        info("removing existing .venv")
        if not dry:
            shutil.rmtree(VENV)
    elif VENV.exists() and py.exists():
        ok(f"already present ({py})")
        return py
    elif VENV.exists():
        warn(".venv exists but has no interpreter; recreating")
        if not dry:
            shutil.rmtree(VENV)

    if dry:
        info(f"[dry-run] would create {VENV}")
        return py
    venv.EnvBuilder(with_pip=True).create(VENV)
    if not py.exists():
        bad(f"venv built but no interpreter at {py}")
        sys.exit(1)
    ok(f"created {VENV}")
    return py


def install(py: Path, dry: bool) -> None:
    step("Dependencies")
    if LOCKFILE.exists():
        source = LOCKFILE
        ok(f"using pinned {LOCKFILE.name}")
        _warn_if_platform_locked()
    else:
        source = REQUIREMENTS
        warn(f"{LOCKFILE.name} not found; falling back to unpinned requirements.txt")
        info("generate a lockfile so installs are reproducible:")
        info("  uv pip compile --universal requirements.txt -o requirements.lock.txt")

    run([py, "-m", "pip", "install", "--upgrade", "pip"], dry=dry)
    run([py, "-m", "pip", "install", "-r", str(source)], dry=dry)
    ok("installed")


def _warn_if_platform_locked() -> None:
    """
    A lockfile compiled without --universal is silently wrong on the other OS.
    uvloop is the reliable tell: it is Unix-only, so an unmarked pin means the
    file was produced on Linux or macOS and will fail on Windows.
    """
    try:
        text = LOCKFILE.read_text(encoding="utf-8")
    except OSError:
        return
    for line in text.splitlines():
        stripped = line.split("#", 1)[0].strip()
        if stripped.startswith("uvloop") and ";" not in stripped:
            warn("lockfile pins uvloop with no environment marker")
            info("  uvloop has no Windows support, so this file will fail there.")
            info("  regenerate with: uv pip compile --universal requirements.txt \\")
            info("                     -o requirements.lock.txt")
            return


# ---------------------------------------------------------------------------

def pull_models(models: list[str], assume_yes: bool, dry: bool) -> None:
    if not models:
        return
    step("Models")
    have = installed_models()
    for model in models:
        if model in have:
            ok(f"{model} already present")
            continue
        if not confirm(f"pull {model}?", True, assume_yes):
            continue
        info(f"pulling {model}")
        if run(["ollama", "pull", model], check=False, dry=dry).returncode == 0:
            ok(f"pulled {model}")
        else:
            bad(f"could not pull {model}")


def _count_vectors(directory: Path) -> int | None:
    """Read the vector count straight out of chroma.sqlite3, no imports needed."""
    db = directory / "chroma.sqlite3"
    if not db.exists():
        return None
    try:
        con = sqlite3.connect(f"file:{db}?mode=ro", uri=True)
    except sqlite3.Error:
        return None
    try:
        cur = con.cursor()
        cur.execute("SELECT name FROM sqlite_master WHERE type='table' AND name='embeddings'")
        if not cur.fetchone():
            return None
        cur.execute("SELECT COUNT(*) FROM embeddings")
        return int(cur.fetchone()[0])
    except sqlite3.Error:
        return None
    finally:
        con.close()


def build_index(py: Path, model: str, dry: bool, assume_yes: bool) -> bool:
    """
    Pre-build the chroma index for an embedding model.

    Without this the index is built lazily inside AskQuestion on the first
    query - on a worker thread, taking minutes, behind a spinner, followed by
    a message telling the user to restart. Doing it here instead makes the
    first launch fast and that message never appear.
    """
    step(f"Vector index for {model}")

    target = CHROMA_ROOT / model.replace(":", "_")

    # KQLQueryHandler sets first_llm_setup = not os.path.exists(save_dir), and
    # when that is False, CreateCSVDocuments returns ([], []) and nothing is
    # ever added. So an existing directory does not mean "already built" - it
    # means "the build will silently no-op". Clear it to force a real rebuild.
    if target.exists():
        existing = _count_vectors(target)
        info(f"{target.relative_to(REPO)} already exists "
             f"({'unreadable' if existing is None else f'{existing} vectors'})")
        info("an existing directory makes the build a no-op, so it must be removed")
        if not confirm("remove it and rebuild?", True, assume_yes):
            warn("skipping index build")
            return True
        if not dry:
            shutil.rmtree(target)
            ok("removed")

    # embeddings_save_dir is relative to the working directory, so this must
    # run from the repo root or the index lands somewhere unexpected.
    code = (
        "import sys, os;"
        "sys.path.insert(0, 'scripts');"
        "from RAGParameters import Parameters;"
        "from KQLQueryBackend import KQLQueryHandler;"
        f"p = Parameters(); p.embedding_model = {model!r}; p.ollama_model = 'None';"
        "h = KQLQueryHandler(p);"
        "print('building into', p.embeddings_save_dir, flush=True);"
        "docs, ids = h.CreateCSVDocuments(p.doc_path);"
        "print('documents:', len(docs), flush=True);"
        "h.CreateVectorDB(docs, ids);"
        "print('done', flush=True)"
    )
    info("this can take several minutes on first run")
    result = run([py, "-c", code], check=False, dry=dry, cwd=REPO)
    if dry:
        return True
    if result.returncode != 0:
        bad("index build failed")
        return False

    # A zero exit status is not proof of anything here - the build path can
    # complete having added no documents at all. Check the artifact.
    count = _count_vectors(target)
    if count is None:
        bad(f"no readable index at {target.relative_to(REPO)}")
        return False
    if count == 0:
        bad("index was created but contains 0 vectors")
        info("retrieval would return nothing and the model would invent field names")
        return False
    ok(f"index built: {count} vectors at {target.relative_to(REPO)}")
    return True


def smoke_test(py: Path, dry: bool) -> bool:
    step("Smoke test")
    code = (
        "import sys; sys.path.insert(0, 'scripts');"
        "import pandas, ollama;"
        "from langchain_chroma import Chroma;"
        "from langchain_ollama import OllamaEmbeddings;"
        "from langchain_ollama.llms import OllamaLLM;"
        "from langchain_classic.retrievers import MultiQueryRetriever;"
        "from PyQt6.QtCore import QSettings;"
        "from RAGParameters import Parameters;"
        "from KQLQueryBackend import KQLQueryHandler;"
        "print('ok')"
    )
    r = run([py, "-c", code], check=False, capture=True, dry=dry, cwd=REPO)
    if dry:
        return True
    if r.returncode != 0:
        bad("imports failed")
        print(r.stderr.rstrip())
        return False
    ok("all imports resolve")
    return True


def summary() -> None:
    step("Ready")
    activate = ".venv\\Scripts\\Activate.ps1" if os.name == "nt" else "source .venv/bin/activate"
    print()
    print(_c("1", "  Launch from the repository root:"))
    print()
    print(f"      cd {REPO}")
    print(f"      {activate}")
    print("      python scripts/main.py")
    print()
    info("Working directory matters: embeddings_save_dir is relative to CWD,")
    info("so launching from inside scripts/ puts the index in the wrong place.")
    if not CHROMA_ROOT.exists():
        print()
        info("No index present. The first query will build one, which takes")
        info("minutes. Pre-build instead with --build-index <embedding-model>.")


# ---------------------------------------------------------------------------

def main() -> int:
    ap = argparse.ArgumentParser(description="Set up the KibanaQuery venv")
    ap.add_argument("--pull", action="append", default=[], metavar="MODEL",
                    help="ollama model to pull; repeatable")
    ap.add_argument("--build-index", metavar="EMBED_MODEL",
                    help="pre-build the chroma index for this embedding model")
    ap.add_argument("--yes", action="store_true", help="accept defaults")
    ap.add_argument("--recreate", action="store_true", help="rebuild .venv from scratch")
    ap.add_argument("--dry-run", action="store_true", help="print actions only")
    ap.add_argument("--skip-ollama", action="store_true",
                    help="skip the ollama check (venv only)")
    args = ap.parse_args()

    print(_c("1;36", "KibanaQuery bootstrap"))
    if args.dry_run:
        warn("dry run: nothing will be created, installed, or downloaded")

    check_python()
    check_layout()
    if not args.skip_ollama:
        check_ollama()

    py = make_venv(args.dry_run, args.recreate)
    install(py, args.dry_run)

    models = list(args.pull)
    if args.build_index and args.build_index not in models:
        models.append(args.build_index)
    if not args.skip_ollama:
        pull_models(models, args.yes, args.dry_run)

    if not args.dry_run and not smoke_test(py, args.dry_run):
        return 1

    if args.build_index:
        if args.skip_ollama:
            # Building an index means computing embeddings, which needs a
            # running daemon. Say so rather than quietly doing nothing.
            warn("--build-index needs ollama; ignored because --skip-ollama was given")
        elif not build_index(py, args.build_index, args.dry_run, args.yes):
            return 1

    summary()
    return 0


if __name__ == "__main__":
    try:
        sys.exit(main())
    except KeyboardInterrupt:
        print()
        sys.exit(130)

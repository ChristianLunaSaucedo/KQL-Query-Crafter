#!/usr/bin/env sh
#
# KibanaQuery setup - Linux, macOS, WSL, Git Bash.
#
# Deliberately thin. All real logic lives in bootstrap.py so that Windows and
# Unix run identical code instead of two scripts that drift apart.
#
#   ./setup.sh                      interactive
#   ./setup.sh --yes                accept defaults
#   ./setup.sh --gen-model qwen3:8b pin the generation model
#   ./setup.sh --dry-run            print the plan, change nothing
#
# Any arguments are passed straight through to bootstrap.py.

set -eu

REPO="$(CDPATH='' cd -- "$(dirname -- "$0")" && pwd)"
BOOTSTRAP="$REPO/bootstrap.py"

if [ ! -f "$BOOTSTRAP" ]; then
    echo "error: bootstrap.py not found next to this script ($REPO)" >&2
    exit 1
fi

# Find an interpreter new enough for the dependency tree. Checked in
# preference order; the version test runs inside the candidate itself so we
# never have to parse a version string in shell.
PYTHON=""
for candidate in python3 python python3.13 python3.12 python3.11 python3.10; do
    if command -v "$candidate" >/dev/null 2>&1; then
        if "$candidate" -c 'import sys; sys.exit(0 if sys.version_info >= (3,10) else 1)' 2>/dev/null; then
            PYTHON="$candidate"
            break
        fi
    fi
done

if [ -z "$PYTHON" ]; then
    echo "error: no Python 3.10+ interpreter found on PATH" >&2
    echo "       install one from https://www.python.org/downloads/" >&2
    exit 1
fi

echo "using $("$PYTHON" --version 2>&1) ($(command -v "$PYTHON"))"
exec "$PYTHON" "$BOOTSTRAP" "$@"

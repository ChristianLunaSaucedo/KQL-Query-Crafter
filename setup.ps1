<#
.SYNOPSIS
    KibanaQuery setup for Windows.

.DESCRIPTION
    Thin wrapper. All real logic lives in bootstrap.py so Windows and Unix
    run identical code. Arguments are passed straight through.

.EXAMPLE
    .\setup.ps1
    .\setup.ps1 --yes
    .\setup.ps1 --gen-model qwen3:8b
    .\setup.ps1 --dry-run

.NOTES
    If PowerShell blocks this script, either unblock it for the session:
        Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass
    or run it directly:
        python bootstrap.py
#>

$ErrorActionPreference = 'Stop'

$Repo = Split-Path -Parent $MyInvocation.MyCommand.Path
$Bootstrap = Join-Path $Repo 'bootstrap.py'

if (-not (Test-Path $Bootstrap)) {
    Write-Error "bootstrap.py not found next to this script ($Repo)"
    exit 1
}

# The py launcher is the reliable way to get a specific version on Windows;
# fall back to whatever python resolves to. Note that a bare 'python' on a
# machine without Python installed opens the Microsoft Store stub, which
# exits 9009 rather than reporting a version - the version probe below
# rejects that case cleanly.
$Candidates = @(
    @{ Exe = 'py';     Args = @('-3') },
    @{ Exe = 'python'; Args = @() },
    @{ Exe = 'python3'; Args = @() }
)

$Python = $null
$PythonArgs = @()

foreach ($c in $Candidates) {
    $cmd = Get-Command $c.Exe -ErrorAction SilentlyContinue
    if (-not $cmd) { continue }

    $probe = @($c.Args) + @('-c', 'import sys; sys.exit(0 if sys.version_info >= (3,10) else 1)')
    try {
        & $c.Exe @probe 2>$null
        if ($LASTEXITCODE -eq 0) {
            $Python = $c.Exe
            $PythonArgs = $c.Args
            break
        }
    } catch {
        continue
    }
}

if (-not $Python) {
    Write-Host "error: no Python 3.10+ interpreter found" -ForegroundColor Red
    Write-Host "       install one from https://www.python.org/downloads/"
    Write-Host "       make sure 'Add python.exe to PATH' is ticked during install"
    exit 1
}

$version = & $Python @PythonArgs --version 2>&1
Write-Host "using $version ($((Get-Command $Python).Source))"

$forward = @($PythonArgs) + @($Bootstrap) + $args
& $Python @forward
exit $LASTEXITCODE

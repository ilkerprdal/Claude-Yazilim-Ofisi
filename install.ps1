# Software Office installer (Windows PowerShell)
#
# Usage:
#   irm https://raw.githubusercontent.com/ilkerprdal/Claude-Software-Office/main/install.ps1 | iex
#   .\install.ps1
#   .\install.ps1 -Target C:\path\to\project
#   .\install.ps1 -Ref v0.1.0
#
# Params:
#   -Target    Target directory (default: current dir)
#   -Ref       Git ref / tag to install (default: main)
#   -Yes       Skip confirmation
#   -NoBackup  Don't back up existing CLAUDE.md

[CmdletBinding()]
param(
    [string]$Target = (Get-Location).Path,
    [string]$Ref = 'main',
    [switch]$Yes,
    [switch]$NoBackup
)

$ErrorActionPreference = 'Stop'

$Repo = 'ilkerprdal/Claude-Software-Office'

function Log    { param([string]$m) Write-Host $m -ForegroundColor Cyan }
function Ok     { param([string]$m) Write-Host "✓ $m" -ForegroundColor Green }
function Warn1  { param([string]$m) Write-Host "! $m" -ForegroundColor Yellow }
function Die    { param([string]$m) Write-Host "✗ $m" -ForegroundColor Red; exit 1 }

Write-Host ""
Log 'Software Office installer'
Log "Target:  $Target"
Log "Source:  github.com/$Repo@$Ref"
Write-Host ""

if (-not (Test-Path $Target -PathType Container)) {
    Die "Target does not exist: $Target"
}

if (-not $Yes -and [Environment]::UserInteractive) {
    $confirm = Read-Host "Install into '$Target'? (y/n)"
    if ($confirm -notmatch '^[yY]$') {
        Warn1 'Cancelled.'
        exit 0
    }
}

# Download zip
$url = "https://codeload.github.com/$Repo/zip/refs/heads/$Ref"
$tmp = Join-Path ([System.IO.Path]::GetTempPath()) ("so-install-" + [System.IO.Path]::GetRandomFileName())
New-Item -ItemType Directory -Path $tmp | Out-Null

try {
    Log "Downloading $url ..."
    $zipPath = Join-Path $tmp 'source.zip'
    Invoke-WebRequest -Uri $url -OutFile $zipPath -UseBasicParsing

    Expand-Archive -Path $zipPath -DestinationPath $tmp -Force

    $extracted = Get-ChildItem -Path $tmp -Directory | Where-Object { $_.Name -like 'Claude-Software-Office-*' } | Select-Object -First 1
    if (-not $extracted) { Die 'Failed to extract source.' }
    $src = $extracted.FullName
    Ok 'Downloaded'

    # 1. .claude/
    $claudeDst = Join-Path $Target '.claude'
    if (Test-Path $claudeDst) {
        Remove-Item -Recurse -Force $claudeDst
    }
    Copy-Item -Recurse (Join-Path $src '.claude') $Target -Force
    Ok '.claude/  (agents, commands, docs, memory, settings)'

    # 2. CLAUDE.md
    $claudeMd = Join-Path $Target 'CLAUDE.md'
    if ((Test-Path $claudeMd) -and -not $NoBackup) {
        Copy-Item $claudeMd (Join-Path $Target 'CLAUDE.legacy.md') -Force
        Warn1 'Existing CLAUDE.md backed up as CLAUDE.legacy.md'
    }
    Copy-Item (Join-Path $src 'CLAUDE.md') $claudeMd -Force
    Ok 'CLAUDE.md'

    # 3. .gitignore (merge)
    $giSrc = Join-Path $src '.gitignore'
    $giDst = Join-Path $Target '.gitignore'
    if (Test-Path $giDst) {
        $existing = Get-Content $giDst
        $additions = @()
        Get-Content $giSrc | ForEach-Object {
            $line = $_.Trim()
            if ($line -and $line -notlike '#*' -and ($existing -notcontains $_)) {
                $additions += $_
            }
        }
        if ($additions.Count -gt 0) {
            Add-Content -Path $giDst -Value $additions
        }
        Ok '.gitignore  (merged)'
    } else {
        Copy-Item $giSrc $giDst -Force
        Ok '.gitignore'
    }

    # 4. production/ scaffold (only if missing)
    $prodDst = Join-Path $Target 'production'
    if (-not (Test-Path $prodDst)) {
        New-Item -ItemType Directory -Path (Join-Path $prodDst 'session-state') -Force | Out-Null
        New-Item -ItemType Directory -Path (Join-Path $prodDst 'stories')       -Force | Out-Null
        New-Item -ItemType Directory -Path (Join-Path $prodDst 'sprints')       -Force | Out-Null
        New-Item -ItemType Directory -Path (Join-Path $prodDst 'retros')        -Force | Out-Null
        New-Item -ItemType Directory -Path (Join-Path $prodDst 'qa\bugs')       -Force | Out-Null

        $activeSrc = Join-Path $src 'production\session-state\active.md'
        $backlogSrc = Join-Path $src 'production\backlog.md'
        if (Test-Path $activeSrc)  { Copy-Item $activeSrc  (Join-Path $prodDst 'session-state\active.md') -Force }
        if (Test-Path $backlogSrc) { Copy-Item $backlogSrc (Join-Path $prodDst 'backlog.md') -Force }
        Ok 'production/  (sprints, retros, qa, session-state)'
    } else {
        Warn1 'production/ exists — left alone'
    }

} finally {
    if (Test-Path $tmp) { Remove-Item -Recurse -Force $tmp }
}

Write-Host ""
Ok 'Installation complete.'
Write-Host ""
Log 'Next steps:'
Write-Host "  cd `"$Target`""
Write-Host '  claude'
Write-Host '  /takeover    # if there are prior AI context files (context.md, .cursorrules, etc.)'
Write-Host '  /start       # otherwise'
Write-Host ''
Write-Host 'Agents auto-detect your language.'

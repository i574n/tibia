param(
    $fast,
    $ScriptDir = $PSScriptRoot
)
Set-Location $ScriptDir
$ErrorActionPreference = "Stop"


$url = git ls-remote --get-url
$owner = ($url -split '/' | Select-Object -Last 2 | Select-Object -First 1) -replace '\.git$', '' ?? $env:GITHUB_REPOSITORY_OWNER
$domain = ($url -split '/' | Select-Object -Last 3 | Select-Object -First 1) ?? $env:GITHUB_SERVER_URL -replace 'https?://', ''
Write-Output "init.ps1 / url: $url / owner: $owner / domain: $domain"

if (!$fast) {
    Set-Location (New-Item -ItemType Directory -Path "../.." -Force)
    git clone --recurse-submodules https://$domain/$owner/polyglot.git
    Set-Location polyglot
    git pull
    Set-Location $ScriptDir
    pwsh ../../polyglot/scripts/init.ps1
}

. ../../polyglot/scripts/core.ps1

EnsureSymbolicLink -Path "../deps/polyglot" -Target "../../polyglot"
EnsureSymbolicLink -Path "../deps/spiral" -Target "../../spiral"

if ($IsLinux -and !(Get-Command lua5.1 -ErrorAction Ignore)) {
    { sudo apt-get update } | Invoke-Block -OnError Continue
    { sudo apt-get install -y lua5.1 } | Invoke-Block -OnError Continue
    if (!(Get-Command lua5.1 -ErrorAction Ignore)) { { apt-get update; apt-get install -y lua5.1 } | Invoke-Block -OnError Continue }
}

pwsh ../deps/spiral/scripts/init-wgsl-run.ps1 -TargetDir ../target/wgsl-run -fast $($fast ?? '')
if ($LASTEXITCODE -ne 0) { throw "init.ps1 / init-wgsl-run.ps1 failed (exit code $LASTEXITCODE)" }

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

{ sudo apt-get update } | Invoke-Block -Linux -Distro ubuntu -OnError Continue
{ apt-get update } | Invoke-Block -Linux -Distro ubuntu -OnError Continue
{ sudo apt install -y mesa-vulkan-drivers } | Invoke-Block -Linux -Distro ubuntu -OnError Continue
{ apt install -y mesa-vulkan-drivers } | Invoke-Block -Linux -Distro ubuntu -OnError Continue

$wgslRun = "../target/wgsl-run/release/spiral-wgsl$(_exe)"
if (!$fast -or !(Test-Path $wgslRun)) {
    $manifest = "../deps/spiral/apps/compiler/tmp/tests/native-shims/wgsl-run/Cargo.toml"
    { cargo build --release --manifest-path $manifest --target-dir ../target/wgsl-run } | Invoke-Block
}
Write-Output "init.ps1 / wgsl runner: $((Resolve-Path $wgslRun).Path)"

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
{ sudo apt install -y lua5.1 } | Invoke-Block -Linux -Distro ubuntu -OnError Continue
{ apt install -y lua5.1 } | Invoke-Block -Linux -Distro ubuntu -OnError Continue

$wgslRun = "../target/wgsl-run/release/spiral-wgsl$(_exe)"
if (!$fast -or !(Test-Path $wgslRun)) {
    $manifest = "../deps/spiral/apps/compiler/tmp/tests/native-shims/wgsl-run/Cargo.toml"
    { cargo build --release --manifest-path $manifest --target-dir ../target/wgsl-run } | Invoke-Block
}
Write-Output "init.ps1 / wgsl runner: $((Resolve-Path $wgslRun).Path)"
if ($IsWindows) {
    $dxc = Get-ChildItem "${env:ProgramFiles(x86)}/Windows Kits/10/bin/*/x64/dxcompiler.dll" -ErrorAction Ignore |
        Where-Object { Test-Path (Join-Path $_.DirectoryName 'dxil.dll') } |
        Sort-Object { [version]$_.Directory.Parent.Name } -Descending | Select-Object -First 1
    if ($dxc) { Copy-Item $dxc.FullName, (Join-Path $dxc.DirectoryName 'dxil.dll') (Split-Path $wgslRun) -Force }
    Write-Output "init.ps1 / dx12 shader compiler beside the runner: $(if ($dxc) { $dxc.DirectoryName } else { 'none, wgpu falls back to fxc' })"
}
if ($IsWindows -and $env:CI) {
    $runnerDir = Split-Path $wgslRun
    $downloads = (New-Item -ItemType Directory -Force "../target/gpu-downloads").FullName
    Invoke-WebRequest "https://sdk.lunarg.com/sdk/download/latest/windows/vulkan-runtime-components.zip" -OutFile "$downloads/vulkan-runtime.zip"
    { 7z e "$downloads/vulkan-runtime.zip" "-o$runnerDir" "*/x64/vulkan-1.dll" -y } | Invoke-Block
    $mesaRelease = Invoke-RestMethod "https://api.github.com/repos/pal1000/mesa-dist-win/releases/latest"
    $mesaAsset = $mesaRelease.assets | Where-Object { $_.name -match '^mesa3d-.*-release-msvc\.7z$' } | Select-Object -First 1
    Invoke-WebRequest $mesaAsset.browser_download_url -OutFile "$downloads/$($mesaAsset.name)"
    $mesaDir = (New-Item -ItemType Directory -Force "../target/mesa").FullName
    { 7z x "$downloads/$($mesaAsset.name)" "-o$mesaDir" "x64/*lvp*" -y } | Invoke-Block
    $icd = Join-Path $mesaDir "x64/lvp_icd.x86_64.json"
    New-Item -Path "HKLM:\SOFTWARE\Khronos\Vulkan\Drivers" -Force | Out-Null
    New-ItemProperty -Path "HKLM:\SOFTWARE\Khronos\Vulkan\Drivers" -Name $icd -PropertyType DWord -Value 0 -Force | Out-Null
    Write-Output "init.ps1 / lavapipe $($mesaRelease.tag_name) registered for the elevated CI runner: $icd, vulkan loader beside the runner"
}
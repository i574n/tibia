param(
    [string[]] $Variants = @('baseline', 'let-start-src', 'combo-a', 'combo-c'),
    [string] $Test = 'entry_a_full_troll_hunt_and_five_cyclops_clears_on_gpu',
    [ValidateSet('gpu', 'lavapipe', 'warp-dxc')] [string[]] $Adapters = @('gpu'),
    [int] $Repeat = 1,
    [switch] $Cold,
    [int] $TimeoutSec = 1800,
    [string] $Mesa = (Join-Path $env:LOCALAPPDATA 'spiral-bin/runs/mesa-dist-win-26.2.4/extracted/x64/lvp_icd.x86_64.json')
)
$ErrorActionPreference = 'Stop'
$runner = Join-Path $PSScriptRoot '../../target/wgsl-run/release/spiral-wgsl.exe'
$env:SPIRAL_WGSL_TIMING = '1'
$runs = Join-Path $env:LOCALAPPDATA 'spiral-bin/runs/tibia-wgsl-shader-size'
$timings = Join-Path $PSScriptRoot 'timings.tsv'
$drivers = 'HKLM:\SOFTWARE\Khronos\Vulkan\Drivers'
$sdk = Get-ChildItem "${env:ProgramFiles(x86)}/Windows Kits/10/bin/*/x64/dxcompiler.dll" -ErrorAction Ignore | Sort-Object { [version]$_.Directory.Parent.Name } -Descending | Select-Object -First 1

function Set-AdapterEnvironment([string] $adapter) {
    foreach ($name in 'WGPU_BACKEND', 'WGPU_ADAPTER_NAME', 'WGPU_DX12_COMPILER') { Remove-Item "env:$name" -ErrorAction Ignore }
    switch ($adapter) {
        'lavapipe' { $env:WGPU_BACKEND = 'vulkan'; $env:WGPU_ADAPTER_NAME = 'llvmpipe' }
        'warp-dxc' { $env:WGPU_BACKEND = 'dx12'; $env:WGPU_ADAPTER_NAME = 'Microsoft Basic Render Driver'; $env:WGPU_DX12_COMPILER = 'dxc'; $env:PATH = "$($sdk.DirectoryName);$env:PATH" }
    }
}

$env:SPIRAL_WGSL_TIMEOUT_SECONDS = "$TimeoutSec"
$errors = Join-Path $env:TEMP "time-variants-$PID.err"
foreach ($adapter in $Adapters) {
    $registered = $false
    if ($adapter -eq 'lavapipe') { New-Item -Path $drivers -Force | Out-Null; New-ItemProperty -Path $drivers -Name $Mesa -PropertyType DWord -Value 0 -Force | Out-Null; $registered = $true }
    try {
        Set-AdapterEnvironment $adapter
        foreach ($round in 1..$Repeat) {
            foreach ($variant in $Variants) {
                $file = Join-Path $runs "$variant/$Test.wgsl"
                if ($Cold) { $env:__GL_SHADER_DISK_CACHE_PATH = (New-Item -ItemType Directory -Force (Join-Path $runs "driver-cache/$([guid]::NewGuid())")).FullName; $env:MESA_SHADER_CACHE_DISABLE = 'true' }
                $process = Start-Process $runner -ArgumentList "`"$file`"" -NoNewWindow -PassThru -RedirectStandardError $errors
                $null = $process.Handle
                $sw = [Diagnostics.Stopwatch]::StartNew()
                $exit = if ($process.WaitForExit($TimeoutSec * 1000)) { $process.ExitCode } else { try { $process.Kill($true) } catch { }; 'timeout' }
                $phases = (Get-Content $errors -ErrorAction Ignore | Select-String 'compile_ms|run_ms' | ForEach-Object { $_.Line -replace 'wgsl timing ', '' }) -join ' '
                $row = "$(Get-Date -Format 'yyyy-MM-dd HH:mm')`t$variant $Test $adapter round $round$(if ($Cold) { ' cold' })`t$((Get-Item $file).Length)`t$exit`t$([int]$sw.Elapsed.TotalSeconds)`t$phases"
                Add-Content $timings $row
                Write-Output $row
            }
        }
    } finally {
        if ($registered) { Remove-ItemProperty -Path $drivers -Name $Mesa -Force -ErrorAction Ignore }
    }
}

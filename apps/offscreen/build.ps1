param(
    [switch] $Check,
    $ScriptDir = $PSScriptRoot
)
$ErrorActionPreference = 'Stop'

$repo = (Resolve-Path (Join-Path $ScriptDir '../..')).Path
$spiral = (Resolve-Path (Join-Path $repo 'deps/spiral')).Path
$out = (New-Item -ItemType Directory -Force (Join-Path $repo 'target/offscreen')).FullName
$env:SPIRAL_COMPILER_PACKAGE_DIR = Join-Path $spiral 'deps/The-Spiral-Language/VS Code Plugin'
$env:SPIRAL_WORKSPACE_ROOT = Join-Path $spiral 'apps/compiler/tmp'
$dotnet = Join-Path $env:LOCALAPPDATA "spiral-bin/toolchains/dotnet/dotnet$(if ($IsWindows) { '.exe' })"
$compiler = Join-Path $env:LOCALAPPDATA 'spiral-bin/bin/single-flight/SpiralCompiler/Release/net11.0/SpiralCompiler.dll'
& $dotnet $compiler --backend Rust (Join-Path $ScriptDir 'offscreen.spi') (Join-Path $out 'offscreen.rs')
if ($LASTEXITCODE -ne 0) { throw "offscreen / spiral compile failed ($LASTEXITCODE)" }
$exe = Join-Path $out 'offscreen.exe'
Push-Location $repo
rustc --edition 2024 -O -A warnings -o $exe (Join-Path $out 'offscreen.rs')
$rustcExit = $LASTEXITCODE
Pop-Location
if ($rustcExit -ne 0) { throw "offscreen / rustc failed ($rustcExit)" }
"offscreen / built $exe"
if (!$Check) { return }

$cmd = Join-Path $env:SystemRoot 'System32\cmd.exe'
$exited = @(& $exe --exe $cmd --arguments '/c exit 7' --timeout-seconds 10 --desktop tibia-offscreen-check)
if ($LASTEXITCODE -ne 0 -or ($exited -join "`n") -notmatch 'exit 7 on desktop tibia-offscreen-check') { throw "offscreen / check / exit code not reported: $($exited -join ' | ')" }
$ping = Join-Path $env:SystemRoot 'System32\PING.EXE'
$killed = @(& $exe --exe $ping --arguments '-n 30 127.0.0.1' --timeout-seconds 2 --desktop tibia-offscreen-check | Where-Object { $_ -match '^offscreen:' })
if (($killed -join "`n") -notmatch 'killed after 2 s' -or ($killed -join "`n") -notmatch 'exit 124') { throw "offscreen / check / timeout not reported: $($killed -join ' | ')" }
"offscreen / check / exit code and timeout reported"

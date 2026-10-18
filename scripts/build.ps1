param(
    [string[]] $Files = @(),
    $ScriptDir = $PSScriptRoot
)
Set-Location $ScriptDir
$ErrorActionPreference = "Stop"
. ../deps/polyglot/scripts/core.ps1

$Files = @($Files | ForEach-Object { $_ -split ',' } | Where-Object { $_ })


& ../apps/arena/build.ps1

$runNotebook = (Resolve-Path "../deps/spiral/apps/cells/spi/run_notebook.ps1").Path
$wgslRun = @($env:SPIRAL_WGSL_RUN, "../target/wgsl-run/release/spiral-wgsl$(_exe)") |
    Where-Object { $_ -and (Test-Path $_) } | Select-Object -First 1
if ($wgslRun) { $env:SPIRAL_WGSL_RUN = (Resolve-Path $wgslRun).Path }
if ($IsWindows -and $env:SPIRAL_WGSL_RUN -and (Test-Path (Join-Path (Split-Path $env:SPIRAL_WGSL_RUN) 'dxcompiler.dll'))) { $env:WGPU_DX12_COMPILER = 'dxc' }
if ($IsWindows -and $env:CI -and (Test-Path ../target/mesa/x64/lvp_icd.x86_64.json)) { $env:WGPU_BACKEND = 'vulkan'; $env:WGPU_ADAPTER_NAME = 'llvmpipe' }
Write-Output "build.ps1 / wgsl runner: $($env:SPIRAL_WGSL_RUN ?? 'none') / dx12 compiler: $($env:WGPU_DX12_COMPILER ?? 'default') / adapter: $($env:WGPU_ADAPTER_NAME ?? 'default')"

$notebooks = (New-Item -ItemType Directory -Force "../notebooks").FullName
$sources = Get-ChildItem ../src, ../apps/arena -File -Filter "*.spi" |
    Where-Object { !$Files -or $_.BaseName -in $Files } |
    Where-Object { Select-String -Path $_.FullName -Pattern '^test ' -Quiet } |
    Sort-Object Name

$problems = @()
foreach ($source in $sources) {
    $name = $source.BaseName
    $lines = pwsh -NoProfile -File $runNotebook --path $source.FullName --output-path (Join-Path $notebooks "$name.spi.ipynb") --no-spi 2>&1
    $exitCode = $LASTEXITCODE
    $total = $lines | Select-String 'spiral-tests total (\{.*\})' | Select-Object -Last 1
    if (!$total) {
        $lines | Select-Object -Last 20 | ForEach-Object { Write-Output "build.ps1 / $name / $_" }
        $problems += "${name}: no spiral-tests total line (exit code $exitCode)"
        continue
    }
    $s = $total.Matches[0].Groups[1].Value | ConvertFrom-Json
    Write-Output ("build.ps1 / {0} / discovered {1} executed {2} passed {3} failed {4} static {5} unsupported {6} skipped {7} not_run {8} memo_hits {9}" -f `
        $name, $s.discovered, $s.executed, $s.passed, $s.failed, $s.static, $s.unsupported, $s.skipped, $s.not_run, $s.memo_hits)
    $missing = $s.discovered - $s.executed - $s.static
    if ($s.failed -or $s.unsupported -or $s.skipped -or $s.not_run -or $missing -or $s.passed -ne $s.executed) {
        $failedTests = ($lines | Select-String 'spiral-tests file (\{.*\})' | ForEach-Object { ($_.Matches[0].Groups[1].Value | ConvertFrom-Json).failed_tests }) -join ', '
        $problems += "${name}: failed $($s.failed), unsupported $($s.unsupported), skipped $($s.skipped), not run $($s.not_run), not executed $missing ($failedTests)"
        $lines | Select-String -Pattern 'wgsl error|error|failed|assert|panic|timeout|timed out|exit code' |
            Where-Object { $_.Line -notmatch '^spiral-tests ' } | Select-Object -First 40 |
            ForEach-Object { Write-Output "build.ps1 / $name / detail / $($_.Line)" }
    }
}

if (!$sources) { throw "build.ps1 / no test files matched $($Files -join ', ')" }
if ($problems) { throw "build.ps1 / $($problems.Count) of $(@($sources).Count) test files are not fully green:`n$($problems -join "`n")" }
Write-Output "build.ps1 / all $(@($sources).Count) test files green"

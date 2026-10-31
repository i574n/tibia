param(
    [string[]] $Files = @(),
    [string[]] $Exclude = @(),
    [string] $Label = 'all',
    [switch] $Resume,
    $ScriptDir = $PSScriptRoot
)
Set-Location $ScriptDir
$ErrorActionPreference = "Stop"
. ../deps/polyglot/scripts/core.ps1

$Files = @($Files | ForEach-Object { $_ -split ',' } | Where-Object { $_ })
$Exclude = @($Exclude | ForEach-Object { $_ -split ',' } | Where-Object { $_ })


& ../apps/arena/build.ps1

. ../deps/spiral/lib/spiral/lib.ps1
$spiral = Ensure-SpiralCompiler | Select-Object -Last 1
$layout = @(& $spiral.Dotnet $spiral.Compiler format ../src ../apps/arena ../apps/map ../apps/host ../apps/offscreen ../apps/canary --check 2>&1)
if ($LASTEXITCODE -ne 0) {
    $layout | Select-Object -Last 10 | ForEach-Object { Write-Output "build.ps1 / layout / $_" }
    throw "build.ps1 / layout: run SpiralCompiler format on src, apps/arena, apps/map, apps/host, apps/offscreen and apps/canary"
}
Write-Output "build.ps1 / layout / formatter check clean"

$sibling = '../../x/postability'
if (Test-Path $sibling) {
    foreach ($name in 'x.json', 'tlds.txt') {
        if ((Get-FileHash "../postability/$name").Hash -ne (Get-FileHash "$sibling/$name").Hash) { throw "build.ps1 / postable: postability/$name differs from x's; copy it from $sibling" }
    }
}
$postable = @(& $spiral.Dotnet $spiral.Compiler --x-compat ../src ../apps 2>&1 | ForEach-Object { "$_" })
if ($LASTEXITCODE -ne 0) { $postable | Select-Object -Last 10 | ForEach-Object { Write-Output "build.ps1 / postable / $_" }; throw "build.ps1 / postable: x-compat exited $LASTEXITCODE" }
$overweight = @($postable | Where-Object { $_ -match '^[^:]+:\d+:\d+: overweight' })
$overweight | ForEach-Object { Write-Output "build.ps1 / postable / $_" }
if ($overweight) { throw "build.ps1 / postable: $($overweight.Count) cells over one post; split them by hand" }
Write-Output "build.ps1 / postable / every cell fits one post / $(@($postable | Where-Object { $_ -match ': mention: ' }).Count) mentions left to the poster"

$runNotebook = (Resolve-Path "../deps/spiral/apps/cells/spi/run_notebook.ps1").Path
$wgslRun = @($env:SPIRAL_WGSL_RUN, "../target/wgsl-run/release/spiral-wgsl$(_exe)") |
    Where-Object { $_ -and (Test-Path $_) } | Select-Object -First 1
if ($wgslRun) { $env:SPIRAL_WGSL_RUN = (Resolve-Path $wgslRun).Path }
if ($IsWindows -and $env:SPIRAL_WGSL_RUN -and (Test-Path (Join-Path (Split-Path $env:SPIRAL_WGSL_RUN) 'dxcompiler.dll'))) { $env:WGPU_DX12_COMPILER = 'dxc' }
if ($IsWindows -and $env:CI -and (Test-Path ../target/wgsl-run/mesa/x64/lvp_icd.x86_64.json)) { $env:WGPU_BACKEND = 'vulkan'; $env:WGPU_ADAPTER_NAME = 'llvmpipe' }
Write-Output "build.ps1 / wgsl runner: $($env:SPIRAL_WGSL_RUN ?? 'none') / dx12 compiler: $($env:WGPU_DX12_COMPILER ?? 'default') / adapter: $($env:WGPU_ADAPTER_NAME ?? 'default')"

$metrics = (New-Item -ItemType Directory -Force "../target/ci-metrics").FullName
$machine = if ($IsWindows) {
    $cpu = Get-CimInstance Win32_Processor | Select-Object -First 1
    [pscustomobject]@{ Cpu = $cpu.Name.Trim(); Memory = (Get-CimInstance Win32_ComputerSystem).TotalPhysicalMemory }
} else {
    [pscustomobject]@{ Cpu = ((Get-Content /proc/cpuinfo | Select-String '^model name\s*:\s*(.*)' | Select-Object -First 1).Matches[0].Groups[1].Value); Memory = [long]((Get-Content /proc/meminfo | Select-String '^MemTotal:\s*(\d+)').Matches[0].Groups[1].Value) * 1024 }
}
$platform = "$([Runtime.InteropServices.RuntimeInformation]::OSDescription)".Trim()
"platform`tcpu`tlogical_cores`tmemory_gib`twgsl_runner`tdx12_compiler`tadapter_request`n$platform`t$($machine.Cpu)`t$([Environment]::ProcessorCount)`t$([math]::Round($machine.Memory / 1GB, 1))`t$($env:SPIRAL_WGSL_RUN ?? '')`t$($env:WGPU_DX12_COMPILER ?? '')`t$($env:WGPU_ADAPTER_NAME ?? '')" |
    Set-Content (Join-Path $metrics 'machine.tsv')
Write-Output "build.ps1 / machine / $platform / $($machine.Cpu) / $([Environment]::ProcessorCount) logical cores / $([math]::Round($machine.Memory / 1GB, 1)) GiB"
function Get-Load {
    $free = if ($IsWindows) { (Get-CimInstance Win32_OperatingSystem).FreePhysicalMemory * 1KB } else { [long]((Get-Content /proc/meminfo | Select-String '^MemAvailable:\s*(\d+)').Matches[0].Groups[1].Value) * 1KB }
    $top = Get-Process | Sort-Object WorkingSet64 -Descending | Select-Object -First 5 | ForEach-Object { "$($_.ProcessName) $([math]::Round($_.WorkingSet64 / 1MB)) MB" }
    "free $([math]::Round($free / 1GB, 1)) GiB / $($top -join ', ')"
}
$fileRows = [Collections.Generic.List[object]]::new()
$testRows = [Collections.Generic.List[object]]::new()
$wgslRows = [Collections.Generic.List[object]]::new()

$notebooks = (New-Item -ItemType Directory -Force "../notebooks").FullName
$sources = Get-ChildItem ../src, ../apps/arena, ../apps/host, ../apps/offscreen, ../apps/map, ../apps/predict, ../apps/canary -File -Filter "*.spi" |
    Where-Object { !$Files -or $_.BaseName -in $Files } |
    Where-Object { Select-String -Path $_.FullName -Pattern '^test ' -Quiet } |
    Where-Object { $_.BaseName -notin $Exclude } |
    Where-Object { !$Resume -or !(Select-String -LiteralPath (Join-Path $metrics "$($_.BaseName).out") -Pattern 'spiral-tests total' -Quiet -ErrorAction Ignore) } |
    Sort-Object Name
$labelSuffix = if ($Label -eq 'all') { '' } else { "-$Label" }

$problems = @()
foreach ($source in $sources) {
    $name = $source.BaseName
    $notebook = Join-Path $notebooks "$name.spi.ipynb"
    $env:SPIRAL_WGSL_TIMING_LOG = Join-Path $metrics "wgsl-$name.log"
    Remove-Item $env:SPIRAL_WGSL_TIMING_LOG -ErrorAction Ignore
    $clock = [Diagnostics.Stopwatch]::StartNew()
    $output = Join-Path $metrics "$name.out"
    $cellsMetrics = Join-Path $metrics "cells-$name"
    Remove-Item $cellsMetrics -Recurse -Force -ErrorAction Ignore
    $notebookRun = Start-Process pwsh -ArgumentList (@('-NoProfile', '-File', $runNotebook, '--path', $source.FullName, '--output-path', $notebook, '--no-spi', '--metrics', $cellsMetrics) | ForEach-Object { "`"$_`"" }) `
        -NoNewWindow -PassThru -RedirectStandardOutput $output -RedirectStandardError "$output.err"
    $null = $notebookRun.Handle
    while (!$notebookRun.WaitForExit(60000)) { Write-Output "build.ps1 / $name / running $([int]$clock.Elapsed.TotalSeconds) s / $(Get-Load)" }
    $exitCode = $notebookRun.ExitCode
    $lines = @(Get-Content $output, "$output.err" -ErrorAction Ignore)
    Write-Output "build.ps1 / $name / done in $([int]$clock.Elapsed.TotalSeconds) s / $(Get-Load)"
    $fileRows.Add([pscustomobject]@{ File = $name; Seconds = [math]::Round($clock.Elapsed.TotalSeconds, 1); ExitCode = $exitCode })
    foreach ($row in @(Import-Csv (Join-Path $cellsMetrics 'tests.tsv') -Delimiter "`t" -ErrorAction Ignore)) {
        $testRows.Add([pscustomobject]@{ File = $name; Test = $row.Test; Target = $row.Target; Status = $row.Status; Ms = [int]$row.Ms; Memo = $row.Memo })
    }
    foreach ($line in @(Get-Content $env:SPIRAL_WGSL_TIMING_LOG -ErrorAction Ignore)) {
        $shader, $bytes, $compile, $run, $adapter = $line -split "`t", 5
        $wgslRows.Add([pscustomobject]@{ File = $name; Shader = Split-Path $shader -Leaf; Bytes = $bytes; CompileMs = $compile; RunMs = $run; Adapter = $adapter })
    }
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

$fileRows | ConvertTo-Csv -Delimiter "`t" -UseQuotes Never | Set-Content (Join-Path $metrics "files$labelSuffix.tsv")
$testRows | ConvertTo-Csv -Delimiter "`t" -UseQuotes Never | Set-Content (Join-Path $metrics "tests$labelSuffix.tsv")
$wgslRows | ConvertTo-Csv -Delimiter "`t" -UseQuotes Never | Set-Content (Join-Path $metrics "wgsl$labelSuffix.tsv")
foreach ($row in $wgslRows) { Write-Output "build.ps1 / wgsl / $($row.File) / $($row.Shader) $($row.Bytes) bytes / compile $($row.CompileMs) ms / run $($row.RunMs) ms / $($row.Adapter)" }
if ($env:GITHUB_STEP_SUMMARY) {
    $summary = @("### $Label tests on $platform", "", "$($machine.Cpu), $([Environment]::ProcessorCount) logical cores, $([math]::Round($machine.Memory / 1GB, 1)) GiB, $(@($fileRows).Count) files in $([math]::Round(($fileRows | Measure-Object Seconds -Sum).Sum / 60, 1)) min", "", "| slowest file | s |", "|---|---|")
    $summary += $fileRows | Sort-Object Seconds -Descending | Select-Object -First 8 | ForEach-Object { "| $($_.File) | $($_.Seconds) |" }
    $summary += "", "| slowest test | target | status | s |", "|---|---|---|---|"
    $summary += $testRows | Sort-Object Ms -Descending | Select-Object -First 12 | ForEach-Object { "| $($_.File) / $($_.Test) | $($_.Target) | $($_.Status) | $([math]::Round($_.Ms / 1000, 1)) |" }
    if ($wgslRows) {
        $summary += "", "| wgsl shader | bytes | compile s | run s | adapter |", "|---|---|---|---|---|"
        $summary += $wgslRows | ForEach-Object { "| $($_.File) / $($_.Shader) | $($_.Bytes) | $([math]::Round([int]$_.CompileMs / 1000, 1)) | $([math]::Round([int]$_.RunMs / 1000, 1)) | $($_.Adapter) |" }
    }
    $summary | Add-Content $env:GITHUB_STEP_SUMMARY
}

if (!$sources -and $Resume) { Write-Output "build.ps1 / resume / every matched test file already has a total line in target/ci-metrics"; return }
if (!$sources) { throw "build.ps1 / no test files matched $($Files -join ', ')" }
if ($problems) { throw "build.ps1 / $($problems.Count) of $(@($sources).Count) test files are not fully green:`n$($problems -join "`n")" }
Write-Output "build.ps1 / all $(@($sources).Count) test files green"

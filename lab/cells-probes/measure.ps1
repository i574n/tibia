param(
    [Parameter(Mandatory)] [string] $Label,
    [string] $Source = (Join-Path $PSScriptRoot '../../src'),
    [string[]] $Tests = @('gpu_sim/a_full_troll_hunt_and_five_cyclops_clears_on_gpu', 'gpu_sim/a_hunting_ground_hunt_with_routing_on_gpu', 'hunt_sim/golden_seed_7_on_gpu', 'hunt_sim/scripted_beats_random_control_on_gpu'),
    [ValidateSet('Wgsl', 'C')] [string] $Backend = 'Wgsl',
    [string] $Runner = (Join-Path $PSScriptRoot '../../target/wgsl-run/release/spiral-wgsl.exe'),
    [string] $RunnerLabel = 'gpu',
    [int] $RunTimeoutSec = 900,
    [string[]] $Rewrite = @(),
    [switch] $CompileOnly
)
$ErrorActionPreference = 'Stop'
$runs = Join-Path $env:LOCALAPPDATA "spiral-bin/runs/tibia-wgsl-shader-size/$Label"
New-Item -ItemType Directory -Force $runs | Out-Null
Get-ChildItem $runs -Filter '*.spi' | Remove-Item
Copy-Item (Join-Path $Source '*.spi') $runs
foreach ($r in $Rewrite) {
    $file, $old, $new = $r -split '\|', 3
    $path = Join-Path $runs "$file.spi"
    $text = [IO.File]::ReadAllText($path)
    if (!$text.Contains($old)) { throw "measure.ps1 / rewrite / $file has no $old" }
    [IO.File]::WriteAllText($path, $text.Replace($old, $new))
}

function Get-TestBody([string] $text, [string] $name) {
    $lines = $text -split "`r?`n"
    $start = [Array]::FindIndex($lines, [Predicate[string]] { param($l) $l -match "^test $name =\s*$" })
    if ($start -lt 0) { throw "measure.ps1 / no test $name" }
    $body = foreach ($line in $lines[($start + 1)..($lines.Count - 1)]) { if ($line -match '^\S') { break }; $line }
    ($body -join "`n").TrimEnd()
}

function Get-DefinitionsOnly([string] $text) {
    $kept = [System.Collections.Generic.List[string]]::new()
    $inTest = $false
    foreach ($line in $text -split "`r?`n") {
        if ($line -match '^///') { continue }
        if ($line -match '^test ') { $inTest = $true; continue }
        if ($inTest -and ($line -match '^\s' -or $line -eq '')) { continue }
        $inTest = $false
        $kept.Add($line)
    }
    $kept -join "`n"
}

$modules = (Get-Content (Join-Path $Source 'package.spiproj') | Where-Object { $_ -match '^\s{4}\w' } | ForEach-Object { $_.Trim() })
$entries = foreach ($test in $Tests) {
    $file, $name = $test -split '/'
    $text = [IO.File]::ReadAllText((Join-Path $runs "$file.spi"))
    $opens = ''
    if ($file -notin $modules) {
        $definitions = "${file}_definitions"
        if (!(Test-Path (Join-Path $runs "$definitions.spi"))) {
            [IO.File]::WriteAllText((Join-Path $runs "$definitions.spi"), (Get-DefinitionsOnly $text))
            $modules += $definitions
        }
        $opens = "    open $definitions`n"
    }
    $entry = "entry_$name"
    [IO.File]::WriteAllText((Join-Path $runs "$entry.spi"), "inl main () =`n$opens$(Get-TestBody $text $name)`n")
    $modules += $entry
    [pscustomobject]@{ Test = $test; Entry = $entry }
}
[IO.File]::WriteAllText((Join-Path $runs 'package.spiproj'), "packages: |core-`nmodules:`n$(($modules | ForEach-Object { "    $_" }) -join "`n")`n")

$env:SPIRAL_COMPILER_PACKAGE_DIR = (Join-Path (Resolve-Path (Join-Path $PSScriptRoot '../../deps/spiral')) 'deps/The-Spiral-Language/VS Code Plugin')
$dotnet = Join-Path $env:LOCALAPPDATA 'spiral-bin/toolchains/dotnet/dotnet.exe'
$compiler = Join-Path $env:LOCALAPPDATA 'spiral-bin/bin/single-flight/SpiralCompiler/Release/net11.0/SpiralCompiler.dll'
$extension = if ($Backend -eq 'Wgsl') { 'wgsl' } else { 'c' }
$results = Join-Path $PSScriptRoot 'results.tsv'
if (!(Test-Path $results)) { "at`tlabel`tbackend`trunner`ttest`toutput_bytes`tcompile_s`trun_s`texit" | Set-Content $results }

foreach ($e in $entries) {
    $out = Join-Path $runs "$($e.Entry).$extension"
    Remove-Item $out -ErrorAction Ignore
    $sw = [Diagnostics.Stopwatch]::StartNew()
    & $dotnet $compiler --backend $Backend (Join-Path $runs "$($e.Entry).spi") $out 2>&1 | Select-Object -Last 3 | Write-Host
    $compileSeconds = [math]::Round($sw.Elapsed.TotalSeconds, 1)
    if ($LASTEXITCODE -ne 0 -or !(Test-Path $out)) { throw "measure.ps1 / $($e.Test) / compile failed" }
    $bytes = (Get-Item $out).Length
    $runSeconds, $exit = '', ''
    if (!$CompileOnly) {
        $program, $arguments = if ($Backend -eq 'Wgsl') { $Runner, @("`"$out`"") } else {
            $exe = [IO.Path]::ChangeExtension($out, 'exe')
            $gccSw = [Diagnostics.Stopwatch]::StartNew()
            & gcc -O2 -o $exe $out -lm
            if ($LASTEXITCODE -ne 0) { throw "measure.ps1 / $($e.Test) / gcc failed" }
            $compileSeconds = "$compileSeconds+gcc$([math]::Round($gccSw.Elapsed.TotalSeconds, 1))"
            $exe, @()
        }
        $env:SPIRAL_WGSL_TIMEOUT_SECONDS = "$RunTimeoutSec"
        $sw.Restart()
        $process = Start-Process -FilePath $program -ArgumentList $arguments -NoNewWindow -PassThru
        $null = $process.Handle
        if ($process.WaitForExit($RunTimeoutSec * 1000)) { $exit = $process.ExitCode } else { try { $process.Kill($true) } catch { }; $exit = 'timeout' }
        $runSeconds = [math]::Round($sw.Elapsed.TotalSeconds, 1)
    }
    $row = "$(Get-Date -Format 'yyyy-MM-dd HH:mm')`t$Label`t$Backend`t$(if ($Backend -eq 'Wgsl') { $RunnerLabel } else { 'gcc-O2' })`t$($e.Test)`t$bytes`t$compileSeconds`t$runSeconds`t$exit"
    Add-Content $results $row
    Write-Output $row
}

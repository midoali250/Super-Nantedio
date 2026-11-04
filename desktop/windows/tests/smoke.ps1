param([Parameter(Mandatory=$true)][string]$Executable)
$env:SDL_VIDEODRIVER='dummy'; $env:SDL_AUDIODRIVER='dummy'
$p = Start-Process -FilePath $Executable -ArgumentList '--self-test' -PassThru -Wait
if ($p.ExitCode -ne 0) { throw "Portable EXE self-test failed: $($p.ExitCode)" }
Write-Host 'PASS: portable EXE launched and exercised game core'

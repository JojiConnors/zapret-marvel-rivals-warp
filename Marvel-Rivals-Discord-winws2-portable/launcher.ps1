param(
    [string]$ConfigFile = 'config\marvel-discord.txt'
)

$ErrorActionPreference = 'Stop'

$root = Split-Path -Parent $MyInvocation.MyCommand.Path
$exe = Join-Path $root 'exe\winws2.exe'
$config = Join-Path $root $ConfigFile
$errorLog = Join-Path $root 'last-start-error.txt'
$startupLog = Join-Path $env:TEMP 'Marvel-Rivals-winws2-startup.log'

try {
    Remove-Item -LiteralPath $errorLog -Force -ErrorAction SilentlyContinue
    Remove-Item -LiteralPath $startupLog -Force -ErrorAction SilentlyContinue

    $profileArguments = @(
        Get-Content -LiteralPath $config -ErrorAction Stop |
            ForEach-Object { $_.Trim() } |
            Where-Object { $_ -and -not $_.StartsWith('#') }
    ) -join ' '

    if (-not $profileArguments) {
        throw 'The profile configuration is empty.'
    }

    if ($profileArguments.Length -gt 7000) {
        throw "The direct command line is too long: $($profileArguments.Length) characters."
    }

    $startInfo = [Diagnostics.ProcessStartInfo]::new()
    $startInfo.FileName = "$env:SystemRoot\System32\cmd.exe"
    $quotedExe = '"' + $exe + '"'
    $quotedLog = '"' + $startupLog + '"'
    $startInfo.Arguments = '/d /s /c "' + $quotedExe + ' ' + $profileArguments + ' > ' + $quotedLog + ' 2>&1"'
    $startInfo.WorkingDirectory = $root
    $startInfo.UseShellExecute = $false
    $startInfo.CreateNoWindow = $true

    $wrapper = [Diagnostics.Process]::Start($startInfo)
    Start-Sleep -Seconds 2

    $winws2 = Get-Process -Name 'winws2' -ErrorAction SilentlyContinue
    if (-not $winws2) {
        if (-not $wrapper.HasExited) {
            $wrapper.WaitForExit(3000) | Out-Null
        }

        $exitCode = if ($wrapper.HasExited) { $wrapper.ExitCode } else { -1 }
        $details = if (Test-Path -LiteralPath $startupLog) {
            (Get-Content -LiteralPath $startupLog -Raw -ErrorAction SilentlyContinue).Trim()
        } else {
            ''
        }
        $message = 'winws2 exited during startup. Exit code: ' + $exitCode
        if ($details) {
            $message += [Environment]::NewLine + $details
        }
        Set-Content -LiteralPath $errorLog -Value $message -Encoding UTF8
        Write-Host $message
        exit 1
    }

    exit 0
}
catch {
    $message = 'Failed to launch winws2: ' + $_.Exception.Message
    Set-Content -LiteralPath $errorLog -Value $message -Encoding UTF8
    Write-Host $message
    exit 1
}

@echo off
setlocal
cd /d "%~dp0"

fltmc.exe >nul 2>&1
if errorlevel 1 (
    powershell.exe -NoProfile -ExecutionPolicy Bypass -Command "Start-Process -FilePath '%~f0' -Verb RunAs"
    exit /b
)

tasklist.exe /FI "IMAGENAME eq winws.exe" /NH 2>nul | find.exe /I "winws.exe" >nul
if not errorlevel 1 (
    echo.
    echo Another Zapret 1 profile is running ^(winws.exe^).
    echo Stop it first, then run this file again.
    echo.
    pause
    exit /b 1
)

taskkill.exe /F /IM winws2.exe /T >nul 2>&1
timeout.exe /t 2 /nobreak >nul

echo.
echo WARNING: this test profile processes almost all TCP and UDP traffic.
echo Do not run it together with another Zapret, VPN or WARP.
echo.

set "start_attempt=0"
:retry_start
set /a start_attempt+=1
powershell.exe -NoProfile -ExecutionPolicy Bypass -File "%~dp0launcher.ps1" -ConfigFile "config\all-tcp-udp-test.txt"

if errorlevel 1 (
    if %start_attempt% LSS 3 (
        timeout.exe /t 2 /nobreak >nul
        goto retry_start
    )
    echo.
    echo ERROR: winws2.exe did not start after 3 attempts.
    if exist "%~dp0last-start-error.txt" type "%~dp0last-start-error.txt"
    echo Check Windows Defender or another antivirus if the error repeats.
    echo.
    pause
    exit /b 1
)

echo.
echo ALL TCP and UDP hostfakesplit_multi_syndata test profile is running.
echo Start Steam, Discord and Marvel Rivals normally.
echo Use 2_STOP.bat when you want to turn it off.
echo.
timeout.exe /t 3 /nobreak >nul
exit /b 0

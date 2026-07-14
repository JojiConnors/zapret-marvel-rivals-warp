@echo off
chcp 65001 > nul
title Marvel Rivals via Cloudflare WARP
setlocal EnableDelayedExpansion

fltmc > nul 2>&1
if errorlevel 1 (
    powershell -NoProfile -Command "Start-Process -FilePath '%~f0' -Verb RunAs"
    exit /b
)

cd /d "%~dp0"

set "WARPCLI=C:\Program Files\Cloudflare\Cloudflare WARP\warp-cli.exe"
set "WARPAPP=C:\Program Files\Cloudflare\Cloudflare WARP\Cloudflare WARP.exe"

if not exist "%WARPCLI%" (
    echo ERROR: Cloudflare WARP is not installed.
    echo Run "1 - INSTALL Cloudflare WARP.bat" first.
    pause
    exit /b 1
)

tasklist /FI "IMAGENAME eq winws.exe" | find /I "winws.exe" > nul
if not errorlevel 1 (
    echo ERROR: zapret is already running.
    echo Return to the existing launcher window and press Enter to stop it.
    echo If that window was closed, run "3 - STOP WARP and zapret.bat".
    pause
    exit /b 1
)

echo:
echo Select a zapret profile:
set "profileCount=0"
for %%F in ("%~dp0general*.bat") do if exist "%%~fF" (
    set /a profileCount+=1
    echo   !profileCount!. %%~nxF
    set "profile!profileCount!=%%~nxF"
)

if !profileCount! EQU 0 (
    echo ERROR: No general BAT profiles were found.
    pause
    exit /b 1
)

echo:
set "profileChoice="
set /p "profileChoice=Enter profile number: "

if not defined profileChoice goto invalid_profile
for /f "delims=0123456789" %%A in ("!profileChoice!") do goto invalid_profile
if !profileChoice! LSS 1 goto invalid_profile
if !profileChoice! GTR !profileCount! goto invalid_profile

set "selectedProfile=!profile%profileChoice%!"

echo all>"%~dp0utils\game_filter.enabled"

echo:
echo Starting "!selectedProfile!" with Game Filter TCP and UDP...
call "%~dp0!selectedProfile!"
timeout /t 6 /nobreak > nul

echo Selecting the MASQUE tunnel protocol...
"%WARPCLI%" tunnel protocol set MASQUE

if exist "%WARPAPP%" start "" "%WARPAPP%"

echo Connecting Cloudflare WARP...
"%WARPCLI%" connect
timeout /t 10 /nobreak > nul
"%WARPCLI%" status

echo:
echo If the status above is Connected, launch Marvel Rivals manually from Steam.
echo Keep this window open while you are playing.
echo:
echo When you finish playing, return to this window and press Enter.
echo WARP, Cloudflare One Client, zapret and WinDivert will be stopped.
set /p "stopChoice=Press Enter to stop everything..."

echo:
echo Disconnecting Cloudflare WARP...
if exist "%WARPCLI%" "%WARPCLI%" disconnect

echo Removing zapret and WinDivert services...
call "%~dp0service.bat" remove_services_silent

taskkill /IM "Cloudflare WARP.exe" /F > nul 2>&1

echo Everything has been stopped.
exit

:invalid_profile
echo ERROR: Invalid profile number.
pause
exit /b 1

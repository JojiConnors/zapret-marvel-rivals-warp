@echo off
setlocal
cd /d "%~dp0"

fltmc.exe >nul 2>&1
if errorlevel 1 (
    powershell.exe -NoProfile -ExecutionPolicy Bypass -Command "Start-Process -FilePath '%~f0' -Verb RunAs"
    exit /b
)

taskkill.exe /F /IM winws2.exe /T >nul 2>&1
timeout.exe /t 1 /nobreak >nul
sc.exe stop Monkey >nul 2>&1
sc.exe delete Monkey >nul 2>&1

echo.
echo winws2 and its WinDivert driver have been stopped.
echo.
timeout.exe /t 2 /nobreak >nul
exit /b 0

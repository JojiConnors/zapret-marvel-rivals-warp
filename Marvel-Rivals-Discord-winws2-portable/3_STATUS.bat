@echo off
setlocal

tasklist.exe /FI "IMAGENAME eq winws2.exe" /NH 2>nul | find.exe /I "winws2.exe" >nul
if errorlevel 1 (
    echo winws2 status: STOPPED
    sc.exe query Monkey 2>nul | find.exe /I "RUNNING" >nul
    if errorlevel 1 (
        echo WinDivert capture: STOPPED
    ) else (
        echo WinDivert capture: DRIVER STILL LOADED
    )
) else (
    echo winws2 status: RUNNING
    echo WinDivert capture: ACTIVE
)

echo.
pause

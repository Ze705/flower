@echo off
title AETHERIA - keep this window open
setlocal
cd /d "%~dp0"

set "PORT=8123"

cls
echo ============================================================
echo    AETHERIA  -  No.06 Starlit Ocean Anthesis
echo ============================================================
echo.
echo    Keep this window OPEN. Close it to stop.
echo.
echo    index.html     = local MediaPipe assets  (loads in ~2s)
echo    index-v6.html  = original CDN version    (slow / may hang)
echo.

set "BUSY="
for /f "tokens=5" %%a in ('netstat -ano ^| findstr /R /C:":%PORT% .*LISTENING"') do set "BUSY=%%a"

if defined BUSY (
    echo    Server already running on port %PORT%.
) else (
    set "PY="
    if exist "C:\Users\lenovo\AppData\Local\Programs\DSH Desktop\resources\office-runtime\primary-runtime\dependencies\python\python.exe" (
        set "PY=C:\Users\lenovo\AppData\Local\Programs\DSH Desktop\resources\office-runtime\primary-runtime\dependencies\python\python.exe"
    )
    if not defined PY ( where python >nul 2>nul && set "PY=python" )
    if not defined PY (
        echo  [ERROR] Python not found. Install: https://www.python.org/downloads/
        pause
        exit /b 1
    )
    echo    Starting server...
    start "" /min "%PY%" -m http.server %PORT% --bind 127.0.0.1 --directory "%~dp0"
    timeout /t 2 /nobreak >nul
)

echo    Opening http://127.0.0.1:%PORT%/ ...
start "" msedge "http://127.0.0.1:%PORT%/"
echo.
echo    Camera permission: click ALLOW when asked.
echo.
pause
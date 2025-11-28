@echo off
REM ========================================
REM Quick Connect Script (for paired devices)
REM Default: 192.168.10.43:5555
REM ========================================

echo [RUN] Connecting to 192.168.10.43:5555 ...
adb connect 192.168.10.43:5555

if %errorlevel% neq 0 (
    echo [ERROR] Connection failed!
    echo.
    echo Possible reasons:
    echo 1. Phone and PC not on same WiFi
    echo 2. Wireless debugging not enabled on phone
    echo 3. IP address changed
    echo.
    echo Please use connect_wifi_adb_en.bat to reconfigure.
    pause
    exit /b 1
)

echo [SUCCESS] Connected to device!
echo.
echo [RUN] Querying device info...
adb devices -l

echo.
pause

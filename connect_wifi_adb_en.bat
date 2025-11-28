@echo off
REM ========================================
REM WiFi ADB Quick Connect Script
REM ========================================

setlocal enabledelayedexpansion

echo.
echo ========================================
echo    WiFi ADB Quick Connect Tool
echo ========================================
echo.

where adb >nul 2>&1
if %errorlevel% neq 0 (
    echo [ERROR] ADB command not found!
    pause
    exit /b 1
)

echo Select connection mode:
echo.
echo [1] First-time pairing (need pairing code)
echo [2] Direct connect (already paired)
echo [3] Reconfigure persistent connection (switch to port 5555)
echo [4] Disconnect all
echo [5] List connected devices
echo [0] Exit
echo.

set /p choice=Enter option [0-5]:

if "%choice%"=="1" goto PAIR
if "%choice%"=="2" goto CONNECT
if "%choice%"=="3" goto RECONFIGURE
if "%choice%"=="4" goto DISCONNECT
if "%choice%"=="5" goto LIST_DEVICES
if "%choice%"=="0" goto END
echo [ERROR] Invalid option!
pause
exit /b 1

:PAIR
echo.
echo ========================================
echo    First-time Pairing Mode
echo ========================================
echo.
echo On your phone:
echo 1. Open Settings - Developer Options - Wireless Debugging
echo 2. Click "Pair device with pairing code"
echo 3. Note the IP address, port and pairing code
echo.

set /p pair_ip=Enter pairing IP (e.g. 192.168.10.43):
set /p pair_port=Enter pairing port (e.g. 33095):
set /p pair_code=Enter pairing code (6 digits):

echo.
echo [RUN] Pairing to %pair_ip%:%pair_port% ...
adb pair %pair_ip%:%pair_port% %pair_code%

if %errorlevel% neq 0 (
    echo [ERROR] Pairing failed!
    pause
    exit /b 1
)

echo.
echo [SUCCESS] Pairing completed!
echo.
set /p connect_port=Enter connection port (usually 5555):

echo.
echo [RUN] Connecting to %pair_ip%:%connect_port% ...
adb connect %pair_ip%:%connect_port%

if %errorlevel% neq 0 (
    echo [ERROR] Connection failed!
    pause
    exit /b 1
)

echo.
echo [SUCCESS] Connected to device!
goto SHOW_DEVICES

:CONNECT
echo.
echo ========================================
echo    Direct Connect Mode
echo ========================================
echo.

set /p connect_ip=Enter device IP (e.g. 192.168.10.43):
set /p connect_port=Enter port (default 5555):

if "%connect_port%"=="" set connect_port=5555

echo.
echo [RUN] Connecting to %connect_ip%:%connect_port% ...
adb connect %connect_ip%:%connect_port%

if %errorlevel% neq 0 (
    echo [ERROR] Connection failed!
    pause
    exit /b 1
)

echo.
echo [SUCCESS] Connected to device!
goto SHOW_DEVICES

:RECONFIGURE
echo.
echo ========================================
echo    Reconfigure Persistent Connection (Port 5555)
echo ========================================
echo.

echo [RUN] Checking current devices...
adb devices -l

echo.
set /p confirm=Confirm reconfiguration? (Y/N):
if /i not "%confirm%"=="Y" (
    echo [CANCEL] Operation cancelled.
    pause
    exit /b 0
)

echo.
echo [RUN] Switching to TCP/IP mode (port 5555)...
adb tcpip 5555

if %errorlevel% neq 0 (
    echo [ERROR] Switch failed!
    pause
    exit /b 1
)

timeout /t 2 /nobreak >nul

echo.
echo [RUN] Disconnecting current connection...
adb disconnect

echo.
set /p reconfig_ip=Enter device IP (e.g. 192.168.10.43):

echo.
echo [RUN] Reconnecting via port 5555...
adb connect %reconfig_ip%:5555

if %errorlevel% neq 0 (
    echo [ERROR] Reconnection failed!
    pause
    exit /b 1
)

echo.
echo [SUCCESS] Persistent connection configured!
goto SHOW_DEVICES

:DISCONNECT
echo.
echo ========================================
echo    Disconnect All
echo ========================================
echo.

echo [RUN] Disconnecting all ADB connections...
adb disconnect

echo.
echo [DONE] All connections disconnected.
goto SHOW_DEVICES

:LIST_DEVICES
echo.
echo ========================================
echo    Connected Devices List
echo ========================================
echo.

:SHOW_DEVICES
echo [RUN] Querying connected devices...
adb devices -l

echo.
echo ========================================
echo    Flutter Devices List
echo ========================================
echo.

where flutter >nul 2>&1
if %errorlevel% equ 0 (
    flutter devices
) else (
    echo [INFO] Flutter command not found.
)

echo.
pause
goto END

:END
echo.
echo Thank you for using!
echo.
endlocal
exit /b 0

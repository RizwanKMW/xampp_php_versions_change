@echo off
setlocal EnableExtensions
cd /d "%~dp0"

set "APACHE_CONF=C:\xampp\apache\conf\extra\httpd-xampp.conf"
set "MODE=menu"
set "TARGET="

if /I "%~1"=="74" set "TARGET=74" & set "MODE=auto" & goto switchTo
if /I "%~1"=="82" set "TARGET=82" & set "MODE=auto" & goto switchTo
if /I "%~1"=="85" set "TARGET=85" & set "MODE=auto" & goto switchTo
if /I "%~1"=="status" goto showStatusAndExit

:menu
cls
echo ==========================================
echo           XAMPP PHP Version Switcher
echo ==========================================
echo Current Apache PHP version:
call :showCurrent
echo.
echo 1. Switch to PHP 7.4
echo 2. Switch to PHP 8.2
echo 3. Switch to PHP 8.5
echo 4. Show current version
echo 5. Exit
echo.
set /p choice=Choose an option [1-5]:

if "%choice%"=="1" set "TARGET=74" & goto switchTo
if "%choice%"=="2" set "TARGET=82" & goto switchTo
if "%choice%"=="3" set "TARGET=85" & goto switchTo
if "%choice%"=="4" (
    echo.
    call :showCurrent
    echo.
    pause
    goto menu
)
if "%choice%"=="5" goto end

echo.
echo Invalid choice.
pause
goto menu

:showStatusAndExit
call :showCurrent
goto end

:switchTo
if "%TARGET%"=="74" goto set74
if "%TARGET%"=="82" goto set82
if "%TARGET%"=="85" goto set85

echo Unknown target version.
if /I "%MODE%"=="auto" goto end
pause
goto menu

:set74
call :writeActiveConf 74
echo.
echo Apache is now configured to use PHP 7.4.
goto restartPrompt

:set82
if not exist "C:\xampp\php82\php.ini" (
    echo C:\xampp\php82\php.ini is missing.
    if /I "%MODE%"=="auto" goto end
    pause
    goto menu
)

call :writeActiveConf 82
echo.
echo Apache is now configured to use PHP 8.2.
goto restartPrompt

:set85
if not exist "C:\xampp\php85\php.ini" (
    echo C:\xampp\php85\php.ini is missing.
    if /I "%MODE%"=="auto" goto end
    pause
    goto menu
)

call :writeActiveConf 85
echo.
echo Apache is now configured to use PHP 8.5.
goto restartPrompt

:writeActiveConf
> "%APACHE_CONF%" (
    echo #
    echo # Active PHP config for XAMPP Apache.
    echo # Managed by C:\xampp\switch-php.bat
    echo #
    echo.
    echo Include "conf/extra/httpd-xampp-php%~1.conf"
)
goto :eof

:showCurrent
findstr /C:"httpd-xampp-php85.conf" "%APACHE_CONF%" >nul 2>&1 && echo PHP 8.5 && goto :eof
findstr /C:"httpd-xampp-php82.conf" "%APACHE_CONF%" >nul 2>&1 && echo PHP 8.2 && goto :eof
findstr /C:"httpd-xampp-php74.conf" "%APACHE_CONF%" >nul 2>&1 && echo PHP 7.4 && goto :eof
echo Unknown
goto :eof

:restartPrompt
if /I "%MODE%"=="auto" goto end

echo.
choice /C YN /M "Restart Apache now"
if errorlevel 2 goto menu

call "C:\xampp\apache_stop.bat"
timeout /t 2 /nobreak >nul
start "XAMPP Apache" /MIN cmd /c "C:\xampp\apache_start.bat"
echo Apache restart command sent.

echo.
pause
goto menu

:end
endlocal
exit /b 0

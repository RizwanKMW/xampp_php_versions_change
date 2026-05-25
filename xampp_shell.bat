@ECHO OFF
GOTO weiter
:setenv
SET "PHP_DIR=%~dp0php74"
findstr /C:"httpd-xampp-php85.conf" "%~dp0apache\conf\extra\httpd-xampp.conf" >nul 2>&1 && SET "PHP_DIR=%~dp0php85"
findstr /C:"httpd-xampp-php82.conf" "%~dp0apache\conf\extra\httpd-xampp.conf" >nul 2>&1 && SET "PHP_DIR=%~dp0php82"
SET "MIBDIRS=%PHP_DIR%\extras\mibs"
SET "MIBDIRS=%MIBDIRS:\=/%"
SET "MYSQL_HOME=%~dp0mysql\bin"
SET "OPENSSL_CONF=%~dp0apache\conf\openssl.cnf"
SET "OPENSSL_CONF=%OPENSSL_CONF:\=/%"
SET "PHP_PEAR_SYSCONF_DIR=%PHP_DIR%"
SET "PHP_PEAR_BIN_DIR=%PHP_DIR%"
SET "PHP_PEAR_TEST_DIR=%PHP_DIR%\tests"
SET "PHP_PEAR_WWW_DIR=%PHP_DIR%\www"
SET "PHP_PEAR_CFG_DIR=%PHP_DIR%\cfg"
SET "PHP_PEAR_DATA_DIR=%PHP_DIR%\data"
SET "PHP_PEAR_DOC_DIR=%PHP_DIR%\docs"
SET "PHP_PEAR_PHP_BIN=%PHP_DIR%\php.exe"
SET "PHP_PEAR_INSTALL_DIR=%PHP_DIR%\pear"
SET "PHPRC=%PHP_DIR%"
SET "TMP=%~dp0tmp"
SET "PERL5LIB="
SET "Path=;%~dp0;%PHP_DIR%;%~dp0perl\site\bin;%~dp0perl\bin;%~dp0apache\bin;%~dp0mysql\bin;%~dp0FileZillaFTP;%~dp0MercuryMail;%~dp0sendmail;%~dp0webalizer;%~dp0tomcat\bin;%Path%"
ver >nul
GOTO :EOF
:weiter

IF "%1" EQU "setenv" (
    ECHO.
    ECHO Setting environment for using XAMPP for Windows.
    CALL :setenv
) ELSE (
    SETLOCAL
    TITLE XAMPP for Windows
    PROMPT %username%@%computername%$S$P$_#$S
    START "" /B %COMSPEC% /K "%~f0" setenv
)


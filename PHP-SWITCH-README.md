# XAMPP PHP Switch Guide

This XAMPP setup lets you switch Apache between multiple PHP folders without editing Apache config by hand each time.

Current folders in this setup:

- `C:\xampp\php74`
- `C:\xampp\php82`
- `C:\xampp\php85`



## What Was Changed

These files were added or updated:

- `C:\xampp\switch-php.bat`
- `C:\xampp\apache\conf\extra\httpd-xampp.conf`
- `C:\xampp\apache\conf\extra\httpd-xampp-php74.conf`
- `C:\xampp\apache\conf\extra\httpd-xampp-php82.conf`
- `C:\xampp\apache\conf\extra\httpd-xampp-php85.conf`
- `C:\xampp\xampp_shell.bat`
- `C:\xampp\php74\php.ini`
- `C:\xampp\php82\php.ini`
- `C:\xampp\php85\php.ini`

## How Switching Works

Apache reads:

- `C:\xampp\apache\conf\extra\httpd-xampp.conf`

That file includes one active PHP config:

- `httpd-xampp-php74.conf`
- or `httpd-xampp-php82.conf`
- or `httpd-xampp-php85.conf`

The switcher changes only that include target.

## How To Switch PHP

Interactive menu:

```bat
C:\xampp\switch-php.bat
```

Direct command:

```bat
C:\xampp\switch-php.bat 74
C:\xampp\switch-php.bat 82
C:\xampp\switch-php.bat 85
C:\xampp\switch-php.bat status
```

After switching, restart Apache if it is already running.

Restart from batch files:

```bat
C:\xampp\apache_stop.bat
C:\xampp\apache_start.bat
```

Or restart from XAMPP Control Panel.

## How To Use xampp_shell.bat

Run:

```bat
C:\xampp\xampp_shell.bat
```

This opens a shell with XAMPP-related environment variables.

In this setup, `xampp_shell.bat` was updated so it checks the active Apache PHP config and points shell variables to:

- `C:\xampp\php74`
- `C:\xampp\php82`
- `C:\xampp\php85`

Useful test inside the shell:

```bat
php -v
```

If `php` is not recognized in your current terminal, open `xampp_shell.bat` first instead of a normal Command Prompt.

## Environment Variables Used By xampp_shell.bat

The shell sets values like:

- `PHPRC`
- `PHP_PEAR_PHP_BIN`
- `PHP_PEAR_INSTALL_DIR`
- `Path`

These are temporary for that shell window only.

If you close the shell, those temporary environment variables are gone.

## How To Add Another PHP Version

Example: add `php83`

1. Extract PHP into:

   `C:\xampp\php83`

2. Make sure the folder contains at least:

- `php.exe`
- `ext\`
- `php.ini` or a template you can turn into `php.ini`
- the Apache module DLL:
  - `php7apache2_4.dll` for PHP 7 builds
  - `php8apache2_4.dll` for PHP 8 builds

3. Create a new Apache config file based on an existing one:

   Copy one of:

- `C:\xampp\apache\conf\extra\httpd-xampp-php74.conf`
- `C:\xampp\apache\conf\extra\httpd-xampp-php82.conf`

   Then rename it, for example:

   `C:\xampp\apache\conf\extra\httpd-xampp-php83.conf`

4. Edit the paths inside that new file so they point to `C:\xampp\php83`.

5. Add a `php.ini` inside `C:\xampp\php83` and make sure:

- `extension_dir` points to `C:\xampp\php83\ext`
- `curl.cainfo` points to `C:\xampp\php83\cacert.pem` if present
- `openssl.cafile` points to `C:\xampp\php83\cacert.pem` if present

6. Update `C:\xampp\switch-php.bat` to add:

- a menu option
- a direct command option
- a `showCurrent` check
- a `switchTo` branch


### If You Reinstall XAMPP Best Safe Backup Before Reinstall

Copy these somewhere safe:

- `C:\xampp\switch-php.bat`
- `C:\xampp\PHP-SWITCH-README.md`
- `C:\xampp\xampp_shell.bat`
- `C:\xampp\apache\conf\extra\httpd-xampp.conf`
- `C:\xampp\apache\conf\extra\httpd-xampp-php74.conf`
- `C:\xampp\apache\conf\extra\httpd-xampp-php82.conf`
- `C:\xampp\apache\conf\extra\httpd-xampp-php85.conf`
- `C:\xampp\php74`
- `C:\xampp\php82`
- `C:\xampp\php85`

### After Reinstall

1. Install XAMPP normally.
2. Restore your `php74`, `php82`, or other custom PHP folders back into `C:\xampp`.
3. Restore these config files:

- `switch-php.bat`
- `xampp_shell.bat`
- `apache\conf\extra\httpd-xampp.conf`
- `apache\conf\extra\httpd-xampp-php74.conf`
- `apache\conf\extra\httpd-xampp-php82.conf`
- `apache\conf\extra\httpd-xampp-php85.conf`

4. Run:

```bat
C:\xampp\switch-php.bat status
```

5. Test Apache config:

```bat
C:\xampp\apache\bin\httpd.exe -t
```

6. Restart Apache.

## If You Want Global Windows PHP

If you want `php` to work in a normal terminal without opening `xampp_shell.bat`, add only one PHP folder to Windows `Path` at a time, for example:

- `C:\xampp\php74`
- or `C:\xampp\php82`
- or `C:\xampp\php85`

Also set:

- `PHPRC=C:\xampp\php74`
- or `PHPRC=C:\xampp\php82`
- or `PHPRC=C:\xampp\php85`

Do not add both PHP folders to `Path` together.

```

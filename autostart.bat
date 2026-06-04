@echo off
:: Get the absolute path of the executable in the same directory
set "EXE_PATH=%~dp0german_chars.exe"

:: Check if the executable exists
if not exist "%EXE_PATH%" (
    echo [ERROR] GermanChars executable not found at:
    echo "%EXE_PATH%"
    echo.
    echo Please ensure "german_chars.exe" is in the same directory as this script.
    pause
    exit /b 1
)

:: Add the executable to HKCU startup run key
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Run" /v "GermanChars" /t REG_SZ /d "\"%EXE_PATH%\"" /f

if %errorlevel% equ 0 (
    echo [SUCCESS] Auto launch set successfully!
    echo "%EXE_PATH%" will now start automatically when Windows boots.
) else (
    echo [ERROR] Failed to set auto launch.
)
pause

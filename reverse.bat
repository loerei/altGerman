@echo off
:: Remove the registry entry from HKCU startup run key
reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\Run" /v "GermanChars" /f

if %errorlevel% equ 0 (
    echo [SUCCESS] Auto launch removed successfully!
    echo "german_chars.exe" will no longer start when Windows boots.
) else (
    echo [WARNING] Startup registry key "GermanChars" was not found or could not be deleted.
)
pause

@echo off 

:main_menu
echo Select an option:
echo 1. Remove Windows Watermark
echo 2. Remove "Learn more" Feature
echo 3. Exit

:: Get user input
choice /c 123 /m "Enter your choice: "

:: Process user input
if %errorlevel% equ 1 (
    call :remove_watermark
    
)
if %errorlevel% equ 2 (
    call :remove_learn_more
    
)
if %errorlevel% equ 3 (
    exit /b
)

:restart
echo Restart required! Changes will take effect after rebooting.
echo Do you want to restart now?

choice /c YN /m "Press Y to restart, N to cancel: "

if %errorlevel% equ 1 (
    C:\Windows\System32\shutdown.exe /r /t 0 /c "Changes applied. Please restart your computer."
) else (
    echo Restart cancelled. No changes will take effect until you manually restart.
    goto :main_menu
)

:remove_watermark
@echo --------------------------------------------------------------------------- Removing Windows Watermark
pause 
timeout 2 >nul

reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\svsvc" /v Start /t REG_DWORD /d 4 /f
taskkill /F /IM svsvc.exe /T /PID (for /f %%a in ('tasklist ^| findstr /B /I svsvc') do echo %%a) 2>nul

@echo --------------------------------------------------------------------------- Operation completed
pause
call :restart 


:remove_learn_more
@echo --------------------------------------------------------------------------- Removing "Learn more" Feature
pause 
timeout 2 >nul

set learn_feature_path="HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel"

powershell -Command "if (!(Test-Path '$learn_feature_path')) { New-Item -Path '$learn_feature_path' -Force }"
powershell -Command "if (!(Test-Path '$learn_feature_path')) { Set-ItemProperty -Path '$learn_feature_path' -Name '{2cc5ca98-6485-489a-920e-b3e88a6ccce3}' -Value 1 -Type DWORD -Force }"

@echo --------------------------------------------------------------------------- Operation completed
pause
call :restart 

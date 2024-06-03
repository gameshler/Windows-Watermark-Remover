@echo off 
@echo --------------------------------------------------------------------------- Removing Windows Watermark
pause 
timeout 2 >nul
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\svsvc" /v Start /t REG_DWORD /d 4 /f
taskkill /F /IM svsvc.exe /T /PID (for /f %%a in ('tasklist ^| findstr /B /I svsvc') do echo %%a) 2>nul
@echo --------------------------------------------------------------------------- Restart PC
pause
C:\Windows\System32\shutdown.exe /r /t 0

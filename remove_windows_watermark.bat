@echo off 
@echo --------------------------------------------------------------------------- Removing Windows Watermark
pause 
timeout 2 >nul
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\svsvc" /v Start /t REG_DWORD /d 4 /f
@echo --------------------------------------------------------------------------- Restart PC
pause
C:\Windows\System32\shutdown.exe /r /t 0

@echo off
:1
tasklist /FI "IMAGENAME eq SERVER32.EXE" 2>NUL | find /I /N "SERVER32.EXE">NUL
if NOT "%ERRORLEVEL%" == "0" start "" "SERVER32.EXE"
goto :1
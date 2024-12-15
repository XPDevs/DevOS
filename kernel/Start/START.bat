@echo off
:RER
cls
cd ..
cd NexShell
cd build
set "FILE=BET.cfg"
title %FILE%
if not exist "%FILE%" (
    goto :e
)
:: Loop through each line of the file and execute it
for /f "delims=" %%a in (%FILE%) do (
    call %%a 
)
:FIND
cd ..
:: Set environment variable STARTINI (optional)
set "STARTINI=INI"

:: Check if NexShell.bat exists
if exist "NexShell.bat" (
    :: Execute the commands in NexShell.bat
call "NexShell.bat"
    )
) else (
:e
echo Error starting NexShell Retrying..
timeout/t 5 /nobreak >nul
)
goto :FIND
@echo off
:UPDATE
cls
cd uds
call "update.bat"
cd ..
goto :RESTARTK

:RESTARTK
cd Start
call "START.bat"
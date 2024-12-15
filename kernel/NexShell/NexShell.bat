@echo off
cls
color 70
timeout/t 5 /nobreak >nul
setlocal enabledelayedexpansion
set "error=0x00000897"
:: Define a variable to check if INI is set
if "%STARTINI%"=="INI" (
    timeout /t 2 /nobreak >nul
    color 07
    goto :start-org
) else (
    color 07
    goto :kernel_error_log
)



:: Start of the configuration process
:start-org
color 07
cls
set "FILE-ORG=NexShell"
set "FILE=config.cfg"
title KERNEL Build: %BUILD%
cd ..
if not exist config (
    mkdir config
)
cd config

if not exist config.cfg (
    rem Write the lines to the file
    (
    echo set "error=0x000000940"
    echo set "FILE-ORG=config.nexs"
    echo echo Hello, World
	echo pause
    ) > config.cfg
)
:: Check if the %FILE% file exists
if not exist "%FILE%" (
    goto :kernel_error_log
)
:FILE
if "%UDS%"=="TRUE" (
goto :UDS
) else (
goto :FILED
)
:FILED
title %FILE%
if not exist "%FILE%" (
    goto :kernel_error_log
)
:: Loop through each line of the file and execute it
for /f "delims=" %%a in (%FILE%) do (
    call %%a 
)
goto :FILE
::
::
::
:kernel_error_log
color 07
cls
if not exist var (
mkdir var
cd var
) else (
cd var
)
if not exist logs (
mkdir logs
cd logs
) else (
cd logs
)
echo Source file: %FILE% %DATE% %TIME% %error% Original file: %FILE-ORG% >>kerneler.log
cd ..
if not exist crash (
mkdir crash
cd crash
) else (
cd crash
)
:kernel_file_var
title %FILE%
:kernel_error_view

REM Define the messages
set "LINE1=Serious Kernel Error!"
set "LINE2=  Error:%error%"
set "LINE3=        /\"
set "LINE4=       /  \"
set "LINE5=      /____\"
set "message1=%LINE1%"
set "message2=%LINE2%"
set "message3=%LINE3%"
set "message4=%LINE4%"
set "message5=%LINE5%"

REM Get the screen dimensions
for /F "tokens=2 delims=: " %%A in ('mode con ^| find "Columns"') do set /A screenWidth=%%A
for /F "tokens=2 delims=: " %%A in ('mode con ^| find "Lines"') do set /A screenHeight=%%A

REM Calculate the length of the first message
set /A msgLength1=0
for /L %%A in (0,1,100) do (
    if "!message1:~%%A,1!"=="" goto msgLength1Done
    set /A msgLength1+=1
)
:msgLength1Done

REM Calculate the length of the second message
set /A msgLength2=0
for /L %%A in (0,1,100) do (
    if "!message2:~%%A,1!"=="" goto msgLength2Done
    set /A msgLength2+=1
)
:msgLength2Done

REM Calculate the length of the third message
set /A msgLength3=0
for /L %%A in (0,1,100) do (
    if "!message3:~%%A,1!"=="" goto msgLength3Done
    set /A msgLength3+=1
)
:msgLength3Done

REM Calculate the length of the fourth message
set /A msgLength4=0
for /L %%A in (0,1,100) do (
    if "!message4:~%%A,1!"=="" goto msgLength4Done
    set /A msgLength4+=1
)
:msgLength4Done

REM Calculate the length of the fifth message
set /A msgLength5=0
for /L %%A in (0,1,100) do (
    if "!message5:~%%A,1!"=="" goto msgLength5Done
    set /A msgLength5+=1
)
:msgLength5Done

REM Calculate the maximum message length
if %msgLength1% gtr %msgLength2% (
    set /A maxMsgLength=%msgLength1%
) else (
    set /A maxMsgLength=%msgLength2%
)
if %msgLength3% gtr %maxMsgLength% (
    set /A maxMsgLength=%msgLength3%
)
if %msgLength4% gtr %maxMsgLength% (
    set /A maxMsgLength=%msgLength4%
)
if %msgLength5% gtr %maxMsgLength% (
    set /A maxMsgLength=%msgLength5%
)

REM Calculate the horizontal padding
set /A padLeft=(screenWidth - maxMsgLength) / 2

REM Calculate the vertical padding (adjusting to center five lines)
set /A padTop=(screenHeight - 5) / 2

REM Display blank lines to move text down to the center
for /L %%A in (1,1,%padTop%) do echo.

REM Create the padding spaces
set "spaces="
for /L %%A in (1,1,%padLeft%) do set "spaces=!spaces! "

REM Display the messages
setlocal EnableDelayedExpansion
REM Warning message
echo.!spaces!%message1%
call :c 07 "!spaces!"&call :c 04 "%message2%" /n
echo.
REM Triangle ascii art 
call :c 07 "!spaces!"&call :c 04 "%message3%" /n
call :c 07 "!spaces!"&call :c 04 "%message4%" /n
call :c 07 "!spaces!"&call :c 04 "%message5%" /n

:kernel_restart
cd ..
cd ..
if not exist NexShell (
mkdir NexShell
cd NexShell
) else (
cd NexShell
)
timeout/t 15 /nobreak >nul
cls
goto :FILE
pause

:UDS
cd uds
call "uds.bat"
goto :FILEC
::::::::::::::::::::::THE START OF THE NOZONE::::::::::::::::::::::::::::::


::::::::::::::::::::::::THE END OF THE NOZONE::::::::::::::::::::::::::::::
:c
setlocal enableDelayedExpansion
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

:colorPrint Color  Str  [/n]
setlocal
set "s=%~2"
call :colorPrintVar %1 s %3
exit /b

:colorPrintVar  Color  StrVar  [/n]
if not defined DEL call :initColorPrint
setlocal enableDelayedExpansion
pushd .
':
cd \
set "s=!%~2!"
:: The single blank line within the following IN() clause is critical - DO NOT REMOVE
for %%n in (^"^

^") do (
  set "s=!s:\=%%~n\%%~n!"
  set "s=!s:/=%%~n/%%~n!"
  set "s=!s::=%%~n:%%~n!"
)
for /f delims^=^ eol^= %%s in ("!s!") do (
  if "!" equ "" setlocal disableDelayedExpansion
  if %%s==\ (
    findstr /a:%~1 "." "\'" nul
    <nul set /p "=%DEL%%DEL%%DEL%"
  ) else if %%s==/ (
    findstr /a:%~1 "." "/.\'" nul
    <nul set /p "=%DEL%%DEL%%DEL%%DEL%%DEL%"
  ) else (
    >colorPrint.txt (echo %%s\..\')
    findstr /a:%~1 /f:colorPrint.txt "."
    <nul set /p "=%DEL%%DEL%%DEL%%DEL%%DEL%%DEL%%DEL%"
  )
)
if /i "%~3"=="/n" echo(
popd
exit /b


:initColorPrint
for /f %%A in ('"prompt $H&for %%B in (1) do rem"') do set "DEL=%%A %%A"
<nul >"%temp%\'" set /p "=."
subst ': "%temp%" >nul
exit /b


:cleanupColorPrint
2>nul del "%temp%\'"
2>nul del "%temp%\colorPrint.txt
>nul subst ': /d
pause

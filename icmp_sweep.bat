@echo off
set "host=192.168.1."

setlocal enabledelayedexpansion
for /L %%A IN (1,1,255) DO (
    set "ip=!host!%%A"

    set i=1
    echo Probing host [ !ip! ] with an ICMP-Echo packet...
    for /f "tokens=*" %%B in ('ping !ip! -n 1 -w 1500') do (
        set/a i=!i!+1
        if !i! EQU 5 (
            set "result=%%B"
        )
    )
    
    Echo.!result! | findstr /C:"Lost = 0">nul && (
        echo HOST ONLINE : !ip!>>result.txt
    ) || (
        REM offline host
    )
)
endlocal
exit /B

@echo off
color 0a
cls

echo.
echo.
echo.
set /p theHost="   Enter hostname or IP Address: "
echo.
echo.
echo Pinging host %theHost%
echo.
echo.

:label
ping -n 1 %theHost% | findstr "TTL=" > nul
if errorlevel == 1 (
    echo %theHost% is down
) else (
    echo %theHost% is UP
)
goto :label

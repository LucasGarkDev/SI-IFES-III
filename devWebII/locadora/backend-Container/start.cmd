@echo off
:repeat
    echo.
    echo Restarting backend...
    gradlew clean bootRun --no-daemon --info
goto repeat
pause
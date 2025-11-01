@echo off
git reset --hard HEAD
git pull

set "id=%random%"
 gradlew clean bootRun --no-daemon --info >> %random%-WINDOWS-SERVER-%COMPUTERNAME%.txt 2>&1
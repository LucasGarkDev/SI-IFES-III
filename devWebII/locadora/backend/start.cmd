@echo off
git reset --hard HEAD
git pull

set "id=%random%"
 gradlew clean bootRun --no-daemon --info >> %random%-WINDOWS-SERVER-%COMPUTERNAME%.txt 2>&1
 git add *.txt
git commit -m "WINDOWS SERVER CRASH LOGS"
git pull
git push origin main
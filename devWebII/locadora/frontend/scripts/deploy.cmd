@echo off
setlocal

rem Atualiza o repositório
git pull

rem Adiciona logs e envia para o GitHub
git add *.txt
git commit -m "FRONTEND - WINDOWS SERVER CRASH LOGS"
git push origin main

rem Executa o servidor e gera log único
set "id=%random%"
set NO_COLOR=1 && npm run dev >> "%id%-WINDOWS-SERVER-%COMPUTERNAME%.txt" 2>&1

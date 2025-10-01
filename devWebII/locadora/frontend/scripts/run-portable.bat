@echo off
set NODE_PATH=%~dp0..\node-v24.8.0-win-x64
echo %NODE_PATH%
set PATH=%NODE_PATH%;%NODE_PATH%\node_modules\npm\bin;%PATH%

echo Usando Node.js portátil:
@REM "%NODE_PATH%"\node.exe -v
@REM "%NODE_PATH%"\npm.cmd -v

echo Iniciando projeto...
"%NODE_PATH%"\npm.cmd run dev

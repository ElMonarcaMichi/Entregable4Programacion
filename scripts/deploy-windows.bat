@echo off
echo Iniciando deploy en Windows...

REM Detener app previa
taskkill /IM java.exe /F 2>nul

REM Iniciar nueva versión
start "" java -jar app.jar

echo Deploy Windows completado.

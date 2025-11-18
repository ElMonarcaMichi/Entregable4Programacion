@echo off
echo Iniciando deploy en Windows...

REM Navegar al directorio raíz del proyecto
cd /d "%~dp0.."

REM Ejecutar tests
echo Ejecutando tests...
call mvn test
if %errorlevel% neq 0 (
    echo Tests fallaron. Abortando deploy.
    pause
    exit /b %errorlevel%
)

echo Tests exitosos. Iniciando aplicacion...

REM Detener app previa si está corriendo
for /f "tokens=5" %%a in ('netstat -aon ^| find ":9090" ^| find "LISTENING"') do taskkill /F /PID %%a 2>nul

REM Iniciar aplicación con Spring Boot
call mvn spring-boot:run

echo Deploy Windows completado.

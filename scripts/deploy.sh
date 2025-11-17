#!/bin/bash
set -x

echo "Iniciando deploy en Linux/Mac..."

APP_PATH="/var/jenkins_home/workspace/Entregable4/deploy/app.jar"
LOG_PATH="/var/jenkins_home/workspace/Entregable4/app.log"

echo "Matando procesos viejos..."
pkill -f app.jar || true

echo "Levantando app..."
# Lanzar la app y mantenerla en foreground para que Jenkins vea la salida
java -jar "$APP_PATH" > "$LOG_PATH" 2>&1 &
APP_PID=$!
echo "App lanzada con PID $APP_PID"

# Esperar unos segundos y mostrar las primeras líneas del log
sleep 5
tail -n 20 "$LOG_PATH"

echo "Deploy terminado"

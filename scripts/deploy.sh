#!/bin/bash

APP_PATH="/var/jenkins_home/workspace/Entregable4/deploy/app.jar"
LOG_PATH="/var/jenkins_home/workspace/Entregable4/app.log"

echo "Matando procesos viejos..."
pkill -f app.jar || true

echo "Levantando app..."
# Desligar del shell padre usando setsid o & con redirección
setsid java -jar "$APP_PATH" > "$LOG_PATH" 2>&1 < /dev/null &

echo "App lanzada en background. Logs en $LOG_PATH"

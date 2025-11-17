#!/bin/bash
echo "Iniciando deploy en Linux/Mac..."

APP_PATH="/var/jenkins_home/workspace/Entregable4/deploy/app.jar"
LOG_PATH="/var/jenkins_home/workspace/Entregable4/app.log"

echo "Matando procesos viejos..."
pkill -f app.jar || true

echo "Levantando app..."
nohup java -jar "$APP_PATH" > "$LOG_PATH" 2>&1 &
disown
echo "Deploy terminado"

#!/bin/bash
set -x   # Muestra cada comando que se ejecuta
echo "Iniciando deploy en Linux/Mac..."

APP_PATH="/var/jenkins_home/workspace/Entregable4/deploy/app.jar"
LOG_PATH="/var/jenkins_home/workspace/Entregable4/app.log"

echo "Verificando si el puerto 9090 está libre..."
lsof -i :9090 || echo "Puerto 9090 libre, seguimos..."

echo "Matando procesos viejos..."
pkill -f app.jar || true

echo "Levantando app..."
nohup java -jar "$APP_PATH" > "$LOG_PATH" 2>&1 &

echo "Deploy terminado. Logs en $LOG_PATH"
tail -n 20 "$LOG_PATH"  # Muestra las últimas 20 líneas del log

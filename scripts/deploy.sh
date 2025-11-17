#!/bin/bash
# deploy.sh - Lanzamiento persistente de la app

APP_PATH="/var/jenkins_home/workspace/Entregable4/deploy/app.jar"
LOG_PATH="/var/jenkins_home/deploy_logs/app.log"
PID_PATH="/var/jenkins_home/deploy_logs/app.pid"

mkdir -p "$(dirname "$LOG_PATH")"

echo "Iniciando deploy persistente..."

# Si hay un PID viejo, matamos el proceso
if [ -f "$PID_PATH" ]; then
    OLD_PID=$(cat "$PID_PATH")
    if ps -p $OLD_PID > /dev/null 2>&1; then
        echo "Matando proceso viejo con PID $OLD_PID"
        kill $OLD_PID
        sleep 2
    fi
fi

# Levantamos la app en segundo plano y guardamos el PID
nohup java -jar "$APP_PATH" > "$LOG_PATH" 2>&1 &

NEW_PID=$!
echo $NEW_PID > "$PID_PATH"

echo "App lanzada con PID $NEW_PID"
echo "Logs en $LOG_PATH"
echo "Deploy terminado"

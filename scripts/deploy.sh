#!/bin/bash

# -----------------------------
# Deploy script para Jenkins
# -----------------------------

echo "=== Iniciando deploy desde Jenkins ==="

# Rutas absolutas
APP_PATH="/var/jenkins_home/workspace/Entregable4/deploy/app.jar"
LOG_PATH="/var/jenkins_home/workspace/Entregable4/app.log"
PID_PATH="/var/jenkins_home/workspace/Entregable4/app_pid.txt"

echo "Verificando permisos de escritura..."
touch "$LOG_PATH" || { echo "ERROR: No se puede escribir en $LOG_PATH"; exit 1; }

echo "Matando procesos viejos..."
if [ -f "$PID_PATH" ]; then
    OLD_PID=$(cat "$PID_PATH")
    if ps -p $OLD_PID > /dev/null; then
        echo "Matando proceso anterior con PID $OLD_PID..."
        kill -9 $OLD_PID
    fi
fi
pkill -f "$APP_PATH" || true

echo "Levantando app en segundo plano..."
nohup java -jar "$APP_PATH" > "$LOG_PATH" 2>&1 &

# Guardar PID
APP_PID=$!
echo $APP_PID > "$PID_PATH"
echo "App lanzada con PID $APP_PID"

# Espera corta para permitir que la app inicialice
sleep 5

# Mostrar últimas líneas del log para verificar
echo "Últimas 20 líneas de log:"
tail -n 20 "$LOG_PATH"

echo "=== Deploy terminado ==="

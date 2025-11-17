#!/bin/bash
echo "Iniciando deploy en Linux/Mac..."

APP_PATH="/var/jenkins_home/workspace/Entregable4/deploy/app.jar"
LOG_PATH="/var/jenkins_home/workspace/Entregable4/app.log"

echo "Verificando si el puerto 9090 está libre..."
if command -v lsof &> /dev/null; then
    lsof -i :9090 && pkill -f app.jar
else
    echo "lsof no está instalado, se saltará la verificación del puerto"
fi

echo "Matando procesos viejos..."
pkill -f app.jar || true

echo "Levantando app..."
# Exponer la app en 0.0.0.0 para que sea accesible fuera del contenedor
nohup java -jar "$APP_PATH" --server.address=0.0.0.0 --server.port=9090 > "$LOG_PATH" 2>&1 &

APP_PID=$!
echo "App lanzada con PID $APP_PID"
sleep 10

echo "Mostrando últimos 20 logs"
tail -n 20 "$LOG_PATH"

echo "Deploy terminado. Logs en $LOG_PATH"

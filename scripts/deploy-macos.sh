#!/bin/bash
echo "Iniciando deploy en Mac..."

# Detener instancia previa
pkill -f app.jar

# Iniciar nueva versión
nohup java -jar app.jar > app.log 2>&1 &

echo "Deploy Mac completado."

#!/bin/bash

DEST_FOLDER="/var/jenkins_home/apps/playlist"
SOURCE_JAR="/var/jenkins_home/workspace/Entregable4/deploy/app.jar"

echo "Copiando JAR al directorio de deploy..."
cp "$SOURCE_JAR" "$DEST_FOLDER/app.jar"

echo "Matando instancia anterior..."
pkill -f "$DEST_FOLDER/app.jar" || true

echo "Iniciando aplicación..."
nohup java -jar "$DEST_FOLDER/app.jar" > "$DEST_FOLDER/app.log" 2>&1 &

echo "Aplicación iniciada en background."

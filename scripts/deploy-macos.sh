#!/bin/bash
echo "Iniciando deploy en Mac..."

# Navegar al directorio raíz del proyecto
cd "$(dirname "$0")/.."

# Ejecutar tests
echo "Ejecutando tests..."
mvn test
if [ $? -ne 0 ]; then
    echo "Tests fallaron. Abortando deploy."
    exit 1
fi

echo "Tests exitosos. Iniciando aplicación..."

# Detener app previa si está corriendo en puerto 9090
lsof -ti:9090 | xargs kill -9 2>/dev/null

# Iniciar aplicación con Spring Boot
mvn spring-boot:run

echo "Deploy Mac completado."

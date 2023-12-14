#!/bin/bash

# Función para mostrar el menú de ayuda
show_help() {
  echo "Uso: $0 [start|stop]"
  echo "  start: Iniciar el contenedor"
  echo "  stop: Detener el contenedor"
  echo "  -h, --help: Mostrar este menú de ayuda"
}

# Comprobar si se proporciona la opción de ayuda
if [ "$1" == "-h" ] || [ "$1" == "--help" ]; then
  show_help
  exit 0
fi

# Comprobar si se proporciona un argumento válido
if [ "$1" == "start" ]; then
  # Iniciar el contenedor usando docker-compose
  docker compose up -d
  echo "Contenedor iniciado."
elif [ "$1" == "stop" ]; then
  # Detener el contenedor usando docker-compose
  docker compose down
  echo "Contenedor detenido."
else
  # Mostrar el menú de ayuda en caso de argumento inválido
  echo "Error: Argumento inválido."
  show_help
  exit 1
fi

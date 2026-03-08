#!/bin/bash
# Directorio de imágenes
DIR="/home/hernan/Wallapers"

# Seleccionar imagen aleatoria
IMAGE=$(find "$DIR" -type f \( -name "*.jpg" -o -name "*.png" -o -name "*.jpeg" -o -name "*.gif" -o -name "*.mp4"  \) | shuf -n 1)

# Cambiar fondo con transición
swww img "$IMAGE" --transition-type random

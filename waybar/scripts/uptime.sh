#!/bin/bash

# Forzamos idioma en inglés para que sed siempre encuentre "up", "minutes", etc.
UPTIME_PRETTY=$(LC_ALL=C uptime -p)

# Un sed más específico para evitar borrar letras 's' accidentales
UPTIME_FORMATTED=$(echo "$UPTIME_PRETTY" | sed \
    -e 's/^up //' \
    -e 's/ days*/d/g' \
    -e 's/ hours*/h/g' \
    -e 's/ minutes*/m/g' \
    -e 's/,//g')

echo " $UPTIME_FORMATTED"

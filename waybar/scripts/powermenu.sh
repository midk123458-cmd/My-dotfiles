#!/bin/bash

# Definimos las opciones de forma clara
opc1="  Apagar"
opc2="󰑐  Reiniciar"
opc3="󰤄  Suspender"
opc4="󰍃  Cerrar Sesion"
opc5="󰗼  Cancelar"

# Ejecuta rofi
chosen=$(echo -e "$opc1\n$opc2\n$opc3\n$opc4\n$opc5" | rofi -dmenu -i -theme ~/.config/rofi/powersaver.rasi )

# Comparamos la variable
case "$chosen" in
    "$opc1") systemctl poweroff ;;
    "$opc2") systemctl reboot ;;
    "$opc3") systemctl suspend ;;
    "$opc4") hyprctl dispatch exit ;;
esac

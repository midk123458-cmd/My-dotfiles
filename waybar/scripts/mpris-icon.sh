#!/bin/bash

# Archivo temporal para recordar la posición del desplazamiento
POS_FILE="/tmp/waybar_mpris_pos"
[ ! -f "$POS_FILE" ] && echo 0 > "$POS_FILE"

status=$(playerctl status 2>/dev/null)
player=$(playerctl metadata --format '{{playerName}}' 2>/dev/null)
title=$(playerctl metadata --format '{{title}}' 2>/dev/null)
artist=$(playerctl metadata --format '{{artist}}' 2>/dev/null)

# Ocultar si está detenido o cerrado
if [ -z "$status" ] || [ "$status" = "Stopped" ]; then
    echo 0 > "$POS_FILE"
    echo '{"text": "", "class": "stopped"}'
    exit 0
fi

# Icono estático
if [ "$status" = "Paused" ]; then
    icon="⏸"
else
    case "$player" in
        spotify) icon="" ;;
        brave*)   icon="" ;;
        *)       icon="" ;;
    esac
fi

# Formatear el texto
if [ -n "$artist" ]; then
    raw_text="$title - $artist"
else
    raw_text="$title"
fi

# Escapar comillas y el símbolo & para Pango / Waybar
clean_text=$(echo "$raw_text" | tr -d '"\n\r\\' | sed 's/&/\&amp;/g')

max_len=18

if [ ${#clean_text} -gt $max_len ]; then
    padded_text="$clean_text | "
    len=${#padded_text}
    
    # Leer posición actual
    pos=$(cat "$POS_FILE" 2>/dev/null || echo 0)
    
    # Si la música está reproduciéndose, avanzamos un carácter
    if [ "$status" = "Playing" ]; then
        pos=$(( (pos + 1) % len ))
        echo "$pos" > "$POS_FILE"
    fi
    
    # Cortar el texto según la posición
    scroll_text="${padded_text:$pos}${padded_text:0:$pos}"
    display_text="${scroll_text:0:$max_len}"
else
    echo 0 > "$POS_FILE"
    display_text="$clean_text"
fi

echo "{\"text\": \"$icon  $display_text\", \"class\": \"$status\"}"

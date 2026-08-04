#!/bin/bash

RUTA="/Users/sebastiangomez/repositorios_git/linux/loops/for/process"
ARCHIVOS="$RUTA/nodo_*.log"
REPORTE_FINAL="$RUTA/reporte_alertas.txt"


echo "====================" > $REPORTE_FINAL
echo "REPORT ALERTS $(date)" >> $REPORTE_FINAL
echo "====================" >> $REPORTE_FINAL
auditar_usuario_nodo() {
    local ARGUMENTO="$1"
    local PALABRAS_CLAVE=("sebastiangomez" "guest" "app_user")
    local NODO=$(basename "$ARGUMENTO")

    for PALABRA in "${PALABRAS_CLAVE[@]}"; do

        grep -w "$PALABRA" "$ARGUMENTO" | awk -F":" '{print $2, $3, $4}' | while read -r PID CPU PROCESO; do

            if [[ "$CPU" -ge 80 ]]; then
                echo "🚨 KILL CRITICO [$NODO]: The user $PALABRA is using $CPU% CPU in the PID $PID ($PROCESO). It is necessary kill -9." >> $REPORTE_FINAL

            elif [[ "$CPU" -ge 15 ]]; then

                echo "⚠️ ADV: The user $PALABRA consumes $CPU%  CPU in the PID $PID ($PROCESO) in $NODO." >> $REPORTE_FINAL


            fi
        done
    done




}


for ARCHIVO in $ARCHIVOS; do 

    auditar_usuario_nodo "$ARCHIVO"
done

echo "PROCESS FINISHED"
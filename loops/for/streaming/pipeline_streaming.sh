#!/bin/bash

RUTA="/Users/sebastiangomez/funciones/uso_for/streaming"
ARCHIVOS="$RUTA/logs_*.txt"
REPORTE="$RUTA/reporte_streaming.txt"


echo "=========================" > $REPORTE
echo "FINAL REPORT $(date)" >> $REPORTE
echo "=========================" >> $REPORTE


procesar_pais() {
    local CAMINO="$1"
    local PALABRAS_CLAVE=("Movie" "Documentary")
    local CAMINO_LIMPIO=$(basename $CAMINO)

    for PALABRA in "${PALABRAS_CLAVE[@]}"; do

        grep -i "$PALABRA" "$CAMINO" | awk -F"|" '{print $1, $2}' | while read -r ID TIEMPO; do

            if [[ "$TIEMPO" -ge 100 ]]; then

                echo "🚀 HIG CONSUMPTION [$CAMINO_LIMPIO]: The users had high consumption in $ID with a time of $TIEMPO min." >> $REPORTE

            elif [[ "$TIEMPO" -le 10 ]]; then

                echo "📉 LOW CONSUMPTION [$CAMINO_LIMPIO]:The users had low consuption in $ID with a time of $TIEMPO min." >> $REPORTE
            
            else
                echo "NORMAL CONSUMPTION [$CAMINO_LIMPIO]:The users had a normal consumption in $ID with a time of $TIEMPO min." >> $REPORTE
            fi
        done
    done

}


for ARCHIVO in $ARCHIVOS; do
    

    procesar_pais "$ARCHIVO" 

done
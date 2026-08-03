#!/bin/bash

RUTA="/Users/sebastiangomez/logs/monitor_discos"
ARCHIVOS="$RUTA/cluster*.txt"
TEMPORAL="$RUTA/maestro_discos.txt"
PALABRAS_CLAVE=("ALERT" "CRITICAL")
REPORTE_FINAL="$RUTA/reporte_urgente.txt"

echo "=====" > $TEMPORAL
cat $ARCHIVOS >> $TEMPORAL

echo "================" > $REPORTE_FINAL
echo "URGENT REPORT" >> $REPORTE_FINAL
echo "================" >> $REPORTE_FINAL


for PALABRA in "${PALABRAS_CLAVE[@]}"; do


    cat $TEMPORAL |grep "$PALABRA" | awk '{print $1, $3}' | while read -r NOMBRES PORCENTAJE; do

        if  [[ "$PALABRA" == "CRITICAL" ]]; then
            echo "🚨 INMEDIATE ACTION: The disk $NOMBRES is in $PORCENTAJE. ¡Danger of collapse!" >> $REPORTE_FINAL

        elif [[ "$PALABRA" == "ALERT" ]]; then   
            echo "⚠️ WARNING: The disk $NOMBRES is in $PORCENTAJE. Monitor closely." >> $REPORTE_FINAL

        fi
    done

done




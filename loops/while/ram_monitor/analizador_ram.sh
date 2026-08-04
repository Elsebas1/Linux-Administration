#!/bin/bash

RUTA="/Users/sebastiangomez/repositorios_git/linux/loops/while/ram_monitor"
ARCHIVOS="$RUTA/srv_*.data"
UNIFICADOS_DOS="$RUTA/maestro_ram.tmp"
REPORTE_DOS="$RUTA/reporte_ram.txt"

echo "=== START OF DATA  UNIFICATION AND PROCESSING ===" 
echo " === Date $(date) ===" > "$REPORTE_DOS"
echo -e "\n=== INFORMATION REPORT ===\n" >> "$REPORTE_DOS"

unificar_datos() {
    echo "UNIFICACIÓN...." 
    cat $ARCHIVOS > $UNIFICADOS_DOS

}

evaluar_consumo() {

    local NOMBRE_APP="$1"
    local RAM="$2"
    local ESTADO="$3"

    if [[ -z "$NOMBRE_APP" ]]; then
        return 
    fi

    if [[ "$ESTADO" == "CRITICAL" || "$RAM" -ge 3000 ]]; then
        echo "❌ URGENT REVIEW: "$NOMBRE_APP" consume "$RAM" MB. State: $ESTADO ." >> "$REPORTE_DOS"
    
    elif [[ "$ESTADO" == "ALERT" ]]; then 
        echo "⚠️ WARNING: "$NOMBRE_APP" consume "$RAM" MB. State: $ESTADO ." >> "$REPORTE_DOS"
    
    else
        echo "🟢 STABLE: "$NOMBRE_APP" is working normally ("$RAM" MB)." >> "$REPORTE_DOS"

    fi

}

unificar_datos

while IFS="," read -r NOMBRE MEMORIA ESTADO; do
    evaluar_consumo "$NOMBRE" "$MEMORIA" "$ESTADO"


done < "$UNIFICADOS_DOS"

echo "Completed process ✅"

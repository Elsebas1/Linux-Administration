#!/bin/bash

RUTA="/Users/sebastiangomez/funciones/uso_for/tiendas_data"
ARCHIVOS="$RUTA/tienda_*.txt"
ALERTAS="$RUTA/reporte_alertas.txt"


echo "=== CRITICAL SUPPLY ALERTS ===" > "$ALERTAS"
echo "===  $(date) ===" >> "$ALERTAS"
echo "-----------------------------------------" >> "$ALERTAS"

auditar_inventario() {
    local ARCHIVO_TIENDA="$1"
    local PRODUCTOS_CRITICOS=("Teclado" "Monitor")
    local NOMBRE_TIENDA=$(basename "$ARCHIVO_TIENDA")

    for PRODUCTO in "${PRODUCTOS_CRITICOS[@]}"; do

        local CANTIDAD=$(grep -i "$PRODUCTO" "$ARCHIVO_TIENDA" | awk -F":" '{print $2}')

        if [[ -n "$CANTIDAD" ]]; then
            if [[ "$CANTIDAD" -lt 15 ]]; then
                echo "⚠️ INTERNAL STOCK: The  $NOMBRE_TIENDA store reports low  $PRODUCTO ($CANTIDAD unidades) sales." >> "$ALERTAS"
            fi
        fi
    done

}

for ARCHIVO in $ARCHIVOS; do

    auditar_inventario "$ARCHIVO"
done

echo "Audit process completed. Alerts in $(basename "$ALERTAS")"

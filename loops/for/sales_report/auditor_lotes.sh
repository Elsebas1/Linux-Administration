#!/bin/bash

RUTA="/Users/sebastiangomez/practica_linux"
CARPETA="$RUTA/reportes_ventas"
ARCHIVOS="$CARPETA/*.txt"


for TRANSACCION in $ARCHIVOS; do
    echo "Auditing the report: $(basename "$TRANSACCION")"
    while read -r LINEA; do 
        if [[ "$LINEA" == *"CANCELADO"* ]]; then
            echo "ALERT: A rejected transaction has been detected -> $LINEA"
        fi 
    
    done < "$TRANSACCION"


done

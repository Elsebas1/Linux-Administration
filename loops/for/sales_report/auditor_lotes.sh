#!/bin/bash

RUTA="/Users/sebastiangomez/repositorios_git/linux/loops/for/sales_report"
ARCHIVOS="$RUTA/*.txt"


for TRANSACCION in $ARCHIVOS; do
    echo "Auditing the report: $(basename "$TRANSACCION")"
    while read -r LINEA; do 
        if [[ "$LINEA" == *"CANCELADO"* ]]; then
            echo "ALERT: A rejected transaction has been detected -> $LINEA"
        fi 
    
    done < "$TRANSACCION"


done

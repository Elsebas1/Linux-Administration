#!/bin/bash

RUTA="/Users/sebastiangomez/repositorios_git/linux/loops/while/hardware_audit"
ARCHIVO="$RUTA/inventario_servidores.csv"

while IFS="," read -r SERVIDOR RAM ESTADO; do

    
    if [[ "$ESTADO" == "ONLINE" ]]; then

        if [[ "$RAM" -ge 16 ]]; then

            echo "Server '$SERVIDOR': High quality node (${RAM}GB RAM)."
        else 
            echo "Server '$SERVIDOR': Standar Node (${RAM}GB RAM)."
        fi
    else
        echo "Server '$SERVIDOR': Ignored (Turn off)"
    
    fi
 

done < "$ARCHIVO"
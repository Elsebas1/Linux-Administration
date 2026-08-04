#!/bin/bash

RUTA="/Users/sebastiangomez/repositorios_git/linux/loops/while/security_log"
ARCHIVO="$RUTA/app_seguridad.log"


while read -r LINEA; do

    MENSAJE_LIMPIO=$(echo "$LINEA" | cut -d "-" -f 4)
    if [[ "$LINEA" == *"ERROR"* ]]; then 

        

        echo "CRITIC: $MENSAJE_LIMPIO"
    
    elif [[ "$LINEA" == *"WARN"* ]]; then
        echo "Wargning: Suspicius behave: $MENSAJE_LIMPIO"
    
    else
        echo "Ok. Routine activity"
    fi

done < "$ARCHIVO"


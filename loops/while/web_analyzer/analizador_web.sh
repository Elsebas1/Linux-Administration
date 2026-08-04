#!/bin/bash

RUTA="/Users/sebastiangomez/repositorios_git/linux/loops/while/web_analyzer"
ARCHIVO="$RUTA/acceso_web.log"

while read -r LINEA; do

    MENSAJE_LIMPIO=$(echo "$LINEA" | cut -d "-" -f 2)

    if [[ "$LINEA" == *200* ]]; then
        echo "SUCCES $MENSAJE_LIMPIO: Normal browsing detected on the line."
    
    elif [[ "$LINEA" == *404* ]]; then
        echo "ALERT $MENSAJE_LIMPIO: A client attempted to acces on a non-existent page."
    
    else
        echo "CRITICAL $MENSAJE_LIMPIO: ¡The server crashed while attempting to process that request!"

    fi 

done < "$ARCHIVO"
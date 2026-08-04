#!/bin/bash

RUTA="/Users/sebastiangomez/repositorios_git/linux/others/audit"
RUTA_ARCHIVO="$RUTA/auditoria_servidor.log"

PALABRAS_CLAVE=("FAILED_MALICIOUS" "API_GATEWAY" "CRITICAL_ERROR")



echo "======="
PALABRA_ARCHIVO=$(grep -i "${PALABRAS_CLAVE[0]}" $RUTA_ARCHIVO)

if [ "$PALABRA_ARCHIVO" ]; then
    echo "🚨 MAXIMUM ALERT: Targeted attack attemps  against the server were detected."

else

    echo "Stable security: No malicious attacks recorded."
fi

echo "======="

PALABRA_API=$(grep -i "${PALABRAS_CLAVE[1]}" $RUTA_ARCHIVO | grep -i "${PALABRAS_CLAVE[2]}")


if [ "$PALABRA_API" ]; then 
    echo "OPERATIVE ERROR: The API Gateway in the system collapsed."

else 
    echo "The API Gateway is operating normally." 

fi 

echo "======="
TAMANIO=$(stat -f %z "$RUTA_ARCHIVO")

echo "$TAMANIO"

if [ "$TAMANIO" -gt 500 ]; then

    echo "Large log file. Suggest: Route or compress log."
else
    echo "Controlled log size"

fi
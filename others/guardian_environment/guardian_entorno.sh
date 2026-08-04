#!/bin/bash

RUTA="/Users/sebastiangomez/repositorios_git/linux/others/guardian_environment"
ARCHIVO_TOKEN="$RUTA/scripts_seguros/token_acceso.key"
ARCHIVO_CONFIG="$RUTA/config_pipeline.conf"

PALABRAS_CLAVE=("ENV=PRODUCCION" "DB_PORT=5432")

echo -e "\REQUIRIMENT 1"

if [[ -f "$ARCHIVO_TOKEN" && -s "$ARCHIVO_TOKEN" ]]; then

    echo "Security token correctly validated."

else

    echo -e "\nCRITICAL ERROR: The access token is empty or does not exist. Leaving for security."

fi

echo -e "\nREQUIREMENT 2"

BUSQUEDA=$(grep -x "${PALABRAS_CLAVE[0]}" "$ARCHIVO_CONFIG")

echo $BUSQUEDA

if [[ "$BUSQUEDA" == "${PALABRAS_CLAVE[0]}" ]]; then 
    
    echo "ALERT: PRODUCTION environment detected. Operating with extreme caution."

else

    echo "Test/development environmet detected"

fi



echo -e "\nREQUIREMENT 3"

PUERTO=$(grep -x "${PALABRAS_CLAVE[1]}" "$ARCHIVO_CONFIG" | cut -d "=" -f 2)

echo -e "\n$PUERTO"

if [[ "$PUERTO" -le 1024 ]]; then
    echo "⚠️ DANGER: The configured port is reserved by the system. Risk of conflict."

else
    echo "✅ Infraestructure port within the safe range."

fi
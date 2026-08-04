#!/bin/bash

RUTA="/Users/sebastiangomez/repositorios_git/linux/loops/while/conections"
ARCHIVO="$RUTA/conexiones_red.csv"

while IFS="," read -r IP ESTADO; do
    
    if [[ "$ESTADO" ==  "BLOQUEADO" ]]; then
        echo "A suspicius IP address has been detected: "$IP" -> Applying firewall block."
    
    elif [[ "$ESTADO" == "PERMITIDO" ]]; then
        echo "Secure connection: $IP"
    
    fi


done < "$ARCHIVO"
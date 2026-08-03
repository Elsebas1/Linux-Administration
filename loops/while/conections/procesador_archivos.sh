#!/bin/bash

RUTA="/Users/sebastiangomez/practica_linux"
ARCHIVO="$RUTA/conexiones_red.csv"

while IFS="," read -r IP ESTADO; do
    
    if [[ "$ESTADO" ==  "BLOQUEADO" ]]; then
        echo "A suspicius IP address has been detected: "$IP" -> Applying firewall block."
    
    elif [[ "$ESTADO" == "PERMITIDO" ]]; then
        echo "Secure connection: $IP"
    
    fi


done < "$ARCHIVO"
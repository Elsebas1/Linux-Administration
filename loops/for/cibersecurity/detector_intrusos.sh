#!/bin/bash

RUTA="/Users/sebastiangomez/repositorios_git/linux/loops/for/cibersecurity"
ARCHIVO="$RUTA/servidor_*.log"
ARCHIVO_UNIFICADO="$RUTA/maestro_accesos.tmp"
REPORT="$RUTA/reporte_bloqueo.txt"


echo " === Intrusion attempt report ===" > $REPORT
echo " ----------------------------------------" >> $REPORT

echo "Unification files $(date)" > $ARCHIVO_UNIFICADO

cat $ARCHIVO >> $ARCHIVO_UNIFICADO


analizar_lista_negra() {

    local ARCHIVOS_RECIBIDOS="$1"
    local LISTA_NEGRA=("China" "Rusia")
    local ARCHIVOS_NOMBRE=$(basename "$ARCHIVOS_RECIBIDOS")

    for PAIS in "${LISTA_NEGRA[@]}"; do

        grep "$PAIS" "$ARCHIVO_UNIFICADO" | awk -F"-" '{print $1, $2}' | while read -r INTENTOS IP; do

            if [[ $INTENTOS -ge 30 ]]; then
                echo "🚨 IMMEDIATE BLOCK: IP $IP launched an attacked consisting of $INTENTOS attempts from $PAIS." >> $REPORT
            else
                echo "⚠️ MONITORING: Suspicious activity from $IP ($INTENTOS intentos) in $PAIS." >> $REPORT
            fi

        done

    done


}

analizar_lista_negra "$ARCHIVO_UNIFICADO"

echo "Network auditory complete. Results in: $(basename "$REPORT") 🛡️"

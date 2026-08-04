#!/bin/bash

RUTA="/Users/sebastiangomez/repositorios_git/linux/loops/while/system_bank"
ARCHIVOS="$RUTA/*.dat"
UNIFICADOS="$RUTA/todo_banca.tmp"
REPORTE="$RUTA/auditoria_bancaria.txt"

echo "=== START AUDIT ===" > "$REPORTE"
echo "=== Date: $(date)" >> "$REPORTE"


consolidar_archivos() {
    echo "Consolidating branches..."
    cat $ARCHIVOS > $UNIFICADOS

}

auditar_transaccion() {

    local CLIENTE="$1"
    local TX="$2"
    local MONTO="$3"

    if [[ "$MONTO" -ge 1000 && "$TX" == "WITHDRAW" ]]; then
        echo "🚨HIGH-VALUE ALERT: $CLIENTE withdraw $MONTO USD." >> "$REPORTE"
        
    elif [[ "$MONTO" -le 50 && "$TX" == "DEPOSIT" ]]; then
        echo "⚠️ CONTROL: Client $CLIENTE low-level deposito for $MONTO USD." >> "$REPORTE"
        
    else
        echo "🟢 OK: Standard transaction for customer $CLIENTE $TX for $MONTO USD." >> "$REPORTE"
    fi

}

consolidar_archivos

while IFS="," read -r ID_CLI TX_TIPO TX_MONTO; do
    
    auditar_transaccion "$ID_CLI" "$TX_TIPO" "$TX_MONTO"

done < "$UNIFICADOS"

echo "Completed process. Report generate on $(basename $REPORTE)."


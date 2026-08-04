#!/bin/bash
RUTA="/Users/sebastiangomez/repositorios_git/linux/loops/for/consolidate_sales"
ARCHIVOS="$RUTA/srv_*.log"
REPORTE="$RUTA/master_ventas.log"
REPORTE_FINAL="$RUTA/auditoria_final.txt"
PALABRAS_CLAVE=("COMPLETED" "REJECTED")

echo "------" > $REPORTE

cat $ARCHIVOS >> $REPORTE 

echo -e "---------------------------------------------\n" > $REPORTE_FINAL
echo "REPORT OF SUCCESFUL AND REJECTED TRANSACTIONS" >> $REPORTE_FINAL
echo -e "\n---------------------------------------------" >> $REPORTE_FINAL
for PALABRA in ${PALABRAS_CLAVE[@]}; do

    echo "WORD SEARCH $PALABRA" >> $REPORTE_FINAL

    cat "$REPORTE" | grep "$PALABRA" | awk  '{print $3}' | sort | uniq -c >> $REPORTE_FINAL


    cat "$REPORTE" | grep "$PALABRA" | awk  '{print $3}' | sort | uniq -c | while read -r CANTIDAD PRODUCTO; do

        if [[ "$CANTIDAD" -ge 15 && $PALABRA == "COMPLETED" ]]; then

            echo "🏆 FLAGSHIP PRODUCT: '$CANTIDAD' units of '$PRODUCTO' were sold." >> $REPORTE_FINAL

        elif [[ "$CANTIDAD" -lt 15 && $PALABRA == "COMPLETED" ]]; then

            echo "REGUNLAR SALE: '$CANTIDAD' units of '$PRODUCTO' were sold." >> $REPORTE_FINAL
        
        else
            echo "'$PRODUCTO' transactions are being rejected. Therefore, they are not includes in the quantities sold." >> $REPORTE_FINAL

        fi
    done

done



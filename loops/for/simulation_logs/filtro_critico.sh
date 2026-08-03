RUTA="/Users/sebastiangomez/logs/logs_simulacion"
PATRONES=("FATAL" "CRITICAL")
REPORTE_FINAL="$RUTA/reporte_final.txt"



echo "\nFile Analyze" > $REPORTE_FINAL

ARCHIVOS=$(find "$RUTA" -type f -name "*.log")


for ARCHIVO in $ARCHIVOS; do

    echo -e "\n Files to work on" >> $REPORTE_FINAL
    echo "==============================" >> $REPORTE_FINAL
    echo "          "$(basename $ARCHIVO)"            " >> $REPORTE_FINAL
    echo "===============================" >> $REPORTE_FINAL
    
    for PATRON in "${PATRONES[@]}"; do

        echo -e "\nSearching "$PATRON" in the file "$(basename $ARCHIVO)"\n" >> $REPORTE_FINAL
        
        grep -i "$PATRON" "$ARCHIVO" | sort -k2 >> $REPORTE_FINAL 

        EVENTOS_TOTALES=$(grep -c "$PATRON" "$ARCHIVO")

        echo -e "\n📊 From the file "$(basename $ARCHIVO)" there are  "$EVENTOS_TOTALES" "$PATRON"" >> $REPORTE_FINAL



    done


done



echo "\nAnalysis completed...✅"
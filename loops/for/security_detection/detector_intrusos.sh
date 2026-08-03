RUTA="/Users/sebastiangomez/logs/deteccion_seguridad"
FALLOS=("Invalid" "Failed")
ARCHIVO="$RUTA/auth.log"
REPORTE="$RUTA/reporte_intrusos.txt"

echo "=======================" > $REPORTE
echo " ATTACK REPORT   " >> $REPORTE
echo "========================" >> $REPORTE

for FALLO in "${FALLOS[@]}"; do

    echo -e "\n-------------------------" >> $REPORTE
    echo "Analyze for the pattern $FALLO" >> $REPORTE
    echo -e "\n---------------------------" >> $REPORTE
    echo "IPs ranking (ATTEMPS | IP DIRECTIONS):" >> $REPORTE



        cat "$ARCHIVO" | grep "$FALLO" | awk '{print $5}' | sort | uniq -c | while read -r REPETICIONES IP_ATACANTE; do

        if [[ "$REPETICIONES" -ge 10 ]]; then

            echo "CRITICAL ALERRT: Locking the IP '$IP_ATACANTE' to register $REPETICIONES attacaks." >> $REPORTE
        
        else 
            echo "Warning: IP '$IP_ATACANTE under observation ($REPETICIONES intentos)." >> $REPORTE

        fi
    done
    


done 

echo "Report successfully uploaded to the file $(basename $REPORTE) ✅"

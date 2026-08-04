RUTA="/Users/sebastiangomez/repositorios_git/linux/loops/while/disks"
ARCHIVO="$RUTA/uso_discos.csv"


tail -n +2 "$ARCHIVO" | while IFS="," read -r ID PORCENTAJE CRITICO; do



    if [[ "$CRITICO" == "SI" ]]; then
        echo " ALERT '$ID' to '$PORCENTAJE'. Executin table purge..."

    else 
        echo "OK: '$ID' operating in a safe range." 

    fi

done 
#!/bin/bash

RUTA="/Users/sebastiangomez/repositorios_git/linux/others/costs"
ARCHIVO="$RUTA/reporte_costos_cloud.csv"
PALABRAS_CLAVE=("ACTIVE" "Data_Engineering" "EC2" "RDS")

echo "=== CASE 1 ==="
AUDITAR=$(cut -d "," -f 3,6,7 "$ARCHIVO" | grep -i "${PALABRAS_CLAVE[0]}" | grep -i "${PALABRAS_CLAVE[1]}" | grep -i "${PALABRAS_CLAVE[2]}"| wc -l)

echo "In total, there are: "$AUDITAR" records"

if [[ "$AUDITAR" -ge 3 ]]; then
    echo -e "\nALERT FINOPS: The Data Engineering team has 3 or more instances EC2 running in parallel."

else 

    echo "EC2 usage for Data Engineering within budget."
fi

echo "=== CASE 2 ==="

LISTA_DOS=$(grep -i "${PALABRAS_CLAVE[0]}" "$ARCHIVO" | grep -i "${PALABRAS_CLAVE[3]}" | cut -d "," -f 2,5 | sort -k2 | uniq)

if [[ -n "$LISTA_DOS" ]]; then

    echo -e "\n--- TOP ACTIVE RDS RESOURCES ---"
    echo "$LISTA_DOS"
    echo "--------------------------------"

else

    echo "No active RDS resources were found."

fi


echo -e "\n=== CASE 3 ==="


LINEAS=$(wc -l < "$ARCHIVO")
echo "$LINEAS"

if [[ -f "$ARCHIVO" && "$LINEAS" -gt 10 ]]; then

    echo "EXCELENT INTEGRITY. The report exists and contains sufficient documantation for its processing."

else 
    echo "INTAKE ERROR: Incomplete, corrupt, or non-existent file. Stopping the process"

fi

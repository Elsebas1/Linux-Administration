#!/bin/bash

CARPETA_ORIGEN="/Users/sebastiangomez/practica_linux"
ARCHIVOS_TEXTO="/Users/sebastiangomez/practica_linux/documentos_texto"
ARCHIVOS_DATA="/Users/sebastiangomez/practica_linux/tablas"

mkdir -p $ARCHIVOS_TEXTO
mkdir -p $ARCHIVOS_DATA

find $CARPETA_ORIGEN -type f -name "*.txt" -exec mv {} $ARCHIVOS_TEXTO \;
find $CARPETA_ORIGEN -type f -name "*.csv" -exec mv {} $ARCHIVOS_DATA \;

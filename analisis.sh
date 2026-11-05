#!/bin/bash
# Módulo 3: Análisis de información con awk y sed

ORIGINAL="servidores.txt"
COPIA="servidores_copia.txt"

cat << 'DATA' > "$ORIGINAL"
Servidor Uso_Disco
srv_web_01 45
srv_db_01 85
srv_app_01 72
srv_backup 50
DATA

cp "$ORIGINAL" "$COPIA"

echo "=== 1. Archivo original de servidores ==="
cat "$ORIGINAL"

echo -e "\n=== 2. Servidores que superan el 70% de uso (awk) ==="
awk 'NR > 1 && $2 > 70 {print "⚠️ Alerta: " $1 " tiene " $2 "% de uso de disco."}' "$ORIGINAL"

echo -e "\n=== 3. Reemplazo de palabras en la copia (sed) ==="
sed -i 's/srv_/servidor_critico_/g' "$COPIA"
cat "$COPIA"

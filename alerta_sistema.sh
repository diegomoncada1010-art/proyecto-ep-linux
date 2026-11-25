#!/bin/bash
# ==============================================================================
# Script: alerta_sistema.sh
# Descripción: Monitoreo de hardware (CPU, RAM, Disco) con disparo de alertas.
# ==============================================================================

LOG_CENTRAL="sistema_eventos.log"
UMBRAL_DISCO=70
HOST=$(hostname)
FECHA=$(date '+%Y-%m-%d %H:%M:%S')

echo "=============================================="
echo "   MONITOREO DE RECURSOS Y ALERTAS DE SALUD"
echo "=============================================="
echo "Servidor : $HOST | Fecha: $FECHA"

# 1. Métricas de CPU
MODELO_CPU=$(lscpu | grep 'Model name' | cut -d ':' -f2 | xargs)
CARGA_CPU=$(uptime | awk -F'load average:' '{print $2}' | xargs)
echo " - CPU   : $MODELO_CPU"
echo " - Carga : $CARGA_CPU"

# 2. Métricas de RAM
RAM_USADA=$(free -m | awk '/Mem:/ {printf "%.0f", ($3/$2)*100}')
echo " - RAM   : ${RAM_USADA}% en uso"

# 3. Métricas de Disco (partición raíz /)
USO_DISCO=$(df / | awk 'NR==2 {gsub("%",""); print $5}')
echo " - Disco : ${USO_DISCO}% en uso (Umbral: ${UMBRAL_DISCO}%)"
echo "----------------------------------------------"

# 4. Evaluación de umbrales y registro automático en el log central
if [ "$USO_DISCO" -ge "$UMBRAL_DISCO" ]; then
    MSG="$FECHA CRITICAL $HOST Disco raiz alcanzo ${USO_DISCO}% (Umbral: ${UMBRAL_DISCO}%)"
    echo "$MSG" >> "$LOG_CENTRAL"
    echo "🚨 ALERTA REGISTRADA EN $LOG_CENTRAL: $MSG"
else
    MSG="$FECHA INFO $HOST Recursos estables (Disco: ${USO_DISCO}%, RAM: ${RAM_USADA}%)"
    echo "$MSG" >> "$LOG_CENTRAL"
    echo "✅ Estado saludable registrado en $LOG_CENTRAL"
fi

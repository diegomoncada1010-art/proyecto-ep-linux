#!/bin/bash
# Script: sistema.sh (Versión Avanzada y Completa con CPU)
# Descripción: Recopila métricas profundas de CPU, Kernel, Memoria, Red y Almacenamiento.

REPORTE="reporte_sistema.txt"
> "$REPORTE"

echo "==============================================" >> "$REPORTE"
echo "    REPORTE AVANZADO DE MONITOREO DE SISTEMA" >> "$REPORTE"
echo "==============================================" >> "$REPORTE"
echo "Fecha y hora de ejecución : $(date '+%Y-%m-%d %H:%M:%S')" >> "$REPORTE"
echo "Usuario en sesión activa  : $(whoami) (UID: $UID)" >> "$REPORTE"
echo "----------------------------------------------" >> "$REPORTE"

echo "[+] INFORMACIÓN DEL PROCESADOR (CPU):" >> "$REPORTE"
echo " - Modelo de CPU   : $(lscpu | grep 'Model name' | cut -d ':' -f2 | xargs)" >> "$REPORTE"
echo " - Arquitectura    : $(lscpu | grep 'Architecture' | cut -d ':' -f2 | xargs)" >> "$REPORTE"
echo " - Núcleos (Cores) : $(lscpu | grep '^Core(s) per socket:' | cut -d ':' -f2 | xargs)" >> "$REPORTE"
echo " - Hilos (Threads) : $(lscpu | grep '^CPU(s):' | head -n 1 | cut -d ':' -f2 | xargs)" >> "$REPORTE"
echo " - Velocidad reloj : $(lscpu | grep 'CPU max MHz' | cut -d ':' -f2 | xargs) MHz" >> "$REPORTE"
echo "----------------------------------------------" >> "$REPORTE"

echo "[+] INFORMACIÓN DEL KERNEL Y DISTRIBUCIÓN:" >> "$REPORTE"
echo " - Sistema Operativo : $(cat /etc/os-release | grep "^PRETTY_NAME" | cut -d= -f2 | tr -d '"')" >> "$REPORTE"
echo " - Versión de Kernel : $(uname -r)" >> "$REPORTE"
echo " - Arquitectura SO   : $(uname -m)" >> "$REPORTE"
echo "----------------------------------------------" >> "$REPORTE"

echo "[+] ESTADO DE RENDIMIENTO Y TIEMPO ACTIVO:" >> "$REPORTE"
echo " - Tiempo de actividad (Uptime):" >> "$REPORTE"
uptime -p >> "$REPORTE"
echo " - Carga del sistema (Load Average):" >> "$REPORTE"
uptime | awk -F'load average:' '{print $2}' >> "$REPORTE"
echo "----------------------------------------------" >> "$REPORTE"

echo "[+] USO DE MEMORIA RAM:" >> "$REPORTE"
free -h >> "$REPORTE"
echo "----------------------------------------------" >> "$REPORTE"

echo "[+] ESPACIO Y PARTICIONES EN DISCO:" >> "$REPORTE"
df -h --total | grep -E 'Filesystem|total' >> "$REPORTE"
df -h | grep -v "tmpfs" >> "$REPORTE"
echo "----------------------------------------------" >> "$REPORTE"

echo "[+] CONFIGURACIÓN DE RED (IPs ACTIVAS):" >> "$REPORTE"
hostname -I | awk '{print " - Dirección IP local: " $1}' >> "$REPORTE"
echo "==============================================" >> "$REPORTE"

echo "✅ Reporte avanzado y completo generado en: $REPORTE"
cat "$REPORTE"
#!/bin/bash
# Módulo 1: Monitoreo del sistema

REPORTE="reporte_sistema.txt"
> "$REPORTE"

echo "=== Reporte de Monitoreo del Sistema ===" >> "$REPORTE"
echo "Fecha y hora: $(date '+%Y-%m-%d %H:%M:%S')" >> "$REPORTE"
echo "Usuario actual: $(whoami)" >> "$REPORTE"
echo "----------------------------------------" >> "$REPORTE"
echo "Distribución Linux:" >> "$REPORTE"
cat /etc/os-release | grep "^PRETTY_NAME" | cut -d= -f2 | tr -d '"' >> "$REPORTE"
echo "----------------------------------------" >> "$REPORTE"
echo "Espacio disponible en disco:" >> "$REPORTE"
df -h >> "$REPORTE"

echo "✅ Reporte generado y guardado en $REPORTE"
cat "$REPORTE"

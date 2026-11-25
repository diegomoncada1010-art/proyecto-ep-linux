#!/bin/bash
# ==============================================================================
# Script: monitor_logs.sh
# Descripción: Sistema de monitoreo de logs con detección de eventos críticos.
# Uso: ./monitor_logs.sh [ruta_del_log]
# ==============================================================================

LOG_FILE="${1:-sistema_eventos.log}"
REPORTE="reporte_alertas_$(date +%F).txt"
LOG_LIMPIO="logs_sanitizados.log"

# 1. Validación: si no existe el archivo de log, genera uno de prueba realista
if [ ! -f "$LOG_FILE" ]; then
    echo "⚠️  Archivo '$LOG_FILE' no encontrado. Generando log de prueba..."
    cat << 'DATA' > "$LOG_FILE"
2026-11-24 08:01:12 INFO srv-web01 Servicio Apache iniciado correctamente
2026-11-24 08:05:44 WARNING srv-app01 Uso de memoria RAM al 78%
2026-11-24 08:10:03 ERROR srv-db01 Fallo de conexion a base de datos puerto 5432
2026-11-24 08:12:19 CRITICAL srv-auth01 Failed password for root from 192.168.1.99
2026-11-24 08:15:30 INFO srv-backup Respaldo incremental completado
2026-11-24 08:20:01 CRITICAL srv-db01 Disco /var/lib/mysql supero el 92% de capacidad
2026-11-24 08:25:10 ERROR srv-mail01 Timeout al conectar con servidor SMTP
2026-11-24 08:30:00 CRITICAL srv-auth01 Failed password for admin from 10.0.0.45
DATA
fi

# 2. Validación de lectura
if [ ! -r "$LOG_FILE" ]; then
    echo "❌ Error: No se tienen permisos de lectura sobre '$LOG_FILE'."
    exit 1
fi

# 3. Análisis con AWK y generación de reporte
{
    echo "============================================================"
    echo "        REPORTE DE MONITOREO Y EVENTOS CRÍTICOS"
    echo "============================================================"
    echo "Fecha de análisis : $(date '+%Y-%m-%d %H:%M:%S')"
    echo "Archivo analizado : $LOG_FILE"
    echo "------------------------------------------------------------"
    printf "%-19s | %-10s | %-12s | %s\n" "FECHA Y HORA" "NIVEL" "SERVIDOR" "DETALLE"
    echo "------------------------------------------------------------"

    awk '$3 == "CRITICAL" || $3 == "ERROR" {
        detalle = ""
        for (i=5; i<=NF; i++) detalle = detalle $i " "
        printf "%-19s | %-10s | %-12s | %s\n", $1" "$2, $3, $4, detalle
    }' "$LOG_FILE"

    echo "------------------------------------------------------------"
    TOTAL=$(wc -l < "$LOG_FILE")
    CRITICOS=$(grep -c "CRITICAL" "$LOG_FILE")
    ERRORES=$(grep -c "ERROR" "$LOG_FILE")
    INTENTOS_SSH=$(grep -c "Failed password" "$LOG_FILE")

    echo "Total de registros analizados : $TOTAL"
    echo "Eventos CRITICAL detectados   : $CRITICOS"
    echo "Eventos ERROR detectados      : $ERRORES"
    echo "Alertas de acceso (SSH/Auth)  : $INTENTOS_SSH"
    echo "============================================================"
} > "$REPORTE"

# 4. Sanitización de IPs con SED (buena práctica de seguridad para compartir logs)
sed -E 's/[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+/[IP_OCULTA]/g' "$LOG_FILE" > "$LOG_LIMPIO"

cat "$REPORTE"
echo "✅ Reporte guardado en: $REPORTE"
echo "🔒 Copia con IPs ocultas generada en: $LOG_LIMPIO"

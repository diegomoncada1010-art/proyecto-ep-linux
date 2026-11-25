# Sistema de Monitoreo de Logs y Detección de Eventos Críticos (Shell Scripting)

Suite de automatización en Bash sobre Ubuntu Linux (WSL2) diseñada para monitorear registros del sistema, auditar recursos de hardware en tiempo real y programar tareas desatendidas mediante Cron.

## Scripts Principales

1. **`monitor_logs.sh`**: Analiza archivos de log (`sistema_eventos.log`) utilizando `awk`, `grep` y `sed`. Detecta eventos `CRITICAL`, `ERROR` e intentos fallidos de acceso (`Failed password`), genera un reporte fechado (`reporte_alertas_YYYY-MM-DD.txt`) y crea una copia sanitizada ocultando direcciones IP (`logs_sanitizados.log`).
2. **`alerta_sistema.sh`**: Audita el procesador (`lscpu`), carga promedio (`uptime`), memoria RAM (`free`) y uso de disco (`df`). Si el disco supera el umbral del 70%, inyecta automáticamente un evento `CRITICAL` en el log central.
3. **`cron_manager.sh`**: Gestor interactivo para administrar `crontab` sin editarlo manualmente. Permite elegir el script objetivo (`monitor_logs.sh` o `alerta_sistema.sh`) y programar frecuencias predefinidas o personalizadas.

## Uso Rápido

    chmod +x *.sh
    ./monitor_logs.sh
    ./alerta_sistema.sh
    ./cron_manager.sh

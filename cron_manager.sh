#!/bin/bash
# ==============================================================================
# Script: cron_manager.sh (Versión Avanzada - Monitoreo de Logs)
# Descripción: Interfaz interactiva para programar el monitoreo de logs y salud.
# ==============================================================================

mostrar_menu() {
    echo -e "\n=============================================="
    echo -e "     PROGRAMADOR DE TAREAS (CRON MANAGER)"
    echo -e "=============================================="
    echo "1) Ver tareas programadas actuales"
    echo "2) Programar monitoreo automático (Logs / Salud)"
    echo "3) Eliminar todas las tareas programadas"
    echo "4) Salir"
}

ver_tareas() {
    echo -e "\n--- Tareas activas en Crontab ---"
    crontab -l 2>/dev/null || echo "No hay tareas programadas actualmente."
}

agregar_tarea() {
    echo -e "\n--- Seleccione el script a automatizar ---"
    echo "1) monitor_logs.sh (Análisis de eventos críticos)"
    echo "2) alerta_sistema.sh (Chequeo de CPU, RAM y Disco)"
    read -p "Opción [1-2]: " sel_script

    case $sel_script in
        1) script_objetivo="$(pwd)/monitor_logs.sh" ;;
        2) script_objetivo="$(pwd)/alerta_sistema.sh" ;;
        *) echo "❌ Opción inválida."; return ;;
    esac

    if [ ! -f "$script_objetivo" ]; then
        echo "❌ Error: No se encontró '$script_objetivo'."
        return
    fi

    echo -e "\n--- Seleccione la frecuencia ---"
    echo "1) Cada 5 minutos (*/5 * * * *)"
    echo "2) Cada hora en punto (0 * * * *)"
    echo "3) Diario a las 08:00 AM (0 8 * * *)"
    echo "4) Personalizada (ingresar formato cron manual)"
    read -p "Opción [1-4]: " sel_freq

    case $sel_freq in
        1) frecuencia="*/5 * * * *" ;;
        2) frecuencia="0 * * * *" ;;
        3) frecuencia="0 8 * * *" ;;
        4) read -p "Ingrese expresión cron (ej. 0 8 30 * *): " frecuencia ;;
        *) echo "❌ Opción inválida."; return ;;
    esac

    # Inyección segura en crontab sin borrar tareas previas
    (crontab -l 2>/dev/null; echo "$frecuencia cd $(pwd) && $script_objetivo >> $(pwd)/cron_ejecucion.log 2>&1") | crontab -
    echo "✅ ¡Tarea programada exitosamente!"
    echo "   Regla: $frecuencia -> $script_objetivo"
}

eliminar_tareas() {
    read -p "⚠️  ¿Seguro que desea eliminar TODAS las tareas de cron? (s/n): " conf
    if [[ "$conf" == "s" || "$conf" == "S" ]]; then
        crontab -r 2>/dev/null
        echo "🗑️  Todas las tareas fueron eliminadas."
    else
        echo "Operación cancelada."
    fi
}

opcion=0
while [ "$opcion" -ne 4 ]; do
    mostrar_menu
    read -p "Seleccione una opción [1-4]: " opcion
    case $opcion in
        1) ver_tareas ;;
        2) agregar_tarea ;;
        3) eliminar_tareas ;;
        4) echo "Saliendo de Cron Manager..." ;;
        *) echo "❌ Opción inválida. Intente de nuevo." ;;
    esac
done

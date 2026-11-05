#!/bin/bash
# Módulo 4: Programador de tareas (Cron) - Interfaz Amigable

mostrar_menu() {
    echo -e "\n=============================================="
    echo -e "       PROGRAMADOR DE TAREAS (CRON)"
    echo -e "       Interfaz Amigable para Usuarios"
    echo -e "=============================================="
    echo "1) Ver tareas programadas"
    echo "2) Agregar nueva tarea (Ej: reporte diario)"
    echo "3) Eliminar todas las tareas"
    echo "4) Salir"
}

ver_tareas() {
    echo -e "\n--- Tareas programadas actuales ---"
    crontab -l 2>/dev/null || echo "No hay tareas programadas."
}

agregar_tarea() {
    echo -e "\n--- Agregar nueva tarea a Cron ---"
    echo "Ejemplo de horario: 0 8 * * * (Todos los días a las 08:00 AM)"
    read -p "Ingrese la frecuencia cron (ej. 0 8 * * *): " frecuencia
    
    # Ruta por defecto del script de sistema del proyecto
    ruta_default="$(pwd)/sistema.sh"
    read -p "Ruta del script a automatizar [$ruta_default]: " comando
    comando=${comando:-$ruta_default}

    if [ -f "$comando" ]; then
        # Agregar al crontab con redirección para el reporte fechado
        (crontab -l 2>/dev/null; echo "$frecuencia $comando >> $(pwd)/reporte_\$(date +\%F).txt") | crontab -
        echo "✅ ¡Tarea programada exitosamente en cron!"
    else
        echo "❌ Error: El script '$comando' no existe en esa ruta."
    fi
}

eliminar_tareas() {
    read -p "⚠️ ¿Desea eliminar todas las tareas programadas? (s/n): " conf
    if [[ "$conf" == "s" || "$conf" == "S" ]]; then
        crontab -r
        echo "🗑️ Se han eliminado todas las tareas del cron."
    else
        echo "Operación cancelada."
    fi
}

opcion=0
while [ "$opcion" -ne 4 ]; do
    mostrar_menu
    read -p "Seleccione una opcion (1-4): " opcion
    case $opcion in
        1) ver_tareas ;;
        2) agregar_tarea ;;
        3) eliminar_tareas ;;
        4) echo -e "\nSaliendo del programador de tareas..." ;;
        *) echo "❌ Opción inválida. Intente de nuevo." ;;
    esac
done

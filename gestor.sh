#!/bin/bash
# Módulo 2: Gestión de archivos

crear_archivo() {
    read -p "Ingrese el nombre del archivo a crear: " nombre
    touch "$nombre"
    echo "✅ Archivo '$nombre' creado exitosamente."
}

copiar_archivo() {
    read -p "Archivo origen: " origen
    if [ -f "$origen" ]; then
        read -p "Archivo destino: " destino
        cp "$origen" "$destino"
        echo "✅ Archivo copiado a '$destino'."
    else
        echo "❌ Error: El archivo '$origen' no existe."
    fi
}

cambiar_permisos() {
    read -p "Archivo para cambiar permisos a 644: " archivo
    if [ -f "$archivo" ]; then
        chmod 644 "$archivo"
        echo "✅ Permisos actualizados a 644:"
        ls -l "$archivo"
    else
        echo "❌ Error: El archivo '$archivo' no existe."
    fi
}

eliminar_archivo() {
    read -p "Archivo de prueba a eliminar: " archivo
    if [ -f "$archivo" ]; then
        read -p "⚠️ ¿Seguro que desea eliminar '$archivo'? (s/n): " conf
        if [[ "$conf" == "s" || "$conf" == "S" ]]; then
            rm "$archivo"
            echo "🗑️ Archivo eliminado."
        else
            echo "Operación cancelada."
        fi
    else
        echo "❌ Error: El archivo no existe."
    fi
}

opcion=0
while [ "$opcion" -ne 5 ]; do
    echo -e "\n=== Menú Gestor de Archivos ==="
    echo "1) Crear archivo"
    echo "2) Copiar archivo"
    echo "3) Cambiar permisos a 644"
    echo "4) Eliminar archivo (con confirmación)"
    echo "5) Salir"
    read -p "Elija una opción [1-5]: " opcion

    case $opcion in
        1) crear_archivo ;;
        2) copiar_archivo ;;
        3) cambiar_permisos ;;
        4) eliminar_archivo ;;
        5) echo "Saliendo..." ;;
        *) echo "Opción no válida." ;;
    esac
done

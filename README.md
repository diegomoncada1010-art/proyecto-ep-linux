# Proyecto EPP: Automatizacion de Administracion en Servidores Linux

## 1. Descripcion General
Este repositorio contiene una suite de scripts en Bash disenada para automatizar tareas criticas del area de TI en servidores Linux (Ubuntu/Debian). El proyecto soluciona la demora operativa y el riesgo de errores humanos en el monitoreo de recursos, la administracion de archivos, el filtrado de logs de almacenamiento y la generacion automatizada de reportes.

---

## 2. Estructura del Proyecto

| Archivo | Modulo | Descripcion |
| :--- | :--- | :--- |
| sistema.sh | Modulo 1 | Recolecta metricas del servidor y genera el reporte base. |
| gestor.sh | Modulo 2 | Menu interactivo para administracion segura de archivos y permisos. |
| analisis.sh | Modulo 3 | Analiza uso de disco con awk y transforma datos en copias con sed. |
| reporte_sistema.txt | Salida M1 | Reporte en texto plano con datos de usuario, OS y particiones. |
| servidores.txt | Datos M3 | Base de datos de prueba con porcentajes de uso de servidores. |
| servidores_copia.txt | Salida M3 | Archivo procesado y modificado automaticamente por sed. |

---

## 3. Requisitos e Instalacion
1. Sistema Operativo: Linux (Ubuntu 22.04/24.04 LTS o Windows Subsystem for Linux - WSL2).
2. Herramientas requeridas: bash, coreutils (df, chmod, cp, rm, touch), awk, sed, cron.
3. Asignar permisos de ejecucion a todos los scripts antes de iniciar:
   chmod +x sistema.sh gestor.sh analisis.sh

---

## 4. Documentacion de Scripts, Parametros y Ejemplos de Uso

### Modulo 1: Monitoreo del Sistema (sistema.sh)
Obtiene el estado actual del servidor utilizando comandos nativos (whoami, date, cat /etc/os-release, df -h) y redirecciona la salida hacia un archivo de texto plano.
- Parametros que acepta: Ninguno (ejecucion directa).
- Comando de ejecucion:
  ./sistema.sh
- Ejemplo de salida generada (reporte_sistema.txt):
  === Reporte de Monitoreo del Sistema ===
  Fecha y hora: 2026-10-31 20:15:00
  Usuario actual: DIEGO
  Distribución Linux: Ubuntu 24.04 LTS
  Espacio disponible en disco: (Tabla completa de particiones montadas)

### Modulo 2: Gestor de Archivos (gestor.sh)
Interfaz interactiva por consola construida con un bucle while, selector case, validaciones condicionales if [-f] y funciones modulares.
- Parametros interactivos que acepta:
  * Opcion 1 (Crear): Solicita el nombre del nuevo archivo (usa touch).
  * Opcion 2 (Copiar): Solicita ruta de origen y ruta de destino (valida existencia previa).
  * Opcion 3 (Permisos): Solicita nombre del archivo y aplica permisos 644 (rw-r--r--).
  * Opcion 4 (Eliminar): Solicita nombre del archivo y exige confirmacion (s/n) antes de borrar.
  * Opcion 5 (Salir): Finaliza el bucle del programa.
- Comando de ejecucion:
  ./gestor.sh
- Ejemplo de uso en consola:
  Seleccione una opcion [1-5]: 3
  Archivo para cambiar permisos a 644: prueba.txt
  Permisos actualizados a 644: -rw-r--r-- 1 DIEGO DIEGO 0 prueba.txt

### Modulo 3: Analisis de Informacion (analisis.sh)
Procesa un archivo con metricas de almacenamiento de múltiples servidores para detectar saturacion de disco y estandarizar nombres.
- Parametros que acepta: Ninguno (opera automaticamente sobre servidores.txt y crea servidores_copia.txt).
- Logica interna:
  1. Filtra con awk (NR > 1 && $2 > 70) omitiendo la cabecera e identificando servidores que superan el 70% de capacidad.
  2. Reemplaza en masa el prefijo "srv_" por "servidor_critico_" sobre el archivo de respaldo utilizando sed -i.
- Comando de ejecucion:
  ./analisis.sh
- Ejemplo de salida en consola:
  === 2. Servidores que superan el 70% de uso (awk) ===
  Alerta: srv_db_01 tiene 85% de uso de disco.
  Alerta: srv_app_01 tiene 72% de uso de disco.

### Modulo 4: Automatizacion y Reportes (Cron)
Programacion de tarea desatendida mediante el demonio cron para ejecutar el monitoreo todos los dias a las 08:00 AM y guardar un historial fechado.
- Verificacion de tarea activa:
  crontab -l
- Regla configurada en el servidor:
  0 8 * * * /home/DIEGO/proyecto_epp/sistema.sh >> /home/DIEGO/proyecto_epp/reporte_$(date +\%F).txt

---

## 5. Autor
- Diego Moncada (Ambiente de pruebas: DIEGO@diegomoncada)

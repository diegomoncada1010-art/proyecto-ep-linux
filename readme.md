# Proyecto EPP: Automatización de Administración en Servidores Linux

## 1. Descripción General del Proyecto
Este repositorio contiene una suite integral de scripts desarrollados en **Bash** para Linux (Ubuntu/Debian), diseñada específicamente para automatizar y optimizar las tareas rutinarias de administración de sistemas en el área de TI. El proyecto resuelve problemáticas críticas como la supervisión avanzada de recursos de hardware (CPU, RAM, red y almacenamiento), la gestión segura de archivos, el filtrado de logs mediante `awk`/`sed` y la programación interactiva de tareas desatendidas mediante un gestor de `cron`.

---

## 2. Estructura y Arquitectura del Repositorio

| Archivo / Módulo | Componente Técnico | Descripción Funcional |
| :--- | :--- | :--- |
| `sistema.sh` | Módulo 1 | Recolecta métricas avanzadas del procesador (CPU), kernel, memoria RAM, red y discos, generando un reporte detallado. |
| `gestor.sh` | Módulo 2 | Menú interactivo modular (`while`, `case`, `if`) para crear, copiar, asegurar permisos (`644`) y borrar archivos con confirmación. |
| `analisis.sh` | Módulo 3 | Analiza la saturación de discos mediante `awk` y aplica sustituciones masivas de nomenclaturas utilizando `sed`. |
| `cron_manager.sh` | Módulo 4 | Interfaz amigable de consola para la administración visual, control y programación del demonio `cron`. |
| `README.md` | Documentación | Manual técnico oficial del proyecto y guía de instalación y uso. |

---

## 3. Requisitos previos e Instalación

1. **Entorno de Ejecución:** Sistema operativo Linux (Ubuntu 22.04/24.04 LTS o Windows Subsystem for Linux - WSL2).
2. **Dependencias Requeridas:** Intérprete `bash`, utilidades Coreutils (`df`, `chmod`, `cp`, `rm`, `touch`), herramientas de análisis (`lscpu`, `awk`, `sed`), y el planificador del sistema (`cron`).
3. **Asignación de Permisos:** Antes de ejecutar los scripts por primera vez, otorga permisos de ejecución globales a los archivos dentro de la carpeta:
   ```bash
   chmod +x sistema.sh gestor.sh analisis.sh cron_manager.sh
## 4. Documentacion de Scripts, Parametros y Ejemplos de Uso

### Módulo 1: Monitoreo del Sistema (`sistema.sh`)
Obtiene el estado actual del servidor utilizando comandos nativos (`whoami`, `date`, `cat /etc/os-release`, `df -h`) y redirecciona la salida hacia un archivo de texto plano.
- **Parametros:** Ninguno (ejecucion directa).
- **Comando de ejecucion:**
  ```bash
  ./sistema.sh
  ```
- **Ejemplo de salida generada (`reporte_sistema.txt`):**
  ```text
  === Reporte de Monitoreo del Sistema ===
  Fecha y hora: 2026-10-31 20:15:00
  Usuario actual: DIEGO
  Distribución Linux: Ubuntu 24.04 LTS
  Espacio disponible en disco: (Tabla completa de particiones montadas)
  ```

### Módulo 2: Gestor de Archivos (`gestor.sh`)
Interfaz interactiva por consola construida con bucle `while`, selector `case`, validaciones condicionales `if [-f]` y funciones modulares.
- **Parametros interactivos:**
  * Opcion 1 (Crear): Solicita nombre del archivo (emplea `touch`).
  * Opcion 2 (Copiar): Solicita origen y destino (valida existencia previa).
  * Opcion 3 (Permisos): Aplica permisos `644` (`rw-r--r--`).
  * Opcion 4 (Eliminar): Exige confirmación explícita (`s/n`) antes de borrar.
  * Opcion 5 (Salir): Cierra el programa.
- **Comando de ejecucion:**
  ```bash
  ./gestor.sh
  ```

### Módulo 3: Analisis de Informacion (`analisis.sh`)
Procesa un archivo con metricas de almacenamiento de múltiples servidores para detectar saturacion de disco y estandarizar registros.
- **Parametros:** Ninguno (opera automaticamente sobre `servidores.txt` y crea `servidores_copia.txt`).
- **Logica interna:**
  1. Filtra con `awk` (`NR > 1 && $2 > 70`) omitiendo la cabecera e identificando servidores que superan el 70% de capacidad.
  2. Reemplaza en masa el prefijo `srv_` por `servidor_critico_` sobre el archivo de respaldo utilizando `sed -i`.
- **Comando de ejecucion:**
  ```bash
  ./analisis.sh
  ```

### Módulo 4: Programador de Tareas Interactivo (`cron_manager.sh`)
Gestor visual basado en menús para administrar las tareas automatizadas en el demonio `cron` sin requerir comandos de consola complejos.
- **Opciones del menú:**
  1. Ver tareas programadas (`crontab -l`)
  2. Agregar nueva tarea automatizada (con frecuencia personalizada y ruta de script)
  3. Eliminar todas las tareas programadas (`crontab -r`)
  4. Salir
- **Comando de ejecucion:**
  ```bash
  ./cron_manager.sh
  ```

---

## 5. Autor
- **Diego Moncada Alcázar** (Entorno de pruebas: Ubuntu / WSL2)

# Proyecto EPP: Automatizacion de Administracion en Servidores Linux

## 1. Descripcion General
Este repositorio contiene una suite avanzada de scripts en Bash disenada para automatizar tareas criticas del area de TI en servidores Linux (Ubuntu/Debian vía WSL2). El proyecto soluciona la demora operativa y el riesgo de errores humanos mediante monitoreo de recursos, administracion segura de archivos, analisis de almacenamiento y un gestor interactivo de tareas programadas.

---

## 2. Estructura del Proyecto y Modulos

| Archivo | Modulo | Descripcion |
| :--- | :--- | :--- |
| `sistema.sh` | Módulo 1 | Recolecta metricas del servidor y genera el reporte base en texto plano. |
| `gestor.sh` | Módulo 2 | Menu interactivo para creacion, copia, asignacion de permisos y borrado seguro. |
| `analisis.sh` | Módulo 3 | Analiza uso de disco con `awk` y transforma datos masivos en copias con `sed`. |
| `cron_manager.sh` | Módulo 4 | Interfaz amigable en consola para visualizar, agregar y eliminar tareas en `cron`. |
| `reporte_sistema.txt` | Salida M1 | Reporte generado con usuario activo, fecha, OS y particiones. |
| `servidores.txt` | Datos M3 | Base de datos de prueba con porcentajes de uso de almacenamiento. |
| `servidores_copia.txt` | Salida M3 | Archivo procesado y modificado automaticamente por `sed`. |

---

## 3. Requisitos e Instalacion
1. **Sistema Operativo:** Linux (Ubuntu 22.04/24.04 LTS o Windows Subsystem for Linux - WSL2).
2. **Herramientas requeridas:** `bash`, coreutils (`df`, `chmod`, `cp`, `rm`, `touch`), `awk`, `sed`, `cron`.
3. **Asignar permisos de ejecucion a todos los scripts antes de iniciar:**
   ```bash
   chmod +x sistema.sh gestor.sh analisis.sh cron_manager.sh
   ```

---

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
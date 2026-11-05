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

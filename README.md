# Proyecto EPP: Automatización de Administración en Servidores Linux

## 1. Descripción General del Proyecto
Este repositorio contiene una suite integral de scripts desarrollados en **Bash** para Linux (Ubuntu/Debian), diseñada específicamente para automatizar y optimizar las tareas rutinarias de administración de sistemas en el área de TI de una mediana empresa. El proyecto resuelve problemáticas críticas como la revisión manual de recursos, la gestión segura de archivos, el filtrado avanzado de logs de almacenamiento y la programación avanzada de tareas desatendidas mediante `cron`.

---

## 2. Arquitectura y Estructura del Repositorio

| Archivo / Módulo | Componente Técnico | Descripción Funcional |
| :--- | :--- | :--- |
| `sistema.sh` | Módulo 1 | Recolecta métricas del sistema (usuario, fecha, distribución y discos) y genera un reporte plano. |
| `gestor.sh` | Módulo 2 | Menú interactivo modular (`while`, `case`, `if`) para crear, copiar, asegurar (644) y borrar archivos. |
| `analisis.sh` | Módulo 3 | Analiza la saturación de discos mediante `awk` y aplica sustituciones en masa utilizando `sed`. |
| `cron_manager.sh` | Módulo 4 | Interfaz de consola amigable para la administración visual y control del demonio `cron`. |
| `README.md` | Documentación | Manual técnico detallado del proyecto y guía de instalación. |

---

## 3. Requisitos previos e Instalación

1. **Entorno de Ejecución:** Sistema operativo Linux (Ubuntu 22.04/24.04 LTS recomendado o Windows Subsystem for Linux - WSL2).
2. **Dependencias del Sistema:** Intérprete `bash`, utilidades básicas de Coreutils (`df`, `chmod`, `cp`, `rm`, `touch`), procesadores de texto `awk` y `sed`, y el planificador `cron`.
3. **Configuración de Permisos:** Antes de ejecutar los scripts por primera vez, es obligatorio otorgarles permisos de ejecución globales dentro de la carpeta del proyecto:
   ```bash
   chmod +x sistema.sh gestor.sh analisis.sh cron_manager.sh

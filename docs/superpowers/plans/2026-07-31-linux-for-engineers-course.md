# Plan de implementación de Linux para Ingenieros

**Estado:** draft

**Seguimiento operativo:** [GitHub Project #26](https://github.com/users/jeresoftx/projects/26)

## Fuente de verdad

RFC-0001 §2, §10, §13-§17, §20 y §24; RFC-0002; RFC-0003.

## Objetivo

Entregar un curso abierto y agnóstico de lenguaje que forme ingenieros capaces de usar Linux con criterio: comprender shell, archivos, texto, procesos, permisos, red, servicios y automatización pequeña mediante evidencia y laboratorios reproducibles, no memorización de comandos.

## Entorno canónico y límites

Los laboratorios se ejecutan en un contenedor Debian con Docker. No deben requerir `sudo`, modificar el host, usar credenciales, contactar sistemas externos ni ejecutar comandos destructivos sin una protección explícita. La documentación compara `systemctl`, `dnf` y `pacman`, pero no finge que están disponibles dentro del contenedor Debian.

Docker Desktop o Docker Engine es una dependencia externa ya autorizada para este curso. Si no está disponible o no puede obtenerse la imagen Debian, el trabajo de laboratorios se bloquea, pero documentación y scripts independientes pueden continuar.

## Fases

1. Fundación: alcance, seguridad, contrato de laboratorio y entorno Debian.
2. Shell y datos: navegación, archivos, texto, pipes, redirecciones y búsqueda.
3. Sistema local: permisos, usuarios, procesos, entorno, almacenamiento y archivos.
4. Conectividad: red, diagnóstico, SSH, transferencias, servicios y logs.
5. Automatización: paquetes, Bash, operación segura y recuperación.
6. Integración: laboratorio diagnóstico, glosario, referencias y auditoría draft.

## Ruta crítica

Fundación → shell y datos → sistema local → conectividad → automatización → integración. Cada fase contiene especificación docente, laboratorio aislado y capítulo con ejercicios y soluciones.

## Criterio de cierre

El curso queda completo como `draft` cuando cada unidad tenga concepto, problema, alternativas, límites, comandos explicados, Mermaid, laboratorio reproducible, ejercicios, soluciones y trazabilidad GitHub. El Project no debe tener issues o PRs abiertos, todos sus items deben estar en `Done`, los milestones deben estar auditados y `main` debe estar limpia.

## Ejecución trazable

El Project está agrupado por milestone. La ruta crítica avanza en orden por los issues #1 a #18; cada uno se entrega mediante una rama aislada, un commit principal y un PR que cierra el issue. Los PRs se fusionan en modo de revisión diferida y el contenido permanece en `draft` hasta una revisión humana.

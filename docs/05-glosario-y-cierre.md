# Laboratorio integrador, glosario y cierre

**Estado:** draft

## Diagnóstico de un servicio local

### Concepto y problema

Un incidente pequeño rara vez se entiende desde una sola orden. El caso
integrador simula un servicio local que escribe un log, escucha en loopback y
expone un archivo de estado con permisos restringidos. La tarea no es
"reiniciarlo hasta que funcione": es recolectar evidencia suficiente para
explicar su estado y aplicar solo un cambio recuperable.

```mermaid
flowchart LR
  L[Log sintético] --> H[Hipótesis]
  S[Socket local] --> H
  P[Proceso propio] --> H
  F[Archivo de estado] --> H
  H --> V[Verificación reproducible]
```

### Recorrido del laboratorio

1. Identifica el directorio temporal y el usuario efectivo.
2. Lee el log completo antes de filtrar el evento de advertencia.
3. Comprueba con `ss` que el socket pertenece al servicio propio.
4. Inspecciona el permiso del archivo de estado antes de corregirlo.
5. Envía una petición local, conserva la salida y espera al proceso creado por
   la práctica.
6. Comprueba que la limpieza eliminó únicamente el directorio temporal.

### Alternativas y límites

El caso no modela un despliegue distribuido, un gestor `systemd`, TLS real ni
credenciales. Para esos escenarios, el siguiente paso es un entorno que
represente explícitamente sus componentes y una política de acceso. La lección
transferible es el método: observar, formular hipótesis, actuar dentro de una
frontera y verificar la evidencia posterior.

### Ejercicios

1. Cambia el fixture para representar una advertencia repetida y adapta la
   comprobación sin usar una búsqueda ambigua.
2. Añade un modo dry-run que enumere la evidencia que revisaría el caso.
3. Explica por qué un socket abierto no prueba que el servicio procese una
   solicitud correctamente.

### Soluciones

1. Busca el identificador literal del evento y comprueba el conteo esperado.
2. Imprime rutas y comandos de observación, sin crear socket ni modificar el
   archivo de estado.
3. Una escucha solo prueba que alguien acepta conexiones; la petición y su
   evidencia prueban una parte adicional del protocolo y del manejo de datos.

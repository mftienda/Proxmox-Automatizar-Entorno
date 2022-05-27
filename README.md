# Proxmox: Línea de comandos.
## Descripción

La idea de este proyecto es automatizar un entorno de trabajo real.

Estamos en un centro educativo y necesitamos:

- Crear grupos de trabajo para alumnos.

- Crear usuarios y asignarles un determinado grupo.

- Crear pools uno para cada alumno(Proyecto.NombreAlumno) y uno común para guardar las plantillas (imagenes).

- Crear nuevos roles.

- Asignar a usuarios o a grupo,s permisos (roles) sobre los pools creados anteriormente.

- Poner a disposición de los usuarios plantillas de contenedores y máquinas virtuales.


La información estará guardada en un fichero llamado **usuarios.txt** .

Ese fichero puede ser lo complejo que se necesite. Para simplificarlo hemos supuesto que dicho fichero solo tiene dos campos:

nombre de usuario: contraseña

alumno01:contra01

alumno02:contra02


Veremos los comandos necesarios para automatizar el proceso.

Vamos a crear **pequeños scripts**, que vayan incrementando cada uno de los apartados.

Para finalizar lo haremos todo en un **script final**.

Espero que alguién le pueda servir.


## Contenidos
1. Conociendo el Clúster

  - [Conociendo el Clúster](modulo1/cluster.md)

2. Gestión de usuarios y grupos

  - [Gestión de usarios y grupos](modulo2/usuariosygrupos.md)

  - [Script: Creación masiva de usuarios](modulo2/creacionusuarios.md)

3. Creación de pools

 - [Gestión de pools](modulo3/gestionpools.md)
 
 - [Script: Creación de usuarios y pools](modulo3/creacionusuariospools.md)
 
4. Almacenamiento
  - [Gestion de almacenamiento](modulo4/gestionalmacenamiento.md)
  - [Script: Añadimos los almacenamientos a los pools](modulo4/creacionusuariospoolsalmacenamiento.md)
 
5. Permisos y roles
  - [Gestion de permisos](modulo5/gestionpermisos.md)
  - [Script: Añadimos permisos (roles) a los pools](modulo5/creacionusuariospoolsalmacenamientopermisos.md)

6. Plantillas

7. Script completo


## Referencias
  * [José Domingo Muñoz](https://plataforma.josedomingo.org/pledin/)
  * [proxmox](https://pve.proxmox.com/pve-docs/api-viewer)

## Licencia


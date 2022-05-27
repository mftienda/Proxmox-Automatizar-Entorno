# Asignaremos a los pools los roles para que los alumnos puedan acceder.

**usuarios.txt**

usuario01:contra01

usuario02:contra02

Primer campo: Nombre de usuario Segundo Campo: Contraseña

Vamos a crear:


- El grupo.  
- Los usuarios y se añadirán al grupo.
- un pool compartido para depositar posteriormente las plantillas (imagenes)
- Un pool para cada usuario (Proyecto.NombreAlumno)
- Añadiremos los almacenamientos local y local-lvm a los pools creados"
- Asignaremos a los pools los roles para que los alumnos puedan acceder.

[creacionusuariospoolsalmacenamiento.sh](creacionusuariospoolsalmacenamientoroles.sh)

#### Pool: imagenes

Vamos a crear un nuevo rol: **rol_imagenes** que permita a los grupo de alumnos clonar las máquinas.

Permisos: Pool.Audit, VM.Audit, VM.Clone

Después permiteremos que el grupo de alumnos, sobre ese pool, tenga ese rol.

#### Pool: Proyecto.NombreAlumno

Vamos a crea un nuevo rol: **rol_proyecto** que permita que cada alumno poder acceder a su pool y crear objetos.

Permisos: 
Datastore.AllocateSpace
Datastore.Audit
Permissions.Modify
Pool.Audit
Sys.Audit
Sys.Console                                                                                        
Sys.Modify                                                                                         
Sys.Syslog
VM.Allocate                                                                                        
VM.Audit                                                                                           
VM.Backup                                                                                          
VM.Clone                                                                                           
VM.Config.CDROM                                                                                    
VM.Config.CPU                                                                                      
VM.Config.Cloudinit                                                                                
VM.Config.Disk                                                                                     
VM.Config.HWType                                                                                   
VM.Config.Memory                                                                                   
VM.Config.Network                                                                                  
VM.Config.Options                                                                                  
VM.Console                                                                                         
VM.Migrate                                                                                         
VM.Monitor                                                                                         
VM.PowerMgmt                                                                                       
VM.Snapshot                                                                                        
VM.Snapshot.Rollback


```



```

# Gestión de permisos

#### Visualizamos los roles existentes

` pvesh get /access/roles/`

![image](img/roles.png)

#### Crear un rol y añadir permisos

`pvesh create /access/roles --roleid rol_prueba --privs VM.Audit`

`pvesh get /access/roles/`

![image](img/rolescrear.png)


#### Eliminar un rol

`pvesh delete /access/roles/rol_prueba`

### Roles y permisos que utilizaremos
```
Crearemos  el rol: rol_imagenes
pvesh create /access/roles --roleid rol_imagenes --privs Pool.Audit,VM.Audit,VM.Clone
# Asignamos al pool imagenes los roles para que pueda acceder el grupo de alumnos
pvesh set /access/acl -path /pool/imagenes -roles rol_imagenes -groups "$grupo"
#---------------------------------------------------------------------------------
# Crearemos el rol: rol_proyecto
pvesh create /access/roles  --roleid rol_proyecto --privs Datastore.AllocateSpace,\
Datastore.Audit,Permissions.Modify,Pool.Audit,Sys.Audit,Sys.Console,Sys.Modify,\
Sys.Syslog,VM.Allocate,VM.Audit,VM.Backup,VM.Clone,VM.Config.CDROM,VM.Config.CPU,\
VM.Config.Cloudinit,VM.Config.Disk,VM.Config.HWType,VM.Config.Memory,VM.Config.Network,\
VM.Config.Options,VM.Console,VM.Migrate,VM.Monitor,VM.PowerMgmt,VM.Snapshot,VM.Snapshot.Rollback
```

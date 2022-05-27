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

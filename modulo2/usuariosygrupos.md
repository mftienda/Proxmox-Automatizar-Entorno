# Usuarios y grupos 

##  Información de los grupos

`pvesh get /access/groups`

![img](img/grupos.png)

## Crear un grupo

`pvesh create /access/groups --groupid asir2`

![img](img/asir2a.png)

## Eliminar un grupo

`pvesh delete /access/groups/asir2`

![img](img/asir2b.png)

## Información de los usuarios

`pvesh get /access/users`

![img](img/usuarios.png)

## Crear un usuario con contraseña 
`pvesh create /access/users --userid heidi@pve --password "heidi"`

pve: Representa el ámbito: Proxmox VE authentication server

![img](img/heidi.png)

## Borrar un usuario
`pvesh delete /access/users/heidi@pve`


## Añadir un usuario a un grupo

#### Creamos el grupo: asir2
`pvesh create /access/groups --groupid asir2`

#### Creamos el usuario: heidi
`pvesh create /access/users --userid heidi@pve --password "heidi"`

#### Añadimos el usuario a dicho grupo
`pvesh set /access/users/heidi@pve --groups asir2`

![img](img/heidiasir2.png)


#### Quitar un usuario de un grupo






# Creación del entorno

[usuarios.txt](usuarios.txt)

[creacionentorno.sh](creacionentorno.sh)

```
#!/bin/bash
clear
echo "\n Fecha: $(date +%d-%m-%Y) \n"
echo "*********************************************************************************"
echo "CREACIÓN DEL ENTORNO DE TRABAJO.\n"
echo "Se preguntará: el nombre del grupo y la ruta absoluta del archivo usuarios(nombreUsuario:contraseña)\n"
echo "1.- Se crea el grupo."
echo "2.- Se crea el pool:imagenes,añadimos los almacenamiento,creamos el rol_imagenes y lo asignamos al pool y al grupo."
echo "3.- Se crea el rool:rol_proyecto."
echo "4.- Se crea los usuarios, se añadirán al grupo, se creará un pool por usuario, añadimos los almacenamientos"
echo "  y se le asignará el rol_proyecto a cada pool y usuario."
echo "*********************************************************************************"
echo "\n"
#---------------------------------------------------------------------------------
read -p "Introduce el nombre del grupo de usuarios:" grupo
#Creamos el grupo
pvesh create /access/groups --groupid "$grupo"
read -p "Introduce la ruta absoluta del fichero: " ruta
# Comprobamos la ruta del fichero
if [ ! -f "$ruta" ]
then
        echo "El fichero No existe"
        exit 0
fi 
#---------------------------------------------------------------------------------
#Creamos el pool imagenes
pvesh create pools -poolid imagenes
#Añadimos los almacenamientos: local y local-lvm"
pvesh set /pools/imagenes -storage local,local-lvm
#---------------------------------------------------------------------------------
# Creamos el rol: rol_imagenes
pvesh create /access/roles --roleid rol_imagenes --privs Pool.Audit,VM.Audit,VM.Clone
# Asignamos al pool imagenes los roles para que pueda acceder el grupo de alumnos
pvesh set /access/acl -path /pool/imagenes -roles rol_imagenes -groups "$grupo"
#---------------------------------------------------------------------------------
# Creamos el rol: rol_proyecto
pvesh create /access/roles  --roleid rol_proyecto --privs Datastore.AllocateSpace,\
Datastore.Audit,Permissions.Modify,Pool.Audit,Sys.Audit,Sys.Console,Sys.Modify,\
Sys.Syslog,VM.Allocate,VM.Audit,VM.Backup,VM.Clone,VM.Config.CDROM,VM.Config.CPU,\
VM.Config.Cloudinit,VM.Config.Disk,VM.Config.HWType,VM.Config.Memory,VM.Config.Network,\
VM.Config.Options,VM.Console,VM.Migrate,VM.Monitor,VM.PowerMgmt,VM.Snapshot,VM.Snapshot.Rollback
#---------------------------------------------------------------------------------
#Leemos el fichero
#---------------------------------------------------------------------------------
#
while read linea
do
usuario=$(echo "$linea"|cut -d: -f1)
contra=$(echo  "$linea"|cut -d: -f2)
#Creamos el usuario
pvesh create /access/users --userid "$usuario"@pve --password "$contra"
# Añadimos el usuario al grupo
pvesh set /access/users/"$usuario"@pve --groups "$grupo"
# Creamos un pool por usuario
pvesh create pools -poolid "Proyecto.$usuario"
echo "Proyecto.$usuario" >>proyectos.tmp
#Añadimos los almacenamientos: local y local-lvm" a cada usuario
pvesh set /pools/"Proyecto.$usuario" -storage local,local-lvm
# Asignamos los roles a cada pool para que pueda acceder los usuarios
pvesh set /access/acl -path /pool/"Proyecto.$usuario" -roles rol_proyecto -users "$usuario@pve"
done <"$ruta"
#---------------------------------------------------------------------------------
echo "--------------Infome ---------------"
echo "Grupo creado: $grupo"
echo "Usuarios del grupo: \n"
pvesh get /access/groups/"$grupo"
echo "Los proyectos creados son: \n"
cat proyectos.tmp
rm -r proyectos.tmp
echo "\n ***** Fin ******"
#---------------------------------------------------------------------------------

root@pve:~# 
```

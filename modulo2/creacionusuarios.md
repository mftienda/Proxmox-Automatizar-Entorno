# Creación masiva de usuarios

## usuarios.txt
usuario01:contra01
usuario02:contra02

Primer campo: Nombre de usuario
Segundo Campo: Contraseña

## Descripción de script:

1.- Pregunta el grupo de usuarios y lo crea.

2.- Lee del fichero usuarios.txt y extrae el usuario y contraseña

3.- Crea los usuarios y los añade al grupo anterior.

[creacionusuarios.sh](creacionusuarios.sh)

```
#!/bin/bash
clear
echo "*********************************************************************************"
echo "CREACIÓN MASIVA DE USUARIOS.\n"
echo "Se preguntará: \n"
echo "Nombre del grupo\n"
echo "Ruta del archivo usuarios ( nombre_usuario:contraseña:\n"
echo "*********************************************************************************"
echo "\n"
date
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
#Leemos el fichero
while read linea
do
usuario=$(echo "$linea"|cut -d: -f1)
contra=$(echo  "$linea"|cut -d: -f2)
#Creamos el usuario
pvesh create /access/users --userid "$usuario"@pve --password "$contra"
# Añadimos el usuario al grupo
pvesh set /access/users/"$usuario"@pve --groups "$grupo"
done <"$ruta"
echo "\n El grupo y los usuarios creados: \n"
echo "Grupo: $grupo"
pvesh get /access/groups/"$grupo"
echo "\n ***** Fin ******"
```


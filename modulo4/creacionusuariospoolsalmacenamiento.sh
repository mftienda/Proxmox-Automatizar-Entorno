#!/bin/bash
clear
echo "*********************************************************************************"
echo "CREACIÓN MASIVA DE USUARIOS y POOLS.\n"
echo "Se preguntará: \n"
echo "Nombre del grupo\n"
echo "Ruta del archivo usuarios ( nombre_usuario:contraseña:\n"
echo "1.- Se creará el grupo"
echo "2.- Se crearán los usuarios y se añadirán al grupo"
echo "3.- Se creará un pool compartido para depositar posteriormente las plantillas:imagenes"
echo "4.- Se creará un pool: Proyecto.NombreUsuario por cada usuario"
echo "5.- Añadiremos los almacenamientos local y local-lvm a los pools creados"
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
# Creamos un pool por usuario
pvesh create pools -poolid "Proyecto.$usuario"
echo "Proyecto.$usuario" >>proyectos.tmp
#Añadimos los almacenamientos: local y local-lvm"
pvesh set /pools/"Proyecto.$usuario" -storage local,local-lvm
done <"$ruta"
#Creamos el pool imagenes
pvesh create pools -poolid imagenes
#Añadimos los almacenamientos: local y local-lvm"
pvesh set /pools/imagenes -storage local,local-lvm
echo "--------------Infome ---------------"
echo "Grupo creado: $grupo"
echo "Usuarios del grupo: \n"
pvesh get /access/groups/"$grupo"
echo "Los proyectos creados son: \n"
cat proyectos.tmp
rm -r proyectos.tmp
echo "\n ***** Fin ******"


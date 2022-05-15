#!/bin/bash
# Creación de usuarios en Proxmox
clear
echo "Creación de Usuarios"
read -p "Introduce curso: (asir1,asir2):" curso
read -p "Cuantos usuarios quieres crear:" numero 
#Creamos los usuarios
for i in $(seq 1 $numero)
do
usuario=$curso.$i
#Creamos el usuario
pveum useradd "$usuario@pve"
#Le asignamos una contraseña
pvesh set /access/password \
	--userid "$usuario@pve" \
	 --password "$usuario"
#Creamos un pool para cada usuario
pvesh create pools -poolid "Proyecto.$usuario"
#Asignamos los permisos a los pools
pvesh set /access/acl \
	-path /pool/"Proyecto.$usuario" \
	-roles PVEVMAdmin \
	-roles PVEDatastoreUser \
	-roles PVEPoolUser \
	-users "$usuario@pve"
done

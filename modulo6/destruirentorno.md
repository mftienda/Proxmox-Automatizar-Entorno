# Destruir el entorno

[usuarios.txt](usuarios.txt)

[destruirentorno.sh](destruirentorno.sh)

### El script destruye los datos asociados a los usuarios: grupo, usuarios y pools.
### Dejamos el pool images y los roles creados

```
#!/bin/bash
#Asumimos que el nodo se llama pve
NODO="pve"
clear
echo "\n Fecha: $(date +%d-%m-%Y) \n"
echo "******************************************"
echo "DESTRUCIÓN DEL ENTORNO DE TRABAJO.\n"
echo "1.-Borramos el grupo de usuarios"
echo "2.-Seleccionamos un usuario y lo borramos."
echo "3.-Para el pool del usuario, borramos las máquinas virtuales y contenedores."
echo "4.-Para el pool del usuario, borramos los almacenamientos"
echo "5.-Borramos el pool de cada usuario"
echo "******************************************"
echo "\n"
#---------------------------------------------------------------------------------
echo "Grupos del sistema actualmente: \n"
pvesh get access/groups
read -p "Grupo que quieres borrar (Intro para ignorar):" grupo
#Borramos el grupo
if [ ! -z $grupo ]
then
pvesh delete /access/groups/"$grupo"
echo "El grupo: $grupo ha sido borrado"
fi
read -p "Ruta absoluta del fichero: (usuario:contra) " ruta
# Comprobamos la ruta del fichero
if [ ! -f "$ruta" ]
then
	echo "El fichero No existe"
	exit 0
fi 
#---------------------------------------------------------------------------------
#Leemos el fichero
while read fichero
do
# Seleccionamos el usuario y lo borramos 
	usuario=$(echo "$fichero"|cut -d: -f1)
	pvesh delete /access/users/"$usuario@pve" 
	echo "+++++++++++++++++++++++++++++++++++"
	echo "El usuario: $usuario ha sido borrado"
#Para el pool del usuario, borramos las máquinas (Miembro)
	pvesh get /pools/Proyecto."$usuario" --output-format yaml \
	|grep vmid |cut -d: -f2 >maquinasborrar.tmp
	if [ -s maquinasborrar.tmp ] #Comprobamos que tiene datos
	then
		while read maquina
		do
			qm stop "$maquina" >/dev/null
			qm destroy "$maquina" >/dev/null
			echo "Máquina borrada: $maquina"
		done < maquinasborrar.tmp
	fi
#Para el pool del usuario, borramos los contenedores (Miembro)
	pvesh get /pools/Proyecto."$usuario" --output-format yaml \
	|grep lxc|grep id:|cut -d/ -f2 >contenedores.tmp
# No utilizamos pvesh get /nodes/pve/lxc porque muestra todos los lxc
# y solo me interesa los del usuario01
	if [ -s contenedores.tmp ] #Comprobamos si tiene datos
	then
		while read contenedor
		do
			pvesh delete /nodes/"$NODO"/lxc/"$contenedor" -force
			echo "Contenedor borrado: $contenedor"
		done < contenedores.tmp
	fi

#Para el pool del usuario, borramos el storage (Miembro)
	pvesh get /pools/Proyecto."$usuario" --output-format yaml \
	|grep "storage:"|cut -d: -f2 >storage.tmp
# Cuidado se carga el storage de todo proxmox
	if [ -s storage.tmp ] #Comprobamos si tiene datos
	then
		while read storage
		do
			pvesh set /pools/Proyecto."$usuario" -delete -storage "$storage" >/dev/null
			echo "Storage borrado: $storage"
		done < storage.tmp
	fi
#Eliminamos el pool: Se supone que ya está vacío
	pvesh delete /pools/Proyecto."$usuario"
	echo "Proyecto borrado: Proyecto.$usuario"
done < "$ruta"
#Borramos los archivos temporales
rm -r maquinasborrar.tmp contenedores.tmp storage.tmp

```

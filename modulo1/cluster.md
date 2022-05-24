# Conociendo el Clúster

## Versión de Proxmox.
`pvesh get /version`

![img](img/version.png)

## Información del estado del clúster.
`pvesh get /cluster/status`

![img](img/estado.png)

## Información de los logs
`pvesh get /cluster/log`

![img](img/logs.png)

## Nos muestra los recursos del clúster.
`pvesh get /cluster/resources`

![img](img/recursos.png)

## Nos muestra las máquinas virtuales.
`pvesh get /cluster/resources --type vm `

![img](img/maquinas.png)

## Nos muestra el almacenamiento.
`pvesh get /storage`

![img](img/almacenamiento.png)

## Nos muestra los pools existentes.
`pvesh get pools`

![img](img/pools.png)

## Nos muestra información de los nodos.
`pvesh get /nodes `

![img](img/nodos.png)



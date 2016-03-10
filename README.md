# orga-compus
Organizacion de computadoras 66.20
PRE REQUISITO: HABER DESCOMPRIMIDO EL TAR EN UNA CARPETA QUE SE LLAME gxemul-6620-20070927

Para iniciar la maquina virtual:

1) Ejecutar el script init-gx.sh
Abrir una consola (Consola 1) y
--> ./init-gx.sh

2) La autenticacion es:
--> user: root
--> pass: orga6620

3) Hacer el tunel ssh. 
Abrir una nueva consola (Consola 2) y seguir estos pasos:

Para esto hay que instalar el paquete openssh-server si todavia no esta
instalado.

--> sudo apt-get install openssh-server

Iniciar el servicio:

--> sudo service ssh start
(Si dice already running es porque ya esta iniciado)

Crear la interfaz de red:
--> sudo ifconfig lo:0 172.20.0.1

VOLVER A LA CONSOLA 1!!!
Crear el tunel ssh.
--> ssh -R 2222:127.0.0.1:22 usuario@172.20.0.1
DONDE usuario ES TU NOMBRE DE USUARIO DE LINUX

Luego de autenticarse, la Consola 1 no se debe tocar mas

Vuelvo a la Consola 2.

Desde aca puedo hacer 2 cosas Y SIEMPRE HAY QUE USAR EL PUERTO DE SALIDA 2222:

1) Enviar archivos, como el tp, para poder ejecutarlos en VM:
--> scp -P2222 -r tp0 root@127.0.0.1:/root
Tambien se puede usar sftp
--> sftp -oPort=2222 root@127.0.0.1

2) Conectarme a la maquina virtual para ejecutar el tp.
--> ssh -p 2222 root@127.0.0.1

Resumen:

Consola 1:
./init-gx.sh
root
orga6620

Consola 2:
sudo service ssh start
sudo ifconfig lo:0 172.20.0.1

Consola 1:
ssh -R 2222:127.0.0.1:22 usuario@172.20.0.1

Consola 2:
ssh -p 2222 root@127.0.0.1

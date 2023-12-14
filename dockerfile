# Utilizamos Alpine por su simplicidad y ligereza
FROM alpine:latest

# Instalamos OpenSSH, sshpass para la autenticación de contraseña y otros paquetes útiles
RUN apk add --no-cache openssh-client sshpass bash

# Creamos un directorio para los scripts y para las claves SSH
RUN mkdir /scripts /ssh-keys
WORKDIR /scripts

# Añadimos el script para iniciar el túnel SSH
COPY start-ssh-tunnel.sh /scripts/
RUN chmod +x /scripts/start-ssh-tunnel.sh

# Ejecutamos el script al iniciar el contenedor
CMD ["/scripts/start-ssh-tunnel.sh"]

#!/bin/bash

# Determinar comando SSH basado en método de autenticación
if [ "$USE_SSH_KEY" = "true" ]; then
    SSH_CMD="ssh -i /ssh-keys/ssh_key -o StrictHostKeyChecking=no"
else
    SSH_CMD="sshpass -p $SSH_PASS ssh -o StrictHostKeyChecking=no"
fi

# Interpretar la configuración del túnel
IFS=',' read -ra TUNNELS <<< "$TUNNEL_CONFIG"

for i in "${TUNNELS[@]}"; do
    IFS=':' read -ra TUNNEL <<< "$i"
    ORIGIN_PORT=${TUNNEL[0]}
    DEST_HOST=${TUNNEL[1]}
    DEST_PORT=${TUNNEL[2]}

    $SSH_CMD -4 -N $SSH_USER@$SSH_HOST \
             -p $SSH_PORT \
             -L $ORIGIN_PORT:$DEST_HOST:$DEST_PORT \
             -o ExitOnForwardFailure=yes &
done

# Mantener el script en ejecución
wait

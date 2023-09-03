#!/bin/bash

# Script para realizar un escaneo de puertos en una dirección IP especificada

# Verifica si se proporcionó una dirección IP como argumento
if [ "$1" ]; then
    ip_address="$1"
    echo "Iniciando escaneo de puertos en la dirección IP: $ip_address"

    # Bucle para iterar a través de los puertos del rango 1-65535
    for port in $(seq 1 65535); do
        # Ejecuta el comando timeout para intentar conectarse al puerto
        (timeout 1 bash -c "echo > /dev/tcp/$ip_address/$port" 2>/dev/null &&
         echo " [ * ]El puerto $port está abierto") & # Si el puerto está abierto, imprime un mensaje

    done

    # Espera a que todos los subprocesos en segundo plano finalicen
    wait
else
    # Si no se proporcionó una dirección IP, muestra un mensaje de uso
    echo -e "\n[*] Uso: ./portscan.sh <ip_address>\n"
    exit 1
fi

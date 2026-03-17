#!/bin/bash

echo "Iniciando Operación CPU-ZERO..."

sleep 2

# Validar root
if [ "$EUID" -ne 0 ]; then
  echo "Ejecuta como root: sudo bash setup.sh"
  exit 1
fi

# Crear usuario sospechoso
useradd -m -s /bin/bash intruso 2>/dev/null
echo "intruso:1234" | chpasswd

# Procesos maliciosos
sudo -u intruso bash -c "while :; do :; done &"
sudo -u intruso bash -c "yes > /dev/null &"
sudo -u intruso bash -c "sleep 99999 &"

# Bandera
echo "flag{cpu_detected}" > /opt/flag_cpu.txt
chmod 600 /opt/flag_cpu.txt

# Log falso
echo "WARNING: unusual CPU usage detected from user intruso" >> /var/log/syslog

echo ""
echo "El sistema presenta comportamiento anómalo..."
echo "Analiza el sistema y encuentra el problema"
echo ""

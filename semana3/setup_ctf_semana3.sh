#!/bin/bash

echo "Iniciando Operación OOM..."

# Validar root
if [ "$EUID" -ne 0 ]; then
  echo "Ejecuta como root"
  exit 1
fi

# Crear usuario sospechoso
useradd -m -s /bin/bash memoria 2>/dev/null
echo "memoria:1234" | chpasswd

# Script consumidor de RAM
cat << 'EOF' > /home/memoria/consume_ram.sh
#!/bin/bash
a=()
while true; do
  a+=("$(head -c 1M </dev/zero)")
done
EOF

chmod +x /home/memoria/consume_ram.sh
chown memoria:memoria /home/memoria/consume_ram.sh

# Ejecutar consumo de memoria
sudo -u memoria bash /home/memoria/consume_ram.sh &

# Crear pista en logs
echo "WARNING: memory usage critical for user memoria" >> /var/log/syslog

# Bandera
echo "flag{oom_detected}" > /opt/flag_memoria.txt
chmod 600 /opt/flag_memoria.txt

echo "El sistema presenta fallos intermitentes..."

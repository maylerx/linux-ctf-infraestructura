#!/bin/bash

echo "Reseteando entorno..."

userdel -r intruso 2>/dev/null
rm -f /opt/flag_cpu.txt

echo "Sistema limpio"

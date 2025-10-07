# NOTAS
---

Encender la interfaz
---
```bash
sudo ip link set enp1s0 up
```

Verificar estado
---
```bash
ip link show enp1s0
```
Debería decir: state UP instead of DOWN

Información del módulo SFP
---
```bash
sudo ethtool -m enp1s0
```

Ver capacidades y enlace
---
```bash
sudo ethtool enp1s0
```
Buscar: "Link detected: yes" y "Speed: 10000Mb/s"

Asignar IP en subred privada
---
```bash
sudo ip addr add 192.168.1.100/24 dev enp1s0
```

Verificar configuración
---
```bash
ip addr show enp1s0
```

Probar broadcast
---
```bash
echo "TEST" | nc -u -b 192.168.1.255 1234
```
Deberías ver el mensaje UDP enviado a 192.168.1.255 al puerto 1234

Procedimiento CORRECTO para cambiar transceptores
---
1. Apagar la interfaz primero
```bash
sudo ip link set enp1s0 down
```
2. Esperar 2-3 segundos
3. Retirar el transceptor actual
4. Insertar el nuevo transceptor
5. Encender la interfaz
```bash
sudo ip link set enp1s0 up
```
6. Verificar nuevo enlace
```bash
sudo ethtool enp1s0
```
sudo ip addr flush dev enp1s0

Eliminar todas las IPs de enp1s0
---
```bash
sudo ip addr flush dev enp1s0
```
Enviar mensaje simple a la FPGA
---
```bash
echo "HOLA_FPGA" | nc -u 192.168.1.128 1234
```
Jumbo Frames
---
```bash
sudo ip link set dev enp1s0 mtu 9000
```
Enviar paquete de datos
---
```bash
dd if=/dev/zero bs=8192 count=111500 | pv -brt | socat -u - "UDP-SENDTO:192.168.1.128:1234"
```
COmpilar y ejecutar programa para enviar datos a la fpga
---
```bash
gcc -O3 -pthread -o udp_multithread udp_multithread.c
./udp_multithread
```
Monitorear trafico de datos
---
```bash
ifstat -i enp1s0 1
```
Monitoreo de recursos
---
```bash
htop
```
Inicio de envio de datos hacia el servidor
---
```bahs
echo -n "....INIT" | nc -u -w 1 192.168.1.128 1234
```
Alto de envio de datos hacia el servidor
```bash
echo -n "....FINI" | nc -u -w 1 192.168.1.128 1234
```
Envio de datos por 1 segundo
---
```bash
fpga_init 
sleep 1
fpga_fini
```
Vista de 10 primeras lineas de un .bin
---
```bash
hexdump -C fpga_data_0000.bin | head -10
```

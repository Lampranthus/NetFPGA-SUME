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

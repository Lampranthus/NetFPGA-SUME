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
Vista de ultimas lineas
```bash
tail -c 160 fpga_final_0000.bin | hexdump -C
```
Prueba de escritura
---
```bash
sudo fio --name=basic_write \
  --ioengine=libaio \
  --rw=write \
  --bs=1M \
  --iodepth=32 \
  --numjobs=4 \
  --size=4G \
  --runtime=30 \
  --time_based \
  --group_reporting \
  --direct=1
```
Importante
---
AUmentar buffers del sistema
```bash
sudo nano /etc/sysctl.d/99-network-tuning.conf

# Agregar:
net.core.rmem_max = 268435456
net.core.wmem_max = 268435456
net.core.rmem_default = 67108864
net.core.wmem_default = 67108864
net.core.optmem_max = 67108864
net.ipv4.udp_mem = 67108864 134217728 268435456

# Aplicar
sudo sysctl -p /etc/sysctl.d/99-network-tuning.conf
```
desactivar firewall
```bash
sudo ufw disable
```
Coalensce
---
Parametros de Coalensce
```bash
sudo ethtool -c enp4s0
```
DESHABILITAR INTERRUPT COALESCING COMPLETAMENTE para interrupciones instantaneas
```bash
sudo ethtool -C enp4s0 rx-usecs 0
```
Ver drops del kernel
```bash
sudo ip -s link show enp4s0
```
Ver estadisticas de tarjeta de red
```bash
sudo ethtool -g enp4s0
```
Configurar nic
```bash
sudo ethtool -G enp4s0 tx 8192
sudo ethtool -G enp4s0 rx 8192
```
Para capturar tráfico UDP desde/hacia 192.168.1.128 en tu interfaz enp4s0
```bash
sudo tcpdump -i enp4s0 -s 0 -w tcpdump.pcap host 192.168.1.128 and udp
```
Pasar a .pcap a txt
```bahs
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
Vista de ultimas lineas
```bash
tail -c 160 fpga_final_0000.bin | hexdump -C
```
Prueba de escritura
---
```bash
sudo fio --name=basic_write \
  --ioengine=libaio \
  --rw=write \
  --bs=1M \
  --iodepth=32 \
  --numjobs=4 \
  --size=4G \
  --runtime=30 \
  --time_based \
  --group_reporting \
  --direct=1
```
Importante
---
AUmentar buffers del sistema
```bash
sudo nano /etc/sysctl.d/99-network-tuning.conf

# Agregar:
net.core.rmem_max = 268435456
net.core.wmem_max = 268435456
net.core.rmem_default = 67108864
net.core.wmem_default = 67108864
net.core.optmem_max = 67108864
net.ipv4.udp_mem = 67108864 134217728 268435456

# Aplicar
sudo sysctl -p /etc/sysctl.d/99-network-tuning.conf
```
desactivar firewall
```bash
sudo ufw disable
```
Coalensce
---
Parametros de Coalensce
```bash
sudo ethtool -c enp4s0
```
DESHABILITAR INTERRUPT COALESCING COMPLETAMENTE para interrupciones instantaneas
```bash
sudo ethtool -C enp4s0 rx-usecs 0
```
Ver drops del kernel
```bash
sudo ip -s link show enp4s0
```
Ver estadisticas de tarjeta de red
```bash
sudo ethtool -g enp4s0
```
Configurar nic
```bash
sudo ethtool -G enp4s0 tx 8192
sudo ethtool -G enp4s0 rx 8192
```
Para capturar tráfico UDP desde/hacia 192.168.1.128 en tu interfaz enp4s0


```bash
sudo tcpdump -i enp4s0 -s 0 -w tcpdump.pcap host 192.168.1.128 and udp
```
Convertir .pcp a .txt
```bash
sudo tshark -r tcpdump.pcap -d udp.port==9999,data -Y "udp.port == 9999" -T fields -e data |   tr -d '\r' |   awk '{print substr($0,0,16)","substr($0,17,16)","substr($0,1009,16)}' > xB_timestamp_i.txt
```
Función: Extrae una subcadena (substring) del string

Sintaxis: substr(string, inicio, longitud)

Parámetros:

String: $0 (todo el string hex)

Inicio: posición 16

Longitud: 16 caracteres

Setear la mac de la fpga
---

```bash
sudo arp -s 192.168.1.128 02:00:00:00:00:00
```
Latencya ARP
```bash
sudo arping -I enp4s0 -c 10 192.168.1.128
```
Test PC FPGA PC loopback
---
Capura en una terminal
```bash
sudo tcpdump -i enp4s0 -s 0 -w 8192Bloop.pcap host 192.168.1.128 and udp
```
Envio en otra terminal
```bash
hping3 192.168.1.128 -2 -p 1234 -d 8192 --fast -c 1000
```
formateo de .pcap
```bash
sudo tshark -r 512Bloop.pcap -Y "udp" -T fields -e frame.time_epoch -e ip.src > tiempos_512B.txt
```
extraccione de Round-Trip Time del loopback
```bash
awk '{if($2=="192.168.1.100"){ida=$1}else{print ($1-ida)*1000000}}' tiempos_512B.txt > rtts_512B.txt
```
RTT test
---
Comportamiento con usecs 0 
-
<img width="4200" height="2400" alt="rtt_vs_payload" src="https://github.com/user-attachments/assets/35481cf7-3fd6-4287-8287-63a77a9e4c9c" />

Comportamiento con rx-usecs 1 tx-usecs 0
-
<img width="4200" height="2400" alt="rtt_vs_payload" src="https://github.com/user-attachments/assets/b870c07b-589c-4ce0-b873-d384a5695485" />






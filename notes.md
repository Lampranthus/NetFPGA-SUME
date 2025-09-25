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
sudo ip addr add 10.0.0.1/30 dev enp1s0
```

Verificar configuración
---
```bash
ip addr show enp1s0
```

Ping a sí mismo (prueba loopback)
---
```bash
ping -c 5 -I enp1s0 10.0.0.1
```
Deberías ver respuestas successful

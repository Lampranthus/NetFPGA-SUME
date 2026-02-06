#!/usr/bin/env python3
import struct
import sys

def parse_fpga_data(input_file, output_file):
    with open(input_file, 'rb') as f:
        data = f.read()
    
    # Tamaño de cada mensaje UDP
    udp_size = 256
    # Tamaño de cada entero (8 bytes = 64 bits)
    int_size = 8
    
    with open(output_file, 'w') as f_out:
        # Procesar cada mensaje UDP
        for msg_num in range(0, len(data), udp_size):
            msg_data = data[msg_num:msg_num + udp_size]
            if len(msg_data) < udp_size:
                break
                
            f_out.write(f"\n=== Mensaje UDP {msg_num//udp_size} (bytes {msg_num}-{msg_num+udp_size-1}) ===\n")
            
            # Procesar cada entero de 8 bytes
            for i in range(0, udp_size, int_size):
                chunk = msg_data[i:i + int_size]
                if len(chunk) == int_size:
                    # Little-endian unsigned long long (Q = 8 bytes)
                    value = struct.unpack('<Q', chunk)[0]
                    f_out.write(f"Offset {i:3d}: {value:20d} (0x{value:016x})\n")
                else:
                    f_out.write(f"Offset {i:3d}: Datos incompletos\n")

if __name__ == "__main__":
    if len(sys.argv) != 3:
        print(f"Uso: {sys.argv[0]} <archivo_entrada.bin> <archivo_salida.txt>")
        sys.exit(1)
    
    parse_fpga_data(sys.argv[1], sys.argv[2])
    print(f"Datos convertidos y guardados en {sys.argv[2]}")
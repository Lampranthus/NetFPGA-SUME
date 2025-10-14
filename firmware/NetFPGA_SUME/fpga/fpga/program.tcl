# ==========================================
# Script TCL para programar la FPGA Virtex-7
# ==========================================

# Datos del proyecto
set_param general.maxThreads 16
set_param synth.maxThreads 8
set_param place.maxThreads 16
set_param route.maxThreads 16
set FPGA_PART "xc7vx690tffg1761-3"
set FPGA_TOP  "fpga"
set FPGA_ARCH "virtex7"

# Archivo bitstream (cambia el nombre si es necesario)
set bitfile "${FPGA_TOP}.bit"

# Mostrar configuración
puts "=========================================="
puts " Programando FPGA:"
puts "  - Arquitectura: $FPGA_ARCH"
puts "  - Parte:        $FPGA_PART"
puts "  - Top module:   $FPGA_TOP"
puts "  - Bitstream:    $bitfile"
puts "=========================================="

# Abrir el servidor de hardware
open_hw
connect_hw_server

# Abrir el target de hardware (detecta el cable y el dispositivo conectado)
open_hw_target

# Seleccionar el primer dispositivo disponible
set device [lindex [get_hw_devices] 0]
current_hw_device $device

# Refrescar información del dispositivo
refresh_hw_device -update_hw_probes false $device

# Asignar el archivo .bit al dispositivo
set_property PROGRAM.FILE $bitfile $device

# Programar la FPGA
program_hw_devices $device

# Verificar programación (opcional)
refresh_hw_device $device
puts "✅ FPGA ($FPGA_PART) programada correctamente con $bitfile"

# Cerrar sesión del servidor de hardware
close_hw_target
disconnect_hw_server
close_hw_manager

exit


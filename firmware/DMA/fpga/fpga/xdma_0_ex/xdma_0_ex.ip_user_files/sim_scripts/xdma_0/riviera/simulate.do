transcript off
onbreak {quit -force}
onerror {quit -force}
transcript on

asim +access +r +m+xdma_0  -L xil_defaultlib -L xilinx_vip -L xpm -L blk_mem_gen_v8_4_9 -L xdma_v4_1_31 -L xilinx_vip -L unisims_ver -L unimacro_ver -L secureip -O5 xil_defaultlib.xdma_0 xil_defaultlib.glbl

do {xdma_0.udo}

run 1000ns

endsim

quit -force

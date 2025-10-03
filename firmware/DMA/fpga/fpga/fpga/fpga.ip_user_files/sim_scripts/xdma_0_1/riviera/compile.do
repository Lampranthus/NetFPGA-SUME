transcript off
onbreak {quit -force}
onerror {quit -force}
transcript on

vlib work
vlib riviera/xilinx_vip
vlib riviera/xpm
vlib riviera/xil_defaultlib
vlib riviera/blk_mem_gen_v8_4_9
vlib riviera/xdma_v4_1_31

vmap xilinx_vip riviera/xilinx_vip
vmap xpm riviera/xpm
vmap xil_defaultlib riviera/xil_defaultlib
vmap blk_mem_gen_v8_4_9 riviera/blk_mem_gen_v8_4_9
vmap xdma_v4_1_31 riviera/xdma_v4_1_31

vlog -work xilinx_vip  -incr "+incdir+/tools/Xilinx/Vivado/2024.2/data/xilinx_vip/include" -l xilinx_vip -l xpm -l xil_defaultlib -l blk_mem_gen_v8_4_9 -l xdma_v4_1_31 \
"/tools/Xilinx/Vivado/2024.2/data/xilinx_vip/hdl/axi4stream_vip_axi4streampc.sv" \
"/tools/Xilinx/Vivado/2024.2/data/xilinx_vip/hdl/axi_vip_axi4pc.sv" \
"/tools/Xilinx/Vivado/2024.2/data/xilinx_vip/hdl/xil_common_vip_pkg.sv" \
"/tools/Xilinx/Vivado/2024.2/data/xilinx_vip/hdl/axi4stream_vip_pkg.sv" \
"/tools/Xilinx/Vivado/2024.2/data/xilinx_vip/hdl/axi_vip_pkg.sv" \
"/tools/Xilinx/Vivado/2024.2/data/xilinx_vip/hdl/axi4stream_vip_if.sv" \
"/tools/Xilinx/Vivado/2024.2/data/xilinx_vip/hdl/axi_vip_if.sv" \
"/tools/Xilinx/Vivado/2024.2/data/xilinx_vip/hdl/clk_vip_if.sv" \
"/tools/Xilinx/Vivado/2024.2/data/xilinx_vip/hdl/rst_vip_if.sv" \

vlog -work xpm  -incr "+incdir+../../../ipstatic/hdl/verilog" "+incdir+/tools/Xilinx/Vivado/2024.2/data/xilinx_vip/include" -l xilinx_vip -l xpm -l xil_defaultlib -l blk_mem_gen_v8_4_9 -l xdma_v4_1_31 \
"/tools/Xilinx/Vivado/2024.2/data/ip/xpm/xpm_cdc/hdl/xpm_cdc.sv" \
"/tools/Xilinx/Vivado/2024.2/data/ip/xpm/xpm_fifo/hdl/xpm_fifo.sv" \
"/tools/Xilinx/Vivado/2024.2/data/ip/xpm/xpm_memory/hdl/xpm_memory.sv" \

vcom -work xpm -93  -incr \
"/tools/Xilinx/Vivado/2024.2/data/ip/xpm/xpm_VCOMP.vhd" \

vlog -work xil_defaultlib  -incr -v2k5 "+incdir+../../../ipstatic/hdl/verilog" "+incdir+/tools/Xilinx/Vivado/2024.2/data/xilinx_vip/include" -l xilinx_vip -l xpm -l xil_defaultlib -l blk_mem_gen_v8_4_9 -l xdma_v4_1_31 \
"../../../../fpga.gen/sources_1/ip/xdma_0_1/ip_0/source/xdma_0_pcie3_ip_pcie_7vx.v" \
"../../../../fpga.gen/sources_1/ip/xdma_0_1/ip_0/source/xdma_0_pcie3_ip_pcie_bram_7vx.v" \
"../../../../fpga.gen/sources_1/ip/xdma_0_1/ip_0/source/xdma_0_pcie3_ip_pcie_bram_7vx_8k.v" \
"../../../../fpga.gen/sources_1/ip/xdma_0_1/ip_0/source/xdma_0_pcie3_ip_pcie_bram_7vx_16k.v" \
"../../../../fpga.gen/sources_1/ip/xdma_0_1/ip_0/source/xdma_0_pcie3_ip_pcie_bram_7vx_cpl.v" \
"../../../../fpga.gen/sources_1/ip/xdma_0_1/ip_0/source/xdma_0_pcie3_ip_pcie_bram_7vx_rep.v" \
"../../../../fpga.gen/sources_1/ip/xdma_0_1/ip_0/source/xdma_0_pcie3_ip_pcie_bram_7vx_rep_8k.v" \
"../../../../fpga.gen/sources_1/ip/xdma_0_1/ip_0/source/xdma_0_pcie3_ip_pcie_bram_7vx_req.v" \
"../../../../fpga.gen/sources_1/ip/xdma_0_1/ip_0/source/xdma_0_pcie3_ip_pcie_init_ctrl_7vx.v" \
"../../../../fpga.gen/sources_1/ip/xdma_0_1/ip_0/source/xdma_0_pcie3_ip_pcie_pipe_lane.v" \
"../../../../fpga.gen/sources_1/ip/xdma_0_1/ip_0/source/xdma_0_pcie3_ip_pcie_pipe_misc.v" \
"../../../../fpga.gen/sources_1/ip/xdma_0_1/ip_0/source/xdma_0_pcie3_ip_pcie_pipe_pipeline.v" \
"../../../../fpga.gen/sources_1/ip/xdma_0_1/ip_0/source/xdma_0_pcie3_ip_pcie_top.v" \
"../../../../fpga.gen/sources_1/ip/xdma_0_1/ip_0/source/xdma_0_pcie3_ip_pcie_force_adapt.v" \
"../../../../fpga.gen/sources_1/ip/xdma_0_1/ip_0/source/xdma_0_pcie3_ip_pipe_clock.v" \
"../../../../fpga.gen/sources_1/ip/xdma_0_1/ip_0/source/xdma_0_pcie3_ip_pipe_drp.v" \
"../../../../fpga.gen/sources_1/ip/xdma_0_1/ip_0/source/xdma_0_pcie3_ip_pipe_eq.v" \
"../../../../fpga.gen/sources_1/ip/xdma_0_1/ip_0/source/xdma_0_pcie3_ip_pipe_rate.v" \
"../../../../fpga.gen/sources_1/ip/xdma_0_1/ip_0/source/xdma_0_pcie3_ip_pipe_reset.v" \
"../../../../fpga.gen/sources_1/ip/xdma_0_1/ip_0/source/xdma_0_pcie3_ip_pipe_sync.v" \
"../../../../fpga.gen/sources_1/ip/xdma_0_1/ip_0/source/xdma_0_pcie3_ip_pipe_user.v" \
"../../../../fpga.gen/sources_1/ip/xdma_0_1/ip_0/source/xdma_0_pcie3_ip_pipe_wrapper.v" \
"../../../../fpga.gen/sources_1/ip/xdma_0_1/ip_0/source/xdma_0_pcie3_ip_qpll_drp.v" \
"../../../../fpga.gen/sources_1/ip/xdma_0_1/ip_0/source/xdma_0_pcie3_ip_qpll_reset.v" \
"../../../../fpga.gen/sources_1/ip/xdma_0_1/ip_0/source/xdma_0_pcie3_ip_qpll_wrapper.v" \
"../../../../fpga.gen/sources_1/ip/xdma_0_1/ip_0/source/xdma_0_pcie3_ip_rxeq_scan.v" \
"../../../../fpga.gen/sources_1/ip/xdma_0_1/ip_0/source/xdma_0_pcie3_ip_gt_wrapper.v" \
"../../../../fpga.gen/sources_1/ip/xdma_0_1/ip_0/source/xdma_0_pcie3_ip_gt_top.v" \
"../../../../fpga.gen/sources_1/ip/xdma_0_1/ip_0/source/xdma_0_pcie3_ip_gt_common.v" \
"../../../../fpga.gen/sources_1/ip/xdma_0_1/ip_0/source/xdma_0_pcie3_ip_gtx_cpllpd_ovrd.v" \
"../../../../fpga.gen/sources_1/ip/xdma_0_1/ip_0/source/xdma_0_pcie3_ip_pcie_tlp_tph_tbl_7vx.v" \
"../../../../fpga.gen/sources_1/ip/xdma_0_1/ip_0/source/xdma_0_pcie3_ip_pcie_3_0_7vx.v" \
"../../../../fpga.gen/sources_1/ip/xdma_0_1/ip_0/sim/xdma_0_pcie3_ip.v" \

vlog -work blk_mem_gen_v8_4_9  -incr -v2k5 "+incdir+../../../ipstatic/hdl/verilog" "+incdir+/tools/Xilinx/Vivado/2024.2/data/xilinx_vip/include" -l xilinx_vip -l xpm -l xil_defaultlib -l blk_mem_gen_v8_4_9 -l xdma_v4_1_31 \
"../../../ipstatic/simulation/blk_mem_gen_v8_4.v" \

vlog -work xil_defaultlib  -incr -v2k5 "+incdir+../../../ipstatic/hdl/verilog" "+incdir+/tools/Xilinx/Vivado/2024.2/data/xilinx_vip/include" -l xilinx_vip -l xpm -l xil_defaultlib -l blk_mem_gen_v8_4_9 -l xdma_v4_1_31 \
"../../../../fpga.gen/sources_1/ip/xdma_0_1/ip_1/sim/xdma_v4_1_31_blk_mem_64_reg_be.v" \
"../../../../fpga.gen/sources_1/ip/xdma_0_1/ip_2/sim/xdma_v4_1_31_blk_mem_64_noreg_be.v" \

vlog -work xdma_v4_1_31  -incr "+incdir+../../../ipstatic/hdl/verilog" "+incdir+/tools/Xilinx/Vivado/2024.2/data/xilinx_vip/include" -l xilinx_vip -l xpm -l xil_defaultlib -l blk_mem_gen_v8_4_9 -l xdma_v4_1_31 \
"../../../ipstatic/hdl/xdma_v4_1_vl_rfs.sv" \

vlog -work xil_defaultlib  -incr "+incdir+../../../ipstatic/hdl/verilog" "+incdir+/tools/Xilinx/Vivado/2024.2/data/xilinx_vip/include" -l xilinx_vip -l xpm -l xil_defaultlib -l blk_mem_gen_v8_4_9 -l xdma_v4_1_31 \
"../../../../fpga.gen/sources_1/ip/xdma_0_1/xdma_v4_1/hdl/verilog/xdma_0_dma_bram_wrap.sv" \
"../../../../fpga.gen/sources_1/ip/xdma_0_1/xdma_v4_1/hdl/verilog/xdma_0_dma_bram_wrap_1024.sv" \
"../../../../fpga.gen/sources_1/ip/xdma_0_1/xdma_v4_1/hdl/verilog/xdma_0_dma_bram_wrap_2048.sv" \
"../../../../fpga.gen/sources_1/ip/xdma_0_1/xdma_v4_1/hdl/verilog/xdma_0_core_top.sv" \
"../../../../fpga.gen/sources_1/ip/xdma_0_1/sim/xdma_0.sv" \

vlog -work xil_defaultlib \
"glbl.v"


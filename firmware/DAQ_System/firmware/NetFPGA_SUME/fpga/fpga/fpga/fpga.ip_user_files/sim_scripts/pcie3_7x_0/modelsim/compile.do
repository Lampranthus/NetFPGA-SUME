vlib modelsim_lib/work
vlib modelsim_lib/msim

vlib modelsim_lib/msim/xpm
vlib modelsim_lib/msim/xil_defaultlib

vmap xpm modelsim_lib/msim/xpm
vmap xil_defaultlib modelsim_lib/msim/xil_defaultlib

vlog -work xpm -64 -incr -mfcu  -sv \
"/tools/Xilinx/Vivado/2024.2/data/ip/xpm/xpm_cdc/hdl/xpm_cdc.sv" \
"/tools/Xilinx/Vivado/2024.2/data/ip/xpm/xpm_memory/hdl/xpm_memory.sv" \

vcom -work xpm -64 -93  \
"/tools/Xilinx/Vivado/2024.2/data/ip/xpm/xpm_VCOMP.vhd" \

vlog -work xil_defaultlib -64 -incr -mfcu  \
"../../../../fpga.gen/sources_1/ip/pcie3_7x_0/source/pcie3_7x_0_pcie_7vx.v" \
"../../../../fpga.gen/sources_1/ip/pcie3_7x_0/source/pcie3_7x_0_pcie_bram_7vx.v" \
"../../../../fpga.gen/sources_1/ip/pcie3_7x_0/source/pcie3_7x_0_pcie_bram_7vx_8k.v" \
"../../../../fpga.gen/sources_1/ip/pcie3_7x_0/source/pcie3_7x_0_pcie_bram_7vx_16k.v" \
"../../../../fpga.gen/sources_1/ip/pcie3_7x_0/source/pcie3_7x_0_pcie_bram_7vx_cpl.v" \
"../../../../fpga.gen/sources_1/ip/pcie3_7x_0/source/pcie3_7x_0_pcie_bram_7vx_rep.v" \
"../../../../fpga.gen/sources_1/ip/pcie3_7x_0/source/pcie3_7x_0_pcie_bram_7vx_rep_8k.v" \
"../../../../fpga.gen/sources_1/ip/pcie3_7x_0/source/pcie3_7x_0_pcie_bram_7vx_req.v" \
"../../../../fpga.gen/sources_1/ip/pcie3_7x_0/source/pcie3_7x_0_pcie_init_ctrl_7vx.v" \
"../../../../fpga.gen/sources_1/ip/pcie3_7x_0/source/pcie3_7x_0_pcie_pipe_lane.v" \
"../../../../fpga.gen/sources_1/ip/pcie3_7x_0/source/pcie3_7x_0_pcie_pipe_misc.v" \
"../../../../fpga.gen/sources_1/ip/pcie3_7x_0/source/pcie3_7x_0_pcie_pipe_pipeline.v" \
"../../../../fpga.gen/sources_1/ip/pcie3_7x_0/source/pcie3_7x_0_pcie_top.v" \
"../../../../fpga.gen/sources_1/ip/pcie3_7x_0/source/pcie3_7x_0_pcie_force_adapt.v" \
"../../../../fpga.gen/sources_1/ip/pcie3_7x_0/source/pcie3_7x_0_pipe_clock.v" \
"../../../../fpga.gen/sources_1/ip/pcie3_7x_0/source/pcie3_7x_0_pipe_drp.v" \
"../../../../fpga.gen/sources_1/ip/pcie3_7x_0/source/pcie3_7x_0_pipe_eq.v" \
"../../../../fpga.gen/sources_1/ip/pcie3_7x_0/source/pcie3_7x_0_pipe_rate.v" \
"../../../../fpga.gen/sources_1/ip/pcie3_7x_0/source/pcie3_7x_0_pipe_reset.v" \
"../../../../fpga.gen/sources_1/ip/pcie3_7x_0/source/pcie3_7x_0_pipe_sync.v" \
"../../../../fpga.gen/sources_1/ip/pcie3_7x_0/source/pcie3_7x_0_pipe_user.v" \
"../../../../fpga.gen/sources_1/ip/pcie3_7x_0/source/pcie3_7x_0_pipe_wrapper.v" \
"../../../../fpga.gen/sources_1/ip/pcie3_7x_0/source/pcie3_7x_0_qpll_drp.v" \
"../../../../fpga.gen/sources_1/ip/pcie3_7x_0/source/pcie3_7x_0_qpll_reset.v" \
"../../../../fpga.gen/sources_1/ip/pcie3_7x_0/source/pcie3_7x_0_qpll_wrapper.v" \
"../../../../fpga.gen/sources_1/ip/pcie3_7x_0/source/pcie3_7x_0_rxeq_scan.v" \
"../../../../fpga.gen/sources_1/ip/pcie3_7x_0/source/pcie3_7x_0_gt_wrapper.v" \
"../../../../fpga.gen/sources_1/ip/pcie3_7x_0/source/pcie3_7x_0_gt_top.v" \
"../../../../fpga.gen/sources_1/ip/pcie3_7x_0/source/pcie3_7x_0_gt_common.v" \
"../../../../fpga.gen/sources_1/ip/pcie3_7x_0/source/pcie3_7x_0_gtx_cpllpd_ovrd.v" \
"../../../../fpga.gen/sources_1/ip/pcie3_7x_0/source/pcie3_7x_0_pcie_tlp_tph_tbl_7vx.v" \
"../../../../fpga.gen/sources_1/ip/pcie3_7x_0/source/pcie3_7x_0_pcie_3_0_7vx.v" \
"../../../../fpga.gen/sources_1/ip/pcie3_7x_0/sim/pcie3_7x_0.v" \

vlog -work xil_defaultlib \
"glbl.v"


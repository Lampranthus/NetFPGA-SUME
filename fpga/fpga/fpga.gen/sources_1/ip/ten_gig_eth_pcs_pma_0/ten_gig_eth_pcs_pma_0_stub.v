// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// Copyright 2022-2024 Advanced Micro Devices, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2024.2 (lin64) Build 5239630 Fri Nov 08 22:34:34 MST 2024
// Date        : Tue Sep  2 18:34:36 2025
// Host        : lampranthus running 64-bit Ubuntu 24.04.2 LTS
// Command     : write_verilog -force -mode synth_stub
//               /home/luisfercrtez/Documents/Master/Tesis/NetFPGA-SUME/fpga/fpga/fpga.gen/sources_1/ip/ten_gig_eth_pcs_pma_0/ten_gig_eth_pcs_pma_0_stub.v
// Design      : ten_gig_eth_pcs_pma_0
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7vx690tffg1761-3
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* CORE_GENERATION_INFO = "ten_gig_eth_pcs_pma_0,ten_gig_eth_pcs_pma_v6_0_28,{x_ipProduct=Vivado 2024.2,x_ipVendor=xilinx.com,x_ipLibrary=ip,x_ipName=ten_gig_eth_pcs_pma,x_ipVersion=6.0,x_ipCoreRevision=28,x_ipLanguage=VERILOG,x_ipSimLanguage=MIXED,c_family=virtex7,c_component_name=ten_gig_eth_pcs_pma_0,c_has_mdio=false,c_has_fec=false,c_has_an=false,c_is_kr=false,c_is_32bit=false,c_no_ebuff=false,c_gttype=1,c_1588=0,c_gtif_width=32,c_speed10_25=10,c_sub_core_name=ten_gig_eth_pcs_pma_0_gt,c_gt_loc=X0Y0,c_refclk=clk0,c_refclkrate=156,c_dclkrate=125,x_ipLicense=ten_gig_eth_pcs_pma_basekr@2015.04(design_linking)}" *) (* DowngradeIPIdentifiedWarnings = "yes" *) (* X_CORE_INFO = "ten_gig_eth_pcs_pma_v6_0_28,Vivado 2024.2" *) 
module ten_gig_eth_pcs_pma_0(dclk, rxrecclk_out, refclk_p, refclk_n, 
  sim_speedup_control, coreclk_out, qplloutclk_out, qplloutrefclk_out, qplllock_out, 
  txusrclk_out, txusrclk2_out, areset_datapathclk_out, gttxreset_out, gtrxreset_out, 
  txuserrdy_out, reset_counter_done_out, reset, xgmii_txd, xgmii_txc, xgmii_rxd, xgmii_rxc, txp, 
  txn, rxp, rxn, configuration_vector, status_vector, core_status, resetdone_out, signal_detect, 
  tx_fault, drp_req, drp_gnt, drp_den_o, drp_dwe_o, drp_daddr_o, drp_di_o, drp_drdy_o, drp_drpdo_o, 
  drp_den_i, drp_dwe_i, drp_daddr_i, drp_di_i, drp_drdy_i, drp_drpdo_i, pma_pmd_type, tx_disable)
/* synthesis syn_black_box black_box_pad_pin="refclk_p,refclk_n,sim_speedup_control,qplloutrefclk_out,qplllock_out,areset_datapathclk_out,gttxreset_out,gtrxreset_out,txuserrdy_out,reset_counter_done_out,reset,xgmii_txd[63:0],xgmii_txc[7:0],xgmii_rxd[63:0],xgmii_rxc[7:0],txp,txn,rxp,rxn,configuration_vector[535:0],status_vector[447:0],core_status[7:0],resetdone_out,signal_detect,tx_fault,drp_req,drp_gnt,drp_den_o,drp_dwe_o,drp_daddr_o[15:0],drp_di_o[15:0],drp_drdy_o,drp_drpdo_o[15:0],drp_den_i,drp_dwe_i,drp_daddr_i[15:0],drp_di_i[15:0],drp_drdy_i,drp_drpdo_i[15:0],pma_pmd_type[2:0],tx_disable" */
/* synthesis syn_force_seq_prim="dclk" */
/* synthesis syn_force_seq_prim="rxrecclk_out" */
/* synthesis syn_force_seq_prim="coreclk_out" */
/* synthesis syn_force_seq_prim="qplloutclk_out" */
/* synthesis syn_force_seq_prim="txusrclk_out" */
/* synthesis syn_force_seq_prim="txusrclk2_out" */;
  input dclk /* synthesis syn_isclock = 1 */;
  output rxrecclk_out /* synthesis syn_isclock = 1 */;
  input refclk_p;
  input refclk_n;
  input sim_speedup_control;
  output coreclk_out /* synthesis syn_isclock = 1 */;
  output qplloutclk_out /* synthesis syn_isclock = 1 */;
  output qplloutrefclk_out;
  output qplllock_out;
  output txusrclk_out /* synthesis syn_isclock = 1 */;
  output txusrclk2_out /* synthesis syn_isclock = 1 */;
  output areset_datapathclk_out;
  output gttxreset_out;
  output gtrxreset_out;
  output txuserrdy_out;
  output reset_counter_done_out;
  input reset;
  input [63:0]xgmii_txd;
  input [7:0]xgmii_txc;
  output [63:0]xgmii_rxd;
  output [7:0]xgmii_rxc;
  output txp;
  output txn;
  input rxp;
  input rxn;
  input [535:0]configuration_vector;
  output [447:0]status_vector;
  output [7:0]core_status;
  output resetdone_out;
  input signal_detect;
  input tx_fault;
  output drp_req;
  input drp_gnt;
  output drp_den_o;
  output drp_dwe_o;
  output [15:0]drp_daddr_o;
  output [15:0]drp_di_o;
  output drp_drdy_o;
  output [15:0]drp_drpdo_o;
  input drp_den_i;
  input drp_dwe_i;
  input [15:0]drp_daddr_i;
  input [15:0]drp_di_i;
  input drp_drdy_i;
  input [15:0]drp_drpdo_i;
  input [2:0]pma_pmd_type;
  output tx_disable;
endmodule

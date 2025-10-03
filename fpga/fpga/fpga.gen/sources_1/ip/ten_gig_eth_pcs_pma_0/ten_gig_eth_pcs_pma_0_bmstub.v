// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// Copyright 2022-2025 Advanced Micro Devices, Inc. All Rights Reserved.
// -------------------------------------------------------------------------------

`timescale 1 ps / 1 ps

(* BLOCK_STUB = "true" *)
module ten_gig_eth_pcs_pma_0 (
  refclk_p,
  refclk_n,
  reset,
  resetdone_out,
  coreclk_out,
  rxrecclk_out,
  dclk,
  txp,
  txn,
  rxp,
  rxn,
  sim_speedup_control,
  txusrclk_out,
  txusrclk2_out,
  areset_datapathclk_out,
  gttxreset_out,
  gtrxreset_out,
  txuserrdy_out,
  reset_counter_done_out,
  qplllock_out,
  qplloutclk_out,
  qplloutrefclk_out,
  xgmii_txd,
  xgmii_txc,
  xgmii_rxd,
  xgmii_rxc,
  configuration_vector,
  status_vector,
  core_status,
  signal_detect,
  tx_fault,
  drp_req,
  drp_gnt,
  drp_den_o,
  drp_dwe_o,
  drp_daddr_o,
  drp_di_o,
  drp_drdy_o,
  drp_drpdo_o,
  drp_den_i,
  drp_dwe_i,
  drp_daddr_i,
  drp_di_i,
  drp_drdy_i,
  drp_drpdo_i,
  tx_disable,
  pma_pmd_type
);

  (* X_INTERFACE_INFO = "xilinx.com:interface:diff_clock:1.0 refclk_diff_port CLK_P" *)
  (* X_INTERFACE_MODE = "slave refclk_diff_port" *)
  (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME refclk_diff_port, FREQ_HZ 156250000, CAN_DEBUG false" *)
  input refclk_p;
  (* X_INTERFACE_INFO = "xilinx.com:interface:diff_clock:1.0 refclk_diff_port CLK_N" *)
  input refclk_n;
  (* X_INTERFACE_INFO = "xilinx.com:signal:reset:1.0 reset RST" *)
  (* X_INTERFACE_MODE = "slave reset" *)
  (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME reset, POLARITY ACTIVE_HIGH, INSERT_VIP 0" *)
  input reset;
  (* X_INTERFACE_IGNORE = "true" *)
  output resetdone_out;
  (* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 coreclk_out CLK" *)
  (* X_INTERFACE_MODE = "master coreclk_out" *)
  (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME coreclk_out, FREQ_HZ 156250000, FREQ_TOLERANCE_HZ 0, PHASE 0.0, CLK_DOMAIN , ASSOCIATED_BUSIF , ASSOCIATED_PORT , ASSOCIATED_RESET , INSERT_VIP 0" *)
  output coreclk_out;
  (* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 rxrecclk_out CLK" *)
  (* X_INTERFACE_MODE = "master rxrecclk_out" *)
  (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME rxrecclk_out, FREQ_HZ 312500000, ASSOCIATED_RESET gtrxreset_out, FREQ_TOLERANCE_HZ 0, PHASE 0.0, CLK_DOMAIN , ASSOCIATED_BUSIF , ASSOCIATED_PORT , INSERT_VIP 0" *)
  output rxrecclk_out;
  (* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 dclk CLK" *)
  (* X_INTERFACE_MODE = "slave dclk" *)
  (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME dclk, ASSOCIATED_BUSIF core_gt_drp_interface:user_gt_drp_interface:core_to_gt_drp:gt_drp, FREQ_HZ 100000000, FREQ_TOLERANCE_HZ 0, PHASE 0.0, CLK_DOMAIN , ASSOCIATED_PORT , ASSOCIATED_RESET , INSERT_VIP 0" *)
  input dclk;
  (* X_INTERFACE_IGNORE = "true" *)
  output txp;
  (* X_INTERFACE_IGNORE = "true" *)
  output txn;
  (* X_INTERFACE_IGNORE = "true" *)
  input rxp;
  (* X_INTERFACE_IGNORE = "true" *)
  input rxn;
  (* X_INTERFACE_IGNORE = "true" *)
  input sim_speedup_control;
  (* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 txusrclk_out CLK" *)
  (* X_INTERFACE_MODE = "master txusrclk_out" *)
  (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME txusrclk_out, FREQ_HZ 312500000, FREQ_TOLERANCE_HZ 0, PHASE 0.0, CLK_DOMAIN , ASSOCIATED_BUSIF , ASSOCIATED_PORT , ASSOCIATED_RESET , INSERT_VIP 0" *)
  output txusrclk_out;
  (* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 txusrclk2_out CLK" *)
  (* X_INTERFACE_MODE = "master txusrclk2_out" *)
  (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME txusrclk2_out, FREQ_HZ 312500000, ASSOCIATED_BUSIF xgmii_interface, ASSOCIATED_RESET areset_datapathclk_out, FREQ_TOLERANCE_HZ 0, PHASE 0.0, CLK_DOMAIN , ASSOCIATED_PORT , INSERT_VIP 0" *)
  output txusrclk2_out;
  (* X_INTERFACE_INFO = "xilinx.com:signal:reset:1.0 areset_datapathclk_out RST" *)
  (* X_INTERFACE_MODE = "master areset_datapathclk_out" *)
  (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME areset_datapathclk_out, POLARITY ACTIVE_HIGH, INSERT_VIP 0" *)
  output areset_datapathclk_out;
  (* X_INTERFACE_INFO = "xilinx.com:signal:reset:1.0 gttxreset_out RST" *)
  (* X_INTERFACE_MODE = "master gttxreset_out" *)
  (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME gttxreset_out, POLARITY ACTIVE_HIGH, INSERT_VIP 0" *)
  output gttxreset_out;
  (* X_INTERFACE_INFO = "xilinx.com:signal:reset:1.0 gtrxreset_out RST" *)
  (* X_INTERFACE_MODE = "master gtrxreset_out" *)
  (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME gtrxreset_out, POLARITY ACTIVE_HIGH, INSERT_VIP 0" *)
  output gtrxreset_out;
  (* X_INTERFACE_IGNORE = "true" *)
  output txuserrdy_out;
  (* X_INTERFACE_IGNORE = "true" *)
  output reset_counter_done_out;
  (* X_INTERFACE_IGNORE = "true" *)
  output qplllock_out;
  (* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 qplloutclk_out CLK" *)
  (* X_INTERFACE_MODE = "master qplloutclk_out" *)
  (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME qplloutclk_out, FREQ_HZ 156250000, FREQ_TOLERANCE_HZ 0, PHASE 0.0, CLK_DOMAIN , ASSOCIATED_BUSIF , ASSOCIATED_PORT , ASSOCIATED_RESET , INSERT_VIP 0" *)
  output qplloutclk_out;
  (* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 qplloutrefclk_out CLK" *)
  (* X_INTERFACE_MODE = "master qplloutrefclk_out" *)
  (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME qplloutrefclk_out, FREQ_HZ 156250000, FREQ_TOLERANCE_HZ 0, PHASE 0.0, CLK_DOMAIN , ASSOCIATED_BUSIF , ASSOCIATED_PORT , ASSOCIATED_RESET , INSERT_VIP 0" *)
  output qplloutrefclk_out;
  (* X_INTERFACE_INFO = "xilinx.com:interface:xgmii:1.0 xgmii_interface TXD" *)
  (* X_INTERFACE_MODE = "slave xgmii_interface" *)
  input [63:0]xgmii_txd;
  (* X_INTERFACE_INFO = "xilinx.com:interface:xgmii:1.0 xgmii_interface TXC" *)
  input [7:0]xgmii_txc;
  (* X_INTERFACE_INFO = "xilinx.com:interface:xgmii:1.0 xgmii_interface RXD" *)
  output [63:0]xgmii_rxd;
  (* X_INTERFACE_INFO = "xilinx.com:interface:xgmii:1.0 xgmii_interface RXC" *)
  output [7:0]xgmii_rxc;
  (* X_INTERFACE_IGNORE = "true" *)
  input [535:0]configuration_vector;
  (* X_INTERFACE_IGNORE = "true" *)
  output [447:0]status_vector;
  (* X_INTERFACE_IGNORE = "true" *)
  output [7:0]core_status;
  (* X_INTERFACE_IGNORE = "true" *)
  input signal_detect;
  (* X_INTERFACE_IGNORE = "true" *)
  input tx_fault;
  (* X_INTERFACE_IGNORE = "true" *)
  output drp_req;
  (* X_INTERFACE_IGNORE = "true" *)
  input drp_gnt;
  (* X_INTERFACE_INFO = "xilinx.com:interface:drp:1.0 core_gt_drp_interface DEN" *)
  (* X_INTERFACE_MODE = "master core_gt_drp_interface" *)
  output drp_den_o;
  (* X_INTERFACE_INFO = "xilinx.com:interface:drp:1.0 core_gt_drp_interface DWE" *)
  output drp_dwe_o;
  (* X_INTERFACE_INFO = "xilinx.com:interface:drp:1.0 core_gt_drp_interface DADDR" *)
  output [15:0]drp_daddr_o;
  (* X_INTERFACE_INFO = "xilinx.com:interface:drp:1.0 core_gt_drp_interface DI" *)
  output [15:0]drp_di_o;
  (* X_INTERFACE_INFO = "xilinx.com:interface:drp:1.0 user_gt_drp_interface DRDY" *)
  (* X_INTERFACE_MODE = "slave user_gt_drp_interface" *)
  output drp_drdy_o;
  (* X_INTERFACE_INFO = "xilinx.com:interface:drp:1.0 user_gt_drp_interface DO" *)
  output [15:0]drp_drpdo_o;
  (* X_INTERFACE_INFO = "xilinx.com:interface:drp:1.0 user_gt_drp_interface DEN" *)
  input drp_den_i;
  (* X_INTERFACE_INFO = "xilinx.com:interface:drp:1.0 user_gt_drp_interface DWE" *)
  input drp_dwe_i;
  (* X_INTERFACE_INFO = "xilinx.com:interface:drp:1.0 user_gt_drp_interface DADDR" *)
  input [15:0]drp_daddr_i;
  (* X_INTERFACE_INFO = "xilinx.com:interface:drp:1.0 user_gt_drp_interface DI" *)
  input [15:0]drp_di_i;
  (* X_INTERFACE_INFO = "xilinx.com:interface:drp:1.0 core_gt_drp_interface DRDY" *)
  input drp_drdy_i;
  (* X_INTERFACE_INFO = "xilinx.com:interface:drp:1.0 core_gt_drp_interface DO" *)
  input [15:0]drp_drpdo_i;
  (* X_INTERFACE_IGNORE = "true" *)
  output tx_disable;
  (* X_INTERFACE_IGNORE = "true" *)
  input [2:0]pma_pmd_type;

  // stub module has no contents

endmodule

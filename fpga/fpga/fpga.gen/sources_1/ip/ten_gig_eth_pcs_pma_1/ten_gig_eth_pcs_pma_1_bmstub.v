// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// Copyright 2022-2025 Advanced Micro Devices, Inc. All Rights Reserved.
// -------------------------------------------------------------------------------

`timescale 1 ps / 1 ps

(* BLOCK_STUB = "true" *)
module ten_gig_eth_pcs_pma_1 (
  rxrecclk_out,
  coreclk,
  dclk,
  txusrclk,
  txusrclk2,
  areset,
  txoutclk,
  areset_coreclk,
  gttxreset,
  gtrxreset,
  txuserrdy,
  qplllock,
  qplloutclk,
  qplloutrefclk,
  reset_counter_done,
  txp,
  txn,
  rxp,
  rxn,
  sim_speedup_control,
  xgmii_txd,
  xgmii_txc,
  xgmii_rxd,
  xgmii_rxc,
  configuration_vector,
  status_vector,
  core_status,
  tx_resetdone,
  rx_resetdone,
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

  (* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 rxrecclk_out CLK" *)
  (* X_INTERFACE_MODE = "master rxrecclk_out" *)
  (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME rxrecclk_out, FREQ_HZ 312500000, ASSOCIATED_RESET gtrxreset_out, FREQ_TOLERANCE_HZ 0, PHASE 0.0, CLK_DOMAIN , ASSOCIATED_BUSIF , ASSOCIATED_PORT , INSERT_VIP 0" *)
  output rxrecclk_out;
  (* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 coreclk CLK" *)
  (* X_INTERFACE_MODE = "slave coreclk" *)
  (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME coreclk, FREQ_HZ 156250000, ASSOCIATED_BUSIF xgmii_interface, FREQ_TOLERANCE_HZ 0, PHASE 0.0, CLK_DOMAIN , ASSOCIATED_PORT , ASSOCIATED_RESET , INSERT_VIP 0" *)
  input coreclk;
  (* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 dclk CLK" *)
  (* X_INTERFACE_MODE = "slave dclk" *)
  (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME dclk, ASSOCIATED_BUSIF core_gt_drp_interface:user_gt_drp_interface:core_to_gt_drp:gt_drp, FREQ_HZ 100000000, FREQ_TOLERANCE_HZ 0, PHASE 0.0, CLK_DOMAIN , ASSOCIATED_PORT , ASSOCIATED_RESET , INSERT_VIP 0" *)
  input dclk;
  (* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 txusrclk CLK" *)
  (* X_INTERFACE_MODE = "slave txusrclk" *)
  (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME txusrclk, FREQ_HZ 312500000, FREQ_TOLERANCE_HZ 0, PHASE 0.0, CLK_DOMAIN , ASSOCIATED_BUSIF , ASSOCIATED_PORT , ASSOCIATED_RESET , INSERT_VIP 0" *)
  input txusrclk;
  (* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 txusrclk2 CLK" *)
  (* X_INTERFACE_MODE = "slave txusrclk2" *)
  (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME txusrclk2, FREQ_HZ 312500000, FREQ_TOLERANCE_HZ 0, PHASE 0.0, CLK_DOMAIN , ASSOCIATED_BUSIF , ASSOCIATED_PORT , ASSOCIATED_RESET , INSERT_VIP 0" *)
  input txusrclk2;
  (* X_INTERFACE_INFO = "xilinx.com:signal:reset:1.0 areset RST" *)
  (* X_INTERFACE_MODE = "slave areset" *)
  (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME areset, POLARITY ACTIVE_HIGH, INSERT_VIP 0" *)
  input areset;
  (* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 txoutclk CLK" *)
  (* X_INTERFACE_MODE = "master txoutclk" *)
  (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME txoutclk, FREQ_HZ 312500000, FREQ_TOLERANCE_HZ 0, PHASE 0.0, CLK_DOMAIN , ASSOCIATED_BUSIF , ASSOCIATED_PORT , ASSOCIATED_RESET , INSERT_VIP 0" *)
  output txoutclk;
  (* X_INTERFACE_INFO = "xilinx.com:signal:reset:1.0 areset_coreclk RST" *)
  (* X_INTERFACE_MODE = "slave areset_coreclk" *)
  (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME areset_coreclk, POLARITY ACTIVE_HIGH, INSERT_VIP 0" *)
  input areset_coreclk;
  (* X_INTERFACE_INFO = "xilinx.com:signal:reset:1.0 gttxreset RST" *)
  (* X_INTERFACE_MODE = "slave gttxreset" *)
  (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME gttxreset, POLARITY ACTIVE_HIGH, INSERT_VIP 0" *)
  input gttxreset;
  (* X_INTERFACE_INFO = "xilinx.com:signal:reset:1.0 gtrxreset RST" *)
  (* X_INTERFACE_MODE = "slave gtrxreset" *)
  (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME gtrxreset, POLARITY ACTIVE_HIGH, INSERT_VIP 0" *)
  input gtrxreset;
  (* X_INTERFACE_IGNORE = "true" *)
  input txuserrdy;
  (* X_INTERFACE_IGNORE = "true" *)
  input qplllock;
  (* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 qplloutclk CLK" *)
  (* X_INTERFACE_MODE = "slave qplloutclk" *)
  (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME qplloutclk, FREQ_HZ 100000000, FREQ_TOLERANCE_HZ 0, PHASE 0.0, CLK_DOMAIN , ASSOCIATED_BUSIF , ASSOCIATED_PORT , ASSOCIATED_RESET , INSERT_VIP 0" *)
  input qplloutclk;
  (* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 qplloutrefclk CLK" *)
  (* X_INTERFACE_MODE = "slave qplloutrefclk" *)
  (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME qplloutrefclk, FREQ_HZ 100000000, FREQ_TOLERANCE_HZ 0, PHASE 0.0, CLK_DOMAIN , ASSOCIATED_BUSIF , ASSOCIATED_PORT , ASSOCIATED_RESET , INSERT_VIP 0" *)
  input qplloutrefclk;
  (* X_INTERFACE_IGNORE = "true" *)
  input reset_counter_done;
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
  output tx_resetdone;
  (* X_INTERFACE_IGNORE = "true" *)
  output rx_resetdone;
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

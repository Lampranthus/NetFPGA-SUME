set_property SRC_FILE_INFO {cfile:/home/luisfercrtez/Documents/Master/Tesis/NetFPGA-SUME/firmware/DAQ_System/firmware/NetFPGA_SUME/fpga/fpga.xdc rfile:../../../../../fpga.xdc id:1} [current_design]
set_property src_info {type:XDC file:1 line:9 export:INPUT save:INPUT read:READ} [current_design]
set_property BITSTREAM.CONFIG.OVERTEMPSHUTDOWN Enable  [current_design]
set_property src_info {type:XDC file:1 line:12 export:INPUT save:INPUT read:READ} [current_design]
set_property -dict {LOC H19  IOSTANDARD LVDS} [get_ports clk_200mhz_p]
set_property src_info {type:XDC file:1 line:13 export:INPUT save:INPUT read:READ} [current_design]
set_property -dict {LOC G18  IOSTANDARD LVDS} [get_ports clk_200mhz_n]
set_property src_info {type:XDC file:1 line:14 export:INPUT save:INPUT read:READ} [current_design]
create_clock -period 5 -name clk_200mhz [get_ports clk_200mhz_p]
set_property src_info {type:XDC file:1 line:32 export:INPUT save:INPUT read:READ} [current_design]
set_property -dict {LOC G13  IOSTANDARD LVCMOS15 SLEW SLOW DRIVE 12} [get_ports {sfp_1_led[0]}]
set_property src_info {type:XDC file:1 line:33 export:INPUT save:INPUT read:READ} [current_design]
set_property -dict {LOC L15  IOSTANDARD LVCMOS15 SLEW SLOW DRIVE 12} [get_ports {sfp_1_led[1]}]
set_property src_info {type:XDC file:1 line:34 export:INPUT save:INPUT read:READ} [current_design]
set_property -dict {LOC AL22 IOSTANDARD LVCMOS15 SLEW SLOW DRIVE 12} [get_ports {sfp_2_led[0]}]
set_property src_info {type:XDC file:1 line:35 export:INPUT save:INPUT read:READ} [current_design]
set_property -dict {LOC BA20 IOSTANDARD LVCMOS15 SLEW SLOW DRIVE 12} [get_ports {sfp_2_led[1]}]
set_property src_info {type:XDC file:1 line:36 export:INPUT save:INPUT read:READ} [current_design]
set_property -dict {LOC AY18 IOSTANDARD LVCMOS15 SLEW SLOW DRIVE 12} [get_ports {sfp_3_led[0]}]
set_property src_info {type:XDC file:1 line:37 export:INPUT save:INPUT read:READ} [current_design]
set_property -dict {LOC AY17 IOSTANDARD LVCMOS15 SLEW SLOW DRIVE 12} [get_ports {sfp_3_led[1]}]
set_property src_info {type:XDC file:1 line:38 export:INPUT save:INPUT read:READ} [current_design]
set_property -dict {LOC P31  IOSTANDARD LVCMOS15 SLEW SLOW DRIVE 12} [get_ports {sfp_4_led[0]}]
set_property src_info {type:XDC file:1 line:39 export:INPUT save:INPUT read:READ} [current_design]
set_property -dict {LOC K32  IOSTANDARD LVCMOS15 SLEW SLOW DRIVE 12} [get_ports {sfp_4_led[1]}]
set_property src_info {type:XDC file:1 line:40 export:INPUT save:INPUT read:READ} [current_design]
set_property -dict {LOC AR22 IOSTANDARD LVCMOS15 SLEW SLOW DRIVE 12} [get_ports {led[0]}]
set_property src_info {type:XDC file:1 line:41 export:INPUT save:INPUT read:READ} [current_design]
set_property -dict {LOC AR23 IOSTANDARD LVCMOS15 SLEW SLOW DRIVE 12} [get_ports {led[1]}]
set_property src_info {type:XDC file:1 line:47 export:INPUT save:INPUT read:READ} [current_design]
set_property -dict {LOC AR13 IOSTANDARD LVCMOS15} [get_ports {btn[0]}]
set_property src_info {type:XDC file:1 line:48 export:INPUT save:INPUT read:READ} [current_design]
set_property -dict {LOC BB12 IOSTANDARD LVCMOS15} [get_ports {btn[1]}]
set_property src_info {type:XDC file:1 line:50 export:INPUT save:INPUT read:READ} [current_design]
set_false_path -from [get_ports {btn[*]}]
set_property src_info {type:XDC file:1 line:51 export:INPUT save:INPUT read:READ} [current_design]
set_input_delay 0 [get_ports {btn[*]}]
set_property src_info {type:XDC file:1 line:54 export:INPUT save:INPUT read:READ} [current_design]
set_property -dict {LOC A6   } [get_ports sfp_1_rx_p] ;# MGTHRXP3_119 GTHE2_CHANNEL_X1Y39 / GTHE2_COMMON_X1Y9
set_property src_info {type:XDC file:1 line:55 export:INPUT save:INPUT read:READ} [current_design]
set_property -dict {LOC A5   } [get_ports sfp_1_rx_n] ;# MGTHRXN3_119 GTHE2_CHANNEL_X1Y39 / GTHE2_COMMON_X1Y9
set_property src_info {type:XDC file:1 line:56 export:INPUT save:INPUT read:READ} [current_design]
set_property -dict {LOC B4   } [get_ports sfp_1_tx_p] ;# MGTHTXP3_119 GTHE2_CHANNEL_X1Y39 / GTHE2_COMMON_X1Y9
set_property src_info {type:XDC file:1 line:57 export:INPUT save:INPUT read:READ} [current_design]
set_property -dict {LOC B3   } [get_ports sfp_1_tx_n] ;# MGTHTXN3_119 GTHE2_CHANNEL_X1Y39 / GTHE2_COMMON_X1Y9
set_property src_info {type:XDC file:1 line:58 export:INPUT save:INPUT read:READ} [current_design]
set_property -dict {LOC B8   } [get_ports sfp_2_rx_p] ;# MGTHRXP2_119 GTHE2_CHANNEL_X1Y38 / GTHE2_COMMON_X1Y9
set_property src_info {type:XDC file:1 line:59 export:INPUT save:INPUT read:READ} [current_design]
set_property -dict {LOC B7   } [get_ports sfp_2_rx_n] ;# MGTHRXN2_119 GTHE2_CHANNEL_X1Y38 / GTHE2_COMMON_X1Y9
set_property src_info {type:XDC file:1 line:60 export:INPUT save:INPUT read:READ} [current_design]
set_property -dict {LOC C2   } [get_ports sfp_2_tx_p] ;# MGTHTXP2_119 GTHE2_CHANNEL_X1Y38 / GTHE2_COMMON_X1Y9
set_property src_info {type:XDC file:1 line:61 export:INPUT save:INPUT read:READ} [current_design]
set_property -dict {LOC C1   } [get_ports sfp_2_tx_n] ;# MGTHTXN2_119 GTHE2_CHANNEL_X1Y38 / GTHE2_COMMON_X1Y9
set_property src_info {type:XDC file:1 line:62 export:INPUT save:INPUT read:READ} [current_design]
set_property -dict {LOC C6   } [get_ports sfp_3_rx_p] ;# MGTHRXP1_119 GTHE2_CHANNEL_X1Y37 / GTHE2_COMMON_X1Y9
set_property src_info {type:XDC file:1 line:63 export:INPUT save:INPUT read:READ} [current_design]
set_property -dict {LOC C5   } [get_ports sfp_3_rx_n] ;# MGTHRXN1_119 GTHE2_CHANNEL_X1Y37 / GTHE2_COMMON_X1Y9
set_property src_info {type:XDC file:1 line:64 export:INPUT save:INPUT read:READ} [current_design]
set_property -dict {LOC D4   } [get_ports sfp_3_tx_p] ;# MGTHTXP1_119 GTHE2_CHANNEL_X1Y37 / GTHE2_COMMON_X1Y9
set_property src_info {type:XDC file:1 line:65 export:INPUT save:INPUT read:READ} [current_design]
set_property -dict {LOC D3   } [get_ports sfp_3_tx_n] ;# MGTHTXN1_119 GTHE2_CHANNEL_X1Y37 / GTHE2_COMMON_X1Y9
set_property src_info {type:XDC file:1 line:66 export:INPUT save:INPUT read:READ} [current_design]
set_property -dict {LOC D8   } [get_ports sfp_4_rx_p] ;# MGTHRXP0_119 GTHE2_CHANNEL_X1Y36 / GTHE2_COMMON_X1Y9
set_property src_info {type:XDC file:1 line:67 export:INPUT save:INPUT read:READ} [current_design]
set_property -dict {LOC D7   } [get_ports sfp_4_rx_n] ;# MGTHRXN0_119 GTHE2_CHANNEL_X1Y36 / GTHE2_COMMON_X1Y9
set_property src_info {type:XDC file:1 line:68 export:INPUT save:INPUT read:READ} [current_design]
set_property -dict {LOC E2   } [get_ports sfp_4_tx_p] ;# MGTHTXP0_119 GTHE2_CHANNEL_X1Y36 / GTHE2_COMMON_X1Y9
set_property src_info {type:XDC file:1 line:69 export:INPUT save:INPUT read:READ} [current_design]
set_property -dict {LOC E1   } [get_ports sfp_4_tx_n] ;# MGTHTXN0_119 GTHE2_CHANNEL_X1Y36 / GTHE2_COMMON_X1Y9
set_property src_info {type:XDC file:1 line:70 export:INPUT save:INPUT read:READ} [current_design]
set_property -dict {LOC E10  } [get_ports sfp_mgt_refclk_p] ;# MGTREFCLK0P_118 from IC20.28
set_property src_info {type:XDC file:1 line:71 export:INPUT save:INPUT read:READ} [current_design]
set_property -dict {LOC E9   } [get_ports sfp_mgt_refclk_n] ;# MGTREFCLK0N_118 from IC20.29
set_property src_info {type:XDC file:1 line:74 export:INPUT save:INPUT read:READ} [current_design]
set_property -dict {LOC BA29 IOSTANDARD LVCMOS18 SLEW SLOW DRIVE 12} [get_ports sfp_clk_rst]
set_property src_info {type:XDC file:1 line:76 export:INPUT save:INPUT read:READ} [current_design]
set_property -dict {LOC N18  IOSTANDARD LVCMOS15 PULLUP true} [get_ports sfp_1_mod_detect]
set_property src_info {type:XDC file:1 line:77 export:INPUT save:INPUT read:READ} [current_design]
set_property -dict {LOC L19  IOSTANDARD LVCMOS15 PULLUP true} [get_ports sfp_2_mod_detect]
set_property src_info {type:XDC file:1 line:78 export:INPUT save:INPUT read:READ} [current_design]
set_property -dict {LOC J37  IOSTANDARD LVCMOS15 PULLUP true} [get_ports sfp_3_mod_detect]
set_property src_info {type:XDC file:1 line:79 export:INPUT save:INPUT read:READ} [current_design]
set_property -dict {LOC H36  IOSTANDARD LVCMOS15 PULLUP true} [get_ports sfp_4_mod_detect]
set_property src_info {type:XDC file:1 line:80 export:INPUT save:INPUT read:READ} [current_design]
set_property -dict {LOC N19  IOSTANDARD LVCMOS15 SLEW SLOW DRIVE 12} [get_ports {sfp_1_rs[0]}]
set_property src_info {type:XDC file:1 line:81 export:INPUT save:INPUT read:READ} [current_design]
set_property -dict {LOC P18  IOSTANDARD LVCMOS15 SLEW SLOW DRIVE 12} [get_ports {sfp_1_rs[1]}]
set_property src_info {type:XDC file:1 line:82 export:INPUT save:INPUT read:READ} [current_design]
set_property -dict {LOC P20  IOSTANDARD LVCMOS15 SLEW SLOW DRIVE 12} [get_ports {sfp_2_rs[0]}]
set_property src_info {type:XDC file:1 line:83 export:INPUT save:INPUT read:READ} [current_design]
set_property -dict {LOC N20  IOSTANDARD LVCMOS15 SLEW SLOW DRIVE 12} [get_ports {sfp_2_rs[1]}]
set_property src_info {type:XDC file:1 line:84 export:INPUT save:INPUT read:READ} [current_design]
set_property -dict {LOC F39  IOSTANDARD LVCMOS15 SLEW SLOW DRIVE 12} [get_ports {sfp_3_rs[0]}]
set_property src_info {type:XDC file:1 line:85 export:INPUT save:INPUT read:READ} [current_design]
set_property -dict {LOC G36  IOSTANDARD LVCMOS15 SLEW SLOW DRIVE 12} [get_ports {sfp_3_rs[1]}]
set_property src_info {type:XDC file:1 line:86 export:INPUT save:INPUT read:READ} [current_design]
set_property -dict {LOC H38  IOSTANDARD LVCMOS15 SLEW SLOW DRIVE 12} [get_ports {sfp_4_rs[0]}]
set_property src_info {type:XDC file:1 line:87 export:INPUT save:INPUT read:READ} [current_design]
set_property -dict {LOC G38  IOSTANDARD LVCMOS15 SLEW SLOW DRIVE 12} [get_ports {sfp_4_rs[1]}]
set_property src_info {type:XDC file:1 line:88 export:INPUT save:INPUT read:READ} [current_design]
set_property -dict {LOC L17  IOSTANDARD LVCMOS15 PULLUP true} [get_ports sfp_1_los]
set_property src_info {type:XDC file:1 line:89 export:INPUT save:INPUT read:READ} [current_design]
set_property -dict {LOC L20  IOSTANDARD LVCMOS15 PULLUP true} [get_ports sfp_2_los]
set_property src_info {type:XDC file:1 line:90 export:INPUT save:INPUT read:READ} [current_design]
set_property -dict {LOC G37  IOSTANDARD LVCMOS15 PULLUP true} [get_ports sfp_3_los]
set_property src_info {type:XDC file:1 line:91 export:INPUT save:INPUT read:READ} [current_design]
set_property -dict {LOC J36  IOSTANDARD LVCMOS15 PULLUP true} [get_ports sfp_4_los]
set_property src_info {type:XDC file:1 line:92 export:INPUT save:INPUT read:READ} [current_design]
set_property -dict {LOC M18  IOSTANDARD LVCMOS15 SLEW SLOW DRIVE 12} [get_ports sfp_1_tx_disable]
set_property src_info {type:XDC file:1 line:93 export:INPUT save:INPUT read:READ} [current_design]
set_property -dict {LOC B31  IOSTANDARD LVCMOS15 SLEW SLOW DRIVE 12} [get_ports sfp_2_tx_disable]
set_property src_info {type:XDC file:1 line:94 export:INPUT save:INPUT read:READ} [current_design]
set_property -dict {LOC J38  IOSTANDARD LVCMOS15 SLEW SLOW DRIVE 12} [get_ports sfp_3_tx_disable]
set_property src_info {type:XDC file:1 line:95 export:INPUT save:INPUT read:READ} [current_design]
set_property -dict {LOC L21  IOSTANDARD LVCMOS15 SLEW SLOW DRIVE 12} [get_ports sfp_4_tx_disable]
set_property src_info {type:XDC file:1 line:96 export:INPUT save:INPUT read:READ} [current_design]
set_property -dict {LOC M19  IOSTANDARD LVCMOS15 PULLUP true} [get_ports sfp_1_tx_fault]
set_property src_info {type:XDC file:1 line:97 export:INPUT save:INPUT read:READ} [current_design]
set_property -dict {LOC C26  IOSTANDARD LVCMOS15 PULLUP true} [get_ports sfp_2_tx_fault]
set_property src_info {type:XDC file:1 line:98 export:INPUT save:INPUT read:READ} [current_design]
set_property -dict {LOC E39  IOSTANDARD LVCMOS15 PULLUP true} [get_ports sfp_3_tx_fault]
set_property src_info {type:XDC file:1 line:99 export:INPUT save:INPUT read:READ} [current_design]
set_property -dict {LOC J26  IOSTANDARD LVCMOS15 PULLUP true} [get_ports sfp_4_tx_fault]
set_property src_info {type:XDC file:1 line:104 export:INPUT save:INPUT read:READ} [current_design]
set_false_path -to [get_ports {sfp_clk_rst}]
set_property src_info {type:XDC file:1 line:105 export:INPUT save:INPUT read:READ} [current_design]
set_output_delay 0 [get_ports {sfp_clk_rst}]
set_property src_info {type:XDC file:1 line:108 export:INPUT save:INPUT read:READ} [current_design]
set_false_path -from [get_ports {sfp_1_mod_detect sfp_2_mod_detect sfp_3_mod_detect sfp_4_mod_detect}]
set_property src_info {type:XDC file:1 line:109 export:INPUT save:INPUT read:READ} [current_design]
set_input_delay 0 [get_ports {sfp_1_mod_detect sfp_2_mod_detect sfp_3_mod_detect sfp_4_mod_detect}]
set_property src_info {type:XDC file:1 line:110 export:INPUT save:INPUT read:READ} [current_design]
set_false_path -to [get_ports {sfp_1_rs[*] sfp_2_rs[*] sfp_3_rs[*] sfp_4_rs[*]}]
set_property src_info {type:XDC file:1 line:111 export:INPUT save:INPUT read:READ} [current_design]
set_output_delay 0 [get_ports {sfp_1_rs[*] sfp_2_rs[*] sfp_3_rs[*] sfp_4_rs[*]}]
set_property src_info {type:XDC file:1 line:112 export:INPUT save:INPUT read:READ} [current_design]
set_false_path -from [get_ports {get_ports sfp_1_los sfp_2_los sfp_3_los sfp_4_los}]
set_property src_info {type:XDC file:1 line:113 export:INPUT save:INPUT read:READ} [current_design]
set_input_delay 0 [get_ports {get_ports sfp_1_los sfp_2_los sfp_3_los sfp_4_los}]
set_property src_info {type:XDC file:1 line:114 export:INPUT save:INPUT read:READ} [current_design]
set_false_path -to [get_ports {get_ports sfp_1_tx_disable sfp_2_tx_disable sfp_3_tx_disable sfp_4_tx_disable}]
set_property src_info {type:XDC file:1 line:115 export:INPUT save:INPUT read:READ} [current_design]
set_output_delay 0 [get_ports {get_ports sfp_1_tx_disable sfp_2_tx_disable sfp_3_tx_disable sfp_4_tx_disable}]
set_property src_info {type:XDC file:1 line:116 export:INPUT save:INPUT read:READ} [current_design]
set_false_path -from [get_ports {get_ports sfp_1_tx_fault sfp_2_tx_fault sfp_3_tx_fault get_ports sfp_4_tx_fault}]
set_property src_info {type:XDC file:1 line:117 export:INPUT save:INPUT read:READ} [current_design]
set_input_delay 0 [get_ports {get_ports sfp_1_tx_fault sfp_2_tx_fault sfp_3_tx_fault get_ports sfp_4_tx_fault}]
set_property src_info {type:XDC file:1 line:120 export:INPUT save:INPUT read:READ} [current_design]
set_property -dict {LOC AK24 IOSTANDARD LVCMOS18 SLEW SLOW DRIVE 12 PULLUP true} [get_ports i2c_scl]
set_property src_info {type:XDC file:1 line:121 export:INPUT save:INPUT read:READ} [current_design]
set_property -dict {LOC AK25 IOSTANDARD LVCMOS18 SLEW SLOW DRIVE 12 PULLUP true} [get_ports i2c_sda]
set_property src_info {type:XDC file:1 line:122 export:INPUT save:INPUT read:READ} [current_design]
set_property -dict {LOC AM39 IOSTANDARD LVCMOS15 SLEW SLOW DRIVE 12} [get_ports i2c_mux_reset]
set_property src_info {type:XDC file:1 line:124 export:INPUT save:INPUT read:READ} [current_design]
set_false_path -to [get_ports {i2c_sda i2c_scl i2c_mux_reset}]
set_property src_info {type:XDC file:1 line:125 export:INPUT save:INPUT read:READ} [current_design]
set_output_delay 0 [get_ports {i2c_sda i2c_scl i2c_mux_reset}]
set_property src_info {type:XDC file:1 line:126 export:INPUT save:INPUT read:READ} [current_design]
set_false_path -from [get_ports {i2c_sda i2c_scl}]
set_property src_info {type:XDC file:1 line:127 export:INPUT save:INPUT read:READ} [current_design]
set_input_delay 0 [get_ports {i2c_sda i2c_scl}]
set_property src_info {type:XDC file:1 line:130 export:INPUT save:INPUT read:READ} [current_design]
set_property -dict {LOC Y4   } [get_ports {pcie_rx_p[0]}] ;# MGTHTXP3_115 GTHE2_CHANNEL_X1Y23 / GTHE2_COMMON_X1Y5
set_property src_info {type:XDC file:1 line:131 export:INPUT save:INPUT read:READ} [current_design]
set_property -dict {LOC Y3   } [get_ports {pcie_rx_n[0]}] ;# MGTHTXN3_115 GTHE2_CHANNEL_X1Y23 / GTHE2_COMMON_X1Y5
set_property src_info {type:XDC file:1 line:132 export:INPUT save:INPUT read:READ} [current_design]
set_property -dict {LOC W2   } [get_ports {pcie_tx_p[0]}] ;# MGTHTXP3_115 GTHE2_CHANNEL_X1Y23 / GTHE2_COMMON_X1Y5
set_property src_info {type:XDC file:1 line:133 export:INPUT save:INPUT read:READ} [current_design]
set_property -dict {LOC W1   } [get_ports {pcie_tx_n[0]}] ;# MGTHTXN3_115 GTHE2_CHANNEL_X1Y23 / GTHE2_COMMON_X1Y5
set_property src_info {type:XDC file:1 line:134 export:INPUT save:INPUT read:READ} [current_design]
set_property -dict {LOC AA6  } [get_ports {pcie_rx_p[1]}] ;# MGTHTXP2_115 GTHE2_CHANNEL_X1Y22 / GTHE2_COMMON_X1Y5
set_property src_info {type:XDC file:1 line:135 export:INPUT save:INPUT read:READ} [current_design]
set_property -dict {LOC AA5  } [get_ports {pcie_rx_n[1]}] ;# MGTHTXN2_115 GTHE2_CHANNEL_X1Y22 / GTHE2_COMMON_X1Y5
set_property src_info {type:XDC file:1 line:136 export:INPUT save:INPUT read:READ} [current_design]
set_property -dict {LOC AA2  } [get_ports {pcie_tx_p[1]}] ;# MGTHTXP2_115 GTHE2_CHANNEL_X1Y22 / GTHE2_COMMON_X1Y5
set_property src_info {type:XDC file:1 line:137 export:INPUT save:INPUT read:READ} [current_design]
set_property -dict {LOC AA1  } [get_ports {pcie_tx_n[1]}] ;# MGTHTXN2_115 GTHE2_CHANNEL_X1Y22 / GTHE2_COMMON_X1Y5
set_property src_info {type:XDC file:1 line:138 export:INPUT save:INPUT read:READ} [current_design]
set_property -dict {LOC AB4  } [get_ports {pcie_rx_p[2]}] ;# MGTHTXP1_115 GTHE2_CHANNEL_X1Y21 / GTHE2_COMMON_X1Y5
set_property src_info {type:XDC file:1 line:139 export:INPUT save:INPUT read:READ} [current_design]
set_property -dict {LOC AB3  } [get_ports {pcie_rx_n[2]}] ;# MGTHTXN1_115 GTHE2_CHANNEL_X1Y21 / GTHE2_COMMON_X1Y5
set_property src_info {type:XDC file:1 line:140 export:INPUT save:INPUT read:READ} [current_design]
set_property -dict {LOC AC2  } [get_ports {pcie_tx_p[2]}] ;# MGTHTXP1_115 GTHE2_CHANNEL_X1Y21 / GTHE2_COMMON_X1Y5
set_property src_info {type:XDC file:1 line:141 export:INPUT save:INPUT read:READ} [current_design]
set_property -dict {LOC AC1  } [get_ports {pcie_tx_n[2]}] ;# MGTHTXN1_115 GTHE2_CHANNEL_X1Y21 / GTHE2_COMMON_X1Y5
set_property src_info {type:XDC file:1 line:142 export:INPUT save:INPUT read:READ} [current_design]
set_property -dict {LOC AC6  } [get_ports {pcie_rx_p[3]}] ;# MGTHTXP0_115 GTHE2_CHANNEL_X1Y20 / GTHE2_COMMON_X1Y5
set_property src_info {type:XDC file:1 line:143 export:INPUT save:INPUT read:READ} [current_design]
set_property -dict {LOC AC5  } [get_ports {pcie_rx_n[3]}] ;# MGTHTXN0_115 GTHE2_CHANNEL_X1Y20 / GTHE2_COMMON_X1Y5
set_property src_info {type:XDC file:1 line:144 export:INPUT save:INPUT read:READ} [current_design]
set_property -dict {LOC AE2  } [get_ports {pcie_tx_p[3]}] ;# MGTHTXP0_115 GTHE2_CHANNEL_X1Y20 / GTHE2_COMMON_X1Y5
set_property src_info {type:XDC file:1 line:145 export:INPUT save:INPUT read:READ} [current_design]
set_property -dict {LOC AE1  } [get_ports {pcie_tx_n[3]}] ;# MGTHTXN0_115 GTHE2_CHANNEL_X1Y20 / GTHE2_COMMON_X1Y5
set_property src_info {type:XDC file:1 line:146 export:INPUT save:INPUT read:READ} [current_design]
set_property -dict {LOC AD4  } [get_ports {pcie_rx_p[4]}] ;# MGTHTXP3_114 GTHE2_CHANNEL_X1Y19 / GTHE2_COMMON_X1Y4
set_property src_info {type:XDC file:1 line:147 export:INPUT save:INPUT read:READ} [current_design]
set_property -dict {LOC AD3  } [get_ports {pcie_rx_n[4]}] ;# MGTHTXN3_114 GTHE2_CHANNEL_X1Y19 / GTHE2_COMMON_X1Y4
set_property src_info {type:XDC file:1 line:148 export:INPUT save:INPUT read:READ} [current_design]
set_property -dict {LOC AG2  } [get_ports {pcie_tx_p[4]}] ;# MGTHTXP3_114 GTHE2_CHANNEL_X1Y19 / GTHE2_COMMON_X1Y4
set_property src_info {type:XDC file:1 line:149 export:INPUT save:INPUT read:READ} [current_design]
set_property -dict {LOC AG1  } [get_ports {pcie_tx_n[4]}] ;# MGTHTXN3_114 GTHE2_CHANNEL_X1Y19 / GTHE2_COMMON_X1Y4
set_property src_info {type:XDC file:1 line:150 export:INPUT save:INPUT read:READ} [current_design]
set_property -dict {LOC AE6  } [get_ports {pcie_rx_p[5]}] ;# MGTHTXP2_114 GTHE2_CHANNEL_X1Y18 / GTHE2_COMMON_X1Y4
set_property src_info {type:XDC file:1 line:151 export:INPUT save:INPUT read:READ} [current_design]
set_property -dict {LOC AE5  } [get_ports {pcie_rx_n[5]}] ;# MGTHTXN2_114 GTHE2_CHANNEL_X1Y18 / GTHE2_COMMON_X1Y4
set_property src_info {type:XDC file:1 line:152 export:INPUT save:INPUT read:READ} [current_design]
set_property -dict {LOC AH4  } [get_ports {pcie_tx_p[5]}] ;# MGTHTXP2_114 GTHE2_CHANNEL_X1Y18 / GTHE2_COMMON_X1Y4
set_property src_info {type:XDC file:1 line:153 export:INPUT save:INPUT read:READ} [current_design]
set_property -dict {LOC AH3  } [get_ports {pcie_tx_n[5]}] ;# MGTHTXN2_114 GTHE2_CHANNEL_X1Y18 / GTHE2_COMMON_X1Y4
set_property src_info {type:XDC file:1 line:154 export:INPUT save:INPUT read:READ} [current_design]
set_property -dict {LOC AF4  } [get_ports {pcie_rx_p[6]}] ;# MGTHTXP1_114 GTHE2_CHANNEL_X1Y17 / GTHE2_COMMON_X1Y4
set_property src_info {type:XDC file:1 line:155 export:INPUT save:INPUT read:READ} [current_design]
set_property -dict {LOC AF3  } [get_ports {pcie_rx_n[6]}] ;# MGTHTXN1_114 GTHE2_CHANNEL_X1Y17 / GTHE2_COMMON_X1Y4
set_property src_info {type:XDC file:1 line:156 export:INPUT save:INPUT read:READ} [current_design]
set_property -dict {LOC AJ2  } [get_ports {pcie_tx_p[6]}] ;# MGTHTXP1_114 GTHE2_CHANNEL_X1Y17 / GTHE2_COMMON_X1Y4
set_property src_info {type:XDC file:1 line:157 export:INPUT save:INPUT read:READ} [current_design]
set_property -dict {LOC AJ1  } [get_ports {pcie_tx_n[6]}] ;# MGTHTXN1_114 GTHE2_CHANNEL_X1Y17 / GTHE2_COMMON_X1Y4
set_property src_info {type:XDC file:1 line:158 export:INPUT save:INPUT read:READ} [current_design]
set_property -dict {LOC AG6  } [get_ports {pcie_rx_p[7]}] ;# MGTHTXP0_114 GTHE2_CHANNEL_X1Y16 / GTHE2_COMMON_X1Y4
set_property src_info {type:XDC file:1 line:159 export:INPUT save:INPUT read:READ} [current_design]
set_property -dict {LOC AG5  } [get_ports {pcie_rx_n[7]}] ;# MGTHTXN0_114 GTHE2_CHANNEL_X1Y16 / GTHE2_COMMON_X1Y4
set_property src_info {type:XDC file:1 line:160 export:INPUT save:INPUT read:READ} [current_design]
set_property -dict {LOC AK4  } [get_ports {pcie_tx_p[7]}] ;# MGTHTXP0_114 GTHE2_CHANNEL_X1Y16 / GTHE2_COMMON_X1Y4
set_property src_info {type:XDC file:1 line:161 export:INPUT save:INPUT read:READ} [current_design]
set_property -dict {LOC AK3  } [get_ports {pcie_tx_n[7]}] ;# MGTHTXN0_114 GTHE2_CHANNEL_X1Y16 / GTHE2_COMMON_X1Y4
set_property src_info {type:XDC file:1 line:162 export:INPUT save:INPUT read:READ} [current_design]
set_property -dict {LOC AB8  } [get_ports pcie_mgt_refclk_p] ;# MGTREFCLK1P_115
set_property src_info {type:XDC file:1 line:163 export:INPUT save:INPUT read:READ} [current_design]
set_property -dict {LOC AB7  } [get_ports pcie_mgt_refclk_n] ;# MGTREFCLK1N_115
set_property src_info {type:XDC file:1 line:164 export:INPUT save:INPUT read:READ} [current_design]
set_property -dict {LOC AY35 IOSTANDARD LVCMOS18 PULLUP true} [get_ports pcie_reset_n]

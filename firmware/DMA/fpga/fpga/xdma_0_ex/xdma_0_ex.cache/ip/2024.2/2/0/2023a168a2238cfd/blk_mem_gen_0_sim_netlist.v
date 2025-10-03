// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// Copyright 2022-2024 Advanced Micro Devices, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2024.2 (lin64) Build 5239630 Fri Nov 08 22:34:34 MST 2024
// Date        : Fri Sep  5 17:37:34 2025
// Host        : lampranthus running 64-bit Ubuntu 24.04.2 LTS
// Command     : write_verilog -force -mode funcsim -rename_top decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix -prefix
//               decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_ blk_mem_gen_0_sim_netlist.v
// Design      : blk_mem_gen_0
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xc7vx690tffg1761-3
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CHECK_LICENSE_TYPE = "blk_mem_gen_0,blk_mem_gen_v8_4_9,{}" *) (* downgradeipidentifiedwarnings = "yes" *) (* x_core_info = "blk_mem_gen_v8_4_9,Vivado 2024.2" *) 
(* NotValidForBitStream *)
module decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix
   (rsta_busy,
    rstb_busy,
    s_aclk,
    s_aresetn,
    s_axi_awaddr,
    s_axi_awvalid,
    s_axi_awready,
    s_axi_wdata,
    s_axi_wstrb,
    s_axi_wvalid,
    s_axi_wready,
    s_axi_bresp,
    s_axi_bvalid,
    s_axi_bready,
    s_axi_araddr,
    s_axi_arvalid,
    s_axi_arready,
    s_axi_rdata,
    s_axi_rresp,
    s_axi_rvalid,
    s_axi_rready);
  output rsta_busy;
  output rstb_busy;
  (* x_interface_info = "xilinx.com:signal:clock:1.0 CLK.ACLK CLK" *) (* x_interface_mode = "slave CLK.ACLK" *) (* x_interface_parameter = "XIL_INTERFACENAME CLK.ACLK, ASSOCIATED_BUSIF AXI_SLAVE_S_AXI:AXILite_SLAVE_S_AXI, ASSOCIATED_RESET s_aresetn, FREQ_HZ 100000000, FREQ_TOLERANCE_HZ 0, PHASE 0.0, INSERT_VIP 0" *) input s_aclk;
  (* x_interface_info = "xilinx.com:signal:reset:1.0 RST.ARESETN RST" *) (* x_interface_mode = "slave RST.ARESETN" *) (* x_interface_parameter = "XIL_INTERFACENAME RST.ARESETN, POLARITY ACTIVE_LOW, INSERT_VIP 0" *) input s_aresetn;
  (* x_interface_info = "xilinx.com:interface:aximm:1.0 AXILite_SLAVE_S_AXI AWADDR" *) (* x_interface_mode = "slave AXILite_SLAVE_S_AXI" *) (* x_interface_parameter = "XIL_INTERFACENAME AXILite_SLAVE_S_AXI, DATA_WIDTH 32, PROTOCOL AXI4LITE, FREQ_HZ 100000000, ID_WIDTH 0, ADDR_WIDTH 32, AWUSER_WIDTH 0, ARUSER_WIDTH 0, WUSER_WIDTH 0, RUSER_WIDTH 0, BUSER_WIDTH 0, READ_WRITE_MODE READ_WRITE, HAS_BURST 0, HAS_LOCK 0, HAS_PROT 0, HAS_CACHE 0, HAS_QOS 0, HAS_REGION 0, HAS_WSTRB 1, HAS_BRESP 1, HAS_RRESP 1, SUPPORTS_NARROW_BURST 0, NUM_READ_OUTSTANDING 1, NUM_WRITE_OUTSTANDING 1, MAX_BURST_LENGTH 1, PHASE 0.0, NUM_READ_THREADS 1, NUM_WRITE_THREADS 1, RUSER_BITS_PER_BYTE 0, WUSER_BITS_PER_BYTE 0, INSERT_VIP 0" *) input [31:0]s_axi_awaddr;
  (* x_interface_info = "xilinx.com:interface:aximm:1.0 AXILite_SLAVE_S_AXI AWVALID" *) input s_axi_awvalid;
  (* x_interface_info = "xilinx.com:interface:aximm:1.0 AXILite_SLAVE_S_AXI AWREADY" *) output s_axi_awready;
  (* x_interface_info = "xilinx.com:interface:aximm:1.0 AXILite_SLAVE_S_AXI WDATA" *) input [31:0]s_axi_wdata;
  (* x_interface_info = "xilinx.com:interface:aximm:1.0 AXILite_SLAVE_S_AXI WSTRB" *) input [3:0]s_axi_wstrb;
  (* x_interface_info = "xilinx.com:interface:aximm:1.0 AXILite_SLAVE_S_AXI WVALID" *) input s_axi_wvalid;
  (* x_interface_info = "xilinx.com:interface:aximm:1.0 AXILite_SLAVE_S_AXI WREADY" *) output s_axi_wready;
  (* x_interface_info = "xilinx.com:interface:aximm:1.0 AXILite_SLAVE_S_AXI BRESP" *) output [1:0]s_axi_bresp;
  (* x_interface_info = "xilinx.com:interface:aximm:1.0 AXILite_SLAVE_S_AXI BVALID" *) output s_axi_bvalid;
  (* x_interface_info = "xilinx.com:interface:aximm:1.0 AXILite_SLAVE_S_AXI BREADY" *) input s_axi_bready;
  (* x_interface_info = "xilinx.com:interface:aximm:1.0 AXILite_SLAVE_S_AXI ARADDR" *) input [31:0]s_axi_araddr;
  (* x_interface_info = "xilinx.com:interface:aximm:1.0 AXILite_SLAVE_S_AXI ARVALID" *) input s_axi_arvalid;
  (* x_interface_info = "xilinx.com:interface:aximm:1.0 AXILite_SLAVE_S_AXI ARREADY" *) output s_axi_arready;
  (* x_interface_info = "xilinx.com:interface:aximm:1.0 AXILite_SLAVE_S_AXI RDATA" *) output [31:0]s_axi_rdata;
  (* x_interface_info = "xilinx.com:interface:aximm:1.0 AXILite_SLAVE_S_AXI RRESP" *) output [1:0]s_axi_rresp;
  (* x_interface_info = "xilinx.com:interface:aximm:1.0 AXILite_SLAVE_S_AXI RVALID" *) output s_axi_rvalid;
  (* x_interface_info = "xilinx.com:interface:aximm:1.0 AXILite_SLAVE_S_AXI RREADY" *) input s_axi_rready;

  wire \<const0> ;
  wire rsta_busy;
  wire rstb_busy;
  wire s_aclk;
  wire s_aresetn;
  wire [31:0]s_axi_araddr;
  wire s_axi_arready;
  wire s_axi_arvalid;
  wire [31:0]s_axi_awaddr;
  wire s_axi_awready;
  wire s_axi_awvalid;
  wire s_axi_bready;
  wire s_axi_bvalid;
  wire [31:0]s_axi_rdata;
  wire s_axi_rready;
  wire s_axi_rvalid;
  wire [31:0]s_axi_wdata;
  wire s_axi_wready;
  wire [3:0]s_axi_wstrb;
  wire s_axi_wvalid;
  wire NLW_U0_dbiterr_UNCONNECTED;
  wire NLW_U0_s_axi_dbiterr_UNCONNECTED;
  wire NLW_U0_s_axi_rlast_UNCONNECTED;
  wire NLW_U0_s_axi_sbiterr_UNCONNECTED;
  wire NLW_U0_sbiterr_UNCONNECTED;
  wire [31:0]NLW_U0_douta_UNCONNECTED;
  wire [31:0]NLW_U0_doutb_UNCONNECTED;
  wire [9:0]NLW_U0_rdaddrecc_UNCONNECTED;
  wire [3:0]NLW_U0_s_axi_bid_UNCONNECTED;
  wire [1:0]NLW_U0_s_axi_bresp_UNCONNECTED;
  wire [9:0]NLW_U0_s_axi_rdaddrecc_UNCONNECTED;
  wire [3:0]NLW_U0_s_axi_rid_UNCONNECTED;
  wire [1:0]NLW_U0_s_axi_rresp_UNCONNECTED;

  assign s_axi_bresp[1] = \<const0> ;
  assign s_axi_bresp[0] = \<const0> ;
  assign s_axi_rresp[1] = \<const0> ;
  assign s_axi_rresp[0] = \<const0> ;
  GND GND
       (.G(\<const0> ));
  (* C_ADDRA_WIDTH = "10" *) 
  (* C_ADDRB_WIDTH = "10" *) 
  (* C_ALGORITHM = "1" *) 
  (* C_AXI_ID_WIDTH = "4" *) 
  (* C_AXI_SLAVE_TYPE = "0" *) 
  (* C_AXI_TYPE = "0" *) 
  (* C_BYTE_SIZE = "8" *) 
  (* C_COMMON_CLK = "1" *) 
  (* C_COUNT_18K_BRAM = "0" *) 
  (* C_COUNT_36K_BRAM = "1" *) 
  (* C_CTRL_ECC_ALGO = "NONE" *) 
  (* C_DEFAULT_DATA = "0" *) 
  (* C_DISABLE_WARN_BHV_COLL = "0" *) 
  (* C_DISABLE_WARN_BHV_RANGE = "0" *) 
  (* C_ELABORATION_DIR = "./" *) 
  (* C_ENABLE_32BIT_ADDRESS = "0" *) 
  (* C_EN_DEEPSLEEP_PIN = "0" *) 
  (* C_EN_ECC_PIPE = "0" *) 
  (* C_EN_RDADDRA_CHG = "0" *) 
  (* C_EN_RDADDRB_CHG = "0" *) 
  (* C_EN_SAFETY_CKT = "1" *) 
  (* C_EN_SHUTDOWN_PIN = "0" *) 
  (* C_EN_SLEEP_PIN = "0" *) 
  (* C_EST_POWER_SUMMARY = "Estimated Power for IP     :     5.96515 mW" *) 
  (* C_FAMILY = "virtex7" *) 
  (* C_HAS_AXI_ID = "0" *) 
  (* C_HAS_ENA = "1" *) 
  (* C_HAS_ENB = "1" *) 
  (* C_HAS_INJECTERR = "0" *) 
  (* C_HAS_MEM_OUTPUT_REGS_A = "0" *) 
  (* C_HAS_MEM_OUTPUT_REGS_B = "0" *) 
  (* C_HAS_MUX_OUTPUT_REGS_A = "0" *) 
  (* C_HAS_MUX_OUTPUT_REGS_B = "0" *) 
  (* C_HAS_REGCEA = "0" *) 
  (* C_HAS_REGCEB = "0" *) 
  (* C_HAS_RSTA = "0" *) 
  (* C_HAS_RSTB = "1" *) 
  (* C_HAS_SOFTECC_INPUT_REGS_A = "0" *) 
  (* C_HAS_SOFTECC_OUTPUT_REGS_B = "0" *) 
  (* C_INITA_VAL = "0" *) 
  (* C_INITB_VAL = "0" *) 
  (* C_INIT_FILE = "blk_mem_gen_0.mem" *) 
  (* C_INIT_FILE_NAME = "no_coe_file_loaded" *) 
  (* C_INTERFACE_TYPE = "1" *) 
  (* C_LOAD_INIT_FILE = "0" *) 
  (* C_MEM_TYPE = "1" *) 
  (* C_MUX_PIPELINE_STAGES = "0" *) 
  (* C_PRIM_TYPE = "1" *) 
  (* C_READ_DEPTH_A = "1024" *) 
  (* C_READ_DEPTH_B = "1024" *) 
  (* C_READ_LATENCY_A = "1" *) 
  (* C_READ_LATENCY_B = "1" *) 
  (* C_READ_WIDTH_A = "32" *) 
  (* C_READ_WIDTH_B = "32" *) 
  (* C_RSTRAM_A = "0" *) 
  (* C_RSTRAM_B = "0" *) 
  (* C_RST_PRIORITY_A = "CE" *) 
  (* C_RST_PRIORITY_B = "CE" *) 
  (* C_SIM_COLLISION_CHECK = "ALL" *) 
  (* C_USE_BRAM_BLOCK = "0" *) 
  (* C_USE_BYTE_WEA = "1" *) 
  (* C_USE_BYTE_WEB = "1" *) 
  (* C_USE_DEFAULT_DATA = "0" *) 
  (* C_USE_ECC = "0" *) 
  (* C_USE_SOFTECC = "0" *) 
  (* C_USE_URAM = "0" *) 
  (* C_WEA_WIDTH = "4" *) 
  (* C_WEB_WIDTH = "4" *) 
  (* C_WRITE_DEPTH_A = "1024" *) 
  (* C_WRITE_DEPTH_B = "1024" *) 
  (* C_WRITE_MODE_A = "READ_FIRST" *) 
  (* C_WRITE_MODE_B = "READ_FIRST" *) 
  (* C_WRITE_WIDTH_A = "32" *) 
  (* C_WRITE_WIDTH_B = "32" *) 
  (* C_XDEVICEFAMILY = "virtex7" *) 
  (* downgradeipidentifiedwarnings = "yes" *) 
  (* is_du_within_envelope = "true" *) 
  decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_blk_mem_gen_v8_4_9 U0
       (.addra({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .addrb({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .clka(1'b0),
        .clkb(1'b0),
        .dbiterr(NLW_U0_dbiterr_UNCONNECTED),
        .deepsleep(1'b0),
        .dina({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .dinb({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .douta(NLW_U0_douta_UNCONNECTED[31:0]),
        .doutb(NLW_U0_doutb_UNCONNECTED[31:0]),
        .eccpipece(1'b0),
        .ena(1'b0),
        .enb(1'b0),
        .injectdbiterr(1'b0),
        .injectsbiterr(1'b0),
        .rdaddrecc(NLW_U0_rdaddrecc_UNCONNECTED[9:0]),
        .regcea(1'b1),
        .regceb(1'b1),
        .rsta(1'b0),
        .rsta_busy(rsta_busy),
        .rstb(1'b0),
        .rstb_busy(rstb_busy),
        .s_aclk(s_aclk),
        .s_aresetn(s_aresetn),
        .s_axi_araddr({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,s_axi_araddr[11:2],1'b0,1'b0}),
        .s_axi_arburst({1'b0,1'b0}),
        .s_axi_arid({1'b0,1'b0,1'b0,1'b0}),
        .s_axi_arlen({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .s_axi_arready(s_axi_arready),
        .s_axi_arsize({1'b0,1'b0,1'b0}),
        .s_axi_arvalid(s_axi_arvalid),
        .s_axi_awaddr({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,s_axi_awaddr[11:2],1'b0,1'b0}),
        .s_axi_awburst({1'b0,1'b0}),
        .s_axi_awid({1'b0,1'b0,1'b0,1'b0}),
        .s_axi_awlen({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .s_axi_awready(s_axi_awready),
        .s_axi_awsize({1'b0,1'b0,1'b0}),
        .s_axi_awvalid(s_axi_awvalid),
        .s_axi_bid(NLW_U0_s_axi_bid_UNCONNECTED[3:0]),
        .s_axi_bready(s_axi_bready),
        .s_axi_bresp(NLW_U0_s_axi_bresp_UNCONNECTED[1:0]),
        .s_axi_bvalid(s_axi_bvalid),
        .s_axi_dbiterr(NLW_U0_s_axi_dbiterr_UNCONNECTED),
        .s_axi_injectdbiterr(1'b0),
        .s_axi_injectsbiterr(1'b0),
        .s_axi_rdaddrecc(NLW_U0_s_axi_rdaddrecc_UNCONNECTED[9:0]),
        .s_axi_rdata(s_axi_rdata),
        .s_axi_rid(NLW_U0_s_axi_rid_UNCONNECTED[3:0]),
        .s_axi_rlast(NLW_U0_s_axi_rlast_UNCONNECTED),
        .s_axi_rready(s_axi_rready),
        .s_axi_rresp(NLW_U0_s_axi_rresp_UNCONNECTED[1:0]),
        .s_axi_rvalid(s_axi_rvalid),
        .s_axi_sbiterr(NLW_U0_s_axi_sbiterr_UNCONNECTED),
        .s_axi_wdata(s_axi_wdata),
        .s_axi_wlast(1'b0),
        .s_axi_wready(s_axi_wready),
        .s_axi_wstrb(s_axi_wstrb),
        .s_axi_wvalid(s_axi_wvalid),
        .sbiterr(NLW_U0_sbiterr_UNCONNECTED),
        .shutdown(1'b0),
        .sleep(1'b0),
        .wea({1'b0,1'b0,1'b0,1'b0}),
        .web({1'b0,1'b0,1'b0,1'b0}));
endmodule
`pragma protect begin_protected
`pragma protect version = 1
`pragma protect encrypt_agent = "XILINX"
`pragma protect encrypt_agent_info = "Xilinx Encryption Tool 2024.2"
`pragma protect key_keyowner="Synopsys", key_keyname="SNPS-VCS-RSA-2", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=128)
`pragma protect key_block
FPXllyX2NFs/RMngGqZy2bLYbZr92CdofeZrJOHklWXExpaPgHNYp2Lzm4MnflbnrfSkCmLwwKT5
zfRgEip7FKQ5Zhb73p0MAIADixBZ/ZRt4hQkJL0T9brm0waLHfanjnov2aCX6jN3LbQc3ujmDga6
Dd73k78u4xjRTDv1/P4=

`pragma protect key_keyowner="Aldec", key_keyname="ALDEC15_001", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
kr7VKKvChFoiyRCReag+OvU3jnmG9pN0cv+BxhNmMKLthg/ksgNZyU3L+fQ7cmIQELtlUjwjkBAP
Jjq5RsCnHbJxj+Ys1GNhriiBsxLqxWCP8onhAVvgZN2xZFOih0UWpqlU8NVP8Eww1ohvkDgxTstC
3kDmYehxIUJjqCC/mgRZmuezqugrFdubYmBoz16tUvD17iA5qqCIMS9xSIXYp2LBNekmWEwrVqzu
R4koEo4UlXl/CEw0XY3QvMoHnlXgu6N/6sc+nxZtKSwjiMVvGnZE9UVvJPAC3Hn3zKFGlK53mmGO
Tj0dWzhwX0ahSYzkyJC/HLdbGZmriL2UNvDyFw==

`pragma protect key_keyowner="Mentor Graphics Corporation", key_keyname="MGC-VELOCE-RSA", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=128)
`pragma protect key_block
CaLc9FGt3AdRHfNtGAsGFY/QEvHY1Vv4TvvgCDsdDMqiuDeLizFJDJeskBWjeKDoE2cufK8TxiBq
mySRQNJoeOKnxTiDdf+Rx6m0iR6h/YeswegYwgghpM5KVrl6mSwF3+4yEovPM7a+9ArDQ5vl+WT8
SilNGzyW0KnTwe7+szs=

`pragma protect key_keyowner="Mentor Graphics Corporation", key_keyname="MGC-VERIF-SIM-RSA-2", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
cEnudSW1X71p0Xuq6jrXOxHnBku87IA0RA3zKqmeZHZM0r+9rEm5MSzX8RecnQ994yiqeyxbIH2l
fGEzUzr0ZzryS3fkf2LnJuB39f2YARW9eVCSiaeWaraZuY1l89T+h3vgdlurS/1LIraYLS1MyOXa
6F1LAcQp3W4OO4ctc3q1FRMZGldRS1biMsKwJ8Lxj8NEOm67UfgFrJNQAxbVXEfbWRWhKtwNxcTB
JbgC8j4EHkIA46mzoHloeBAL6KieplQUBjKXSSTb66rxglbFhWLy+mirROHcocu9J4ZbvTRYZEww
4lso1lqAllVLAoKYqa3WImZuSRoTbGDngBt9Lg==

`pragma protect key_keyowner="Real Intent", key_keyname="RI-RSA-KEY-1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
rOyI+x4PlmKcVSFoN3oKgSYpVlmYxc194Ej04il/YmBg10xopy4zmtu5sdCP/uGSNYcNGWeAiw01
mNf98KyNgTUFXruHCA38qjhhEIvl4vfWWn3W3mFRxrIuwmnreT6qTvgMaxIkCdVBDP7Iy7O6WmCf
3Va5X5hnCHhtXgX5UYniBHiLjmupv63B8XMAYDH2n6mQ3H0DF7mtb7psBafd0Z6+IWUbmzwMtKrf
ZrRJBGAhNT0i1KrEjEh/rWjN7Z7N32zQ+Pl1kc5gYCQIX5McfdTdqSaRVXZ/HF90ymS7/8d5LDyj
Er+ORdcjnOn6oAyY4PuUUl4OYUHv5k+RglTe5Q==

`pragma protect key_keyowner="Xilinx", key_keyname="xilinxt_2023_11", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
bJa7kPSpDipzoJoQu1APEjc8vFLqBfQZK/grZvWijD7/FgMTerFCWLUY6n8DWeGdvjXvTeyrqCHE
2rP/H57wUqPC8tIJlGm6ZYQGjZ3TgYqLrJshDE5zYMTO//q0vuSraWvZP7A7SLuW6y7tFE/nplpx
L8gbYORx6j70okGUwnamCMS9yhFr7Z2QTJne1k4GNFGvy66URk3k5cBPl5j4/1yc4xGV+aWYl6L8
q8RorRU/CltObHKrji/jdiY1WtdGrkpRyCEFc+XNPazL9xSLLu5bz6XlvKwoks+8a5KYT/VFUovM
JbM0bpAXM8Z7rGaPuXjqXtZBg5praTZLu/WNcA==

`pragma protect key_keyowner="Metrics Technologies Inc.", key_keyname="DSim", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
PYKBDinOGc/kIVdFzXrz2wA4/QNFxLDrQfTWfR5TjYE6bm49vrZi0bawcr9HXp4OP1+XxPLB3oCP
oV5e/rYeDln531ebt8yEg27XCoSHEX4FU8oG8aBJ8fqgWayOnAMJt025WodOxuZXbhT1zPo7J3uh
6iO9Mv7RtYE2fZ1W+G8oN//FTOEJYPWlKYnt0cDeZrN3I4rHHptZHuu7l8T+df0PYea3x6U3Mvkl
ojZ+TwQtdu0NuYY5j3QNgx3+W2XYq1M773FAnEz/deW54EjE+jf1jjrBk2pl8SYxeKuutS15oPVF
eHdqXYVcJxoUY5JH8z04lITKEnZ4oq6sYS6dog==

`pragma protect key_keyowner="Atrenta", key_keyname="ATR-SG-RSA-1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=384)
`pragma protect key_block
tl+2vFCWZ583gQGsVC7oopz2NCKBiJ9uOHYBGzJZheOHJMqI/ehNvo25l710eBx00tztXzM30AH6
ZhAJg+kJwE2jO0MV5fmG5dnwXmLqoGEJMBs7xwWxvYK7w/0z9M0AJKD7HnuC+IiLhNU/fIxyuE+I
+vWqp//RcfY0tMMp2I2J1yEW6GUahS1ve/4JchssZ7Xu7VthoSDWXMQWATbvsUsDzeSo2+Ruz8Kq
Dc05HqEU8NgBxDPPEKLCcdKLp4byglwj7iCAtCjsPy8P18qjgb2sycFjNgmaiNMMB51WqeD+hneG
hLOue9bqVdEojkrb3q4WbsGZKz0bAGsryxslOlYHP1b8vey3yI2ixA80wyERe8d3GRIeZiSxGykH
qWxsE6x/iyi8QRb5mXZPMApA+Fln8tYmn7+1rFCm8gF4gJWhr1PsSJqTi658symGrzT0Ghjvf2QL
SvvoaeNdy0pOsWs7jLBFndd4GiFA+9K6Y33sziLToU9EvvFokENIslod

`pragma protect key_keyowner="Cadence Design Systems.", key_keyname="CDS_RSA_KEY_VER_1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
oYiCujFRj1F3wKsGZlHR9niEtR9MLXEVAVfy+f/3xrmpW6Ye5a+fBCvm4TH+iRQefGHNdMPnzTNW
K/pEPAS9uMJjOdFiu+APT+LYrSRnEg4W0dX5buSDGM6LBWAuMseoTMjbJJoYDGLRckJgW43E30mX
ej4823nkbfwc+Ecbrup825qLyv8RTQLNHafvJA5lSapdqXwnlOIYRmcHn+sfAh5pGv9kW9aokcdh
ObR2XYxX99rYloyvz3x0pmjxD5ILW4SQMB1IUEuuyqX6eb5IQ+kZ41hjvsHIuQH29vzpCfV9Jqha
WC5yxxK1R+cleZSKD1H1gVzbTei8uFs/91Bgeg==

`pragma protect key_keyowner="Synplicity", key_keyname="SYNP15_1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
urNc+S8AFPj+GVFdqJE5V7P8O6QI6MA3nkwYb8NKbYbVufnXKg6voJIRYYeYr7EOa8mrqirozWbY
Lln9SLWnkaAy2LvL/N6WahoQdCt++4RH+xe768XvSrVUFPrIwZRixqMLurc/tPov4i5P/ukZKl18
ZPZvXRzUNlvCZnMPcF+5QCQihqPbjcZ0YyGgWgX/ipTGG3sNqmylGN7qLa4Rgqu/mB5a2xVyu5Wc
911+/X3VVFx697WVaP5V0SbOzYN8R8+8B8kdznwixMA+f4lSbBXyRysVOSzYjo8bKEMqyKMVBQn9
xDmEuV0DvVWXdO7VPvWA1LuJFwS07OxeI2GCcQ==

`pragma protect key_keyowner="Mentor Graphics Corporation", key_keyname="MGC-PREC-RSA", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
QcP7fsLZxaDrG29e9HQeXfu2TsKsdyW7Yc1vWct6lbmDEfXkWMU1fFWSPIjPzRc9UOnfEu0bRn+B
D+8MWokqes3WF7txljBmgUPiNGZ8arUU6ENa/IY/Wv7iaB/ZKM5PtdnFAkjDIrYyKFCTz/U6Yzwi
hBGGarK/wYQOLzeeKRewiPTiNUL7tztWuMZ1t1msxD951EeKrwjrjcXIIuf/TzrOGUOlWgjHlnrl
4Q/lfMAnRLBNTSWG+5wWewCE8jK2X/gJ5AV4p3x1WP3+JglbxpP39l3pzedXqciZPbuz2XlFnRPV
KByaUaAShzJ56p8+0HjWebibqQdieGNPiPWW0Q==

`pragma protect data_method = "AES128-CBC"
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 57760)
`pragma protect data_block
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
nWuvbb57cMQy2X3RnOP8VhrvRg==
`pragma protect end_protected
`ifndef GLBL
`define GLBL
`timescale  1 ps / 1 ps

module glbl ();

    parameter ROC_WIDTH = 100000;
    parameter TOC_WIDTH = 0;
    parameter GRES_WIDTH = 10000;
    parameter GRES_START = 10000;

//--------   STARTUP Globals --------------
    wire GSR;
    wire GTS;
    wire GWE;
    wire PRLD;
    wire GRESTORE;
    tri1 p_up_tmp;
    tri (weak1, strong0) PLL_LOCKG = p_up_tmp;

    wire PROGB_GLBL;
    wire CCLKO_GLBL;
    wire FCSBO_GLBL;
    wire [3:0] DO_GLBL;
    wire [3:0] DI_GLBL;
   
    reg GSR_int;
    reg GTS_int;
    reg PRLD_int;
    reg GRESTORE_int;

//--------   JTAG Globals --------------
    wire JTAG_TDO_GLBL;
    wire JTAG_TCK_GLBL;
    wire JTAG_TDI_GLBL;
    wire JTAG_TMS_GLBL;
    wire JTAG_TRST_GLBL;

    reg JTAG_CAPTURE_GLBL;
    reg JTAG_RESET_GLBL;
    reg JTAG_SHIFT_GLBL;
    reg JTAG_UPDATE_GLBL;
    reg JTAG_RUNTEST_GLBL;

    reg JTAG_SEL1_GLBL = 0;
    reg JTAG_SEL2_GLBL = 0 ;
    reg JTAG_SEL3_GLBL = 0;
    reg JTAG_SEL4_GLBL = 0;

    reg JTAG_USER_TDO1_GLBL = 1'bz;
    reg JTAG_USER_TDO2_GLBL = 1'bz;
    reg JTAG_USER_TDO3_GLBL = 1'bz;
    reg JTAG_USER_TDO4_GLBL = 1'bz;

    assign (strong1, weak0) GSR = GSR_int;
    assign (strong1, weak0) GTS = GTS_int;
    assign (weak1, weak0) PRLD = PRLD_int;
    assign (strong1, weak0) GRESTORE = GRESTORE_int;

    initial begin
	GSR_int = 1'b1;
	PRLD_int = 1'b1;
	#(ROC_WIDTH)
	GSR_int = 1'b0;
	PRLD_int = 1'b0;
    end

    initial begin
	GTS_int = 1'b1;
	#(TOC_WIDTH)
	GTS_int = 1'b0;
    end

    initial begin 
	GRESTORE_int = 1'b0;
	#(GRES_START);
	GRESTORE_int = 1'b1;
	#(GRES_WIDTH);
	GRESTORE_int = 1'b0;
    end

endmodule
`endif

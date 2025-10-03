// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// Copyright 2022-2024 Advanced Micro Devices, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2024.2 (lin64) Build 5239630 Fri Nov 08 22:34:34 MST 2024
// Date        : Fri Sep  5 17:37:35 2025
// Host        : lampranthus running 64-bit Ubuntu 24.04.2 LTS
// Command     : write_verilog -force -mode funcsim
//               /home/luisfercrtez/Documents/Master/Tesis/NetFPGA-SUME/firmware/DMA/fpga/fpga/xdma_0_ex/xdma_0_ex.gen/sources_1/ip/blk_mem_gen_0/blk_mem_gen_0_sim_netlist.v
// Design      : blk_mem_gen_0
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xc7vx690tffg1761-3
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CHECK_LICENSE_TYPE = "blk_mem_gen_0,blk_mem_gen_v8_4_9,{}" *) (* downgradeipidentifiedwarnings = "yes" *) (* x_core_info = "blk_mem_gen_v8_4_9,Vivado 2024.2" *) 
(* NotValidForBitStream *)
module blk_mem_gen_0
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
  blk_mem_gen_0_blk_mem_gen_v8_4_9 U0
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
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 57712)
`pragma protect data_block
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
H4WUGmrvxZWXgRvUM1xdwFGeD5xqkw3WfMShgw==
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

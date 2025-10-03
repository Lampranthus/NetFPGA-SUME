// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// Copyright 2022-2024 Advanced Micro Devices, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2024.2 (lin64) Build 5239630 Fri Nov 08 22:34:34 MST 2024
// Date        : Wed Sep  3 17:42:09 2025
// Host        : lampranthus running 64-bit Ubuntu 24.04.2 LTS
// Command     : write_verilog -force -mode synth_stub
//               /home/luisfercrtez/Documents/Master/Tesis/NetFPGA-SUME/fpga/fpga/fpga.gen/sources_1/ip/pcie3_7x_0/pcie3_7x_0_stub.v
// Design      : pcie3_7x_0
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7vx690tffg1761-3
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* CHECK_LICENSE_TYPE = "pcie3_7x_0,pcie3_7x_0_pcie_3_0_7vx,{}" *) (* CORE_GENERATION_INFO = "pcie3_7x_0,pcie3_7x_0_pcie_3_0_7vx,{x_ipProduct=Vivado 2024.2,x_ipVendor=xilinx.com,x_ipLibrary=ip,x_ipName=pcie3_7x,x_ipVersion=4.3,x_ipCoreRevision=16,x_ipLanguage=VERILOG,x_ipSimLanguage=MIXED,PL_LINK_CAP_MAX_LINK_SPEED=4,PL_LINK_CAP_MAX_LINK_WIDTH=8,USER_CLK2_FREQ=4,PF0_LINK_CAP_ASPM_SUPPORT=0,C_DATA_WIDTH=256,REF_CLK_FREQ=0,PCIE_LINK_SPEED=3,KEEP_WIDTH=8,ARI_CAP_ENABLE=FALSE,PF0_ARI_CAP_NEXT_FUNC=0x00,AXISTEN_IF_CC_ALIGNMENT_MODE=FALSE,AXISTEN_IF_CQ_ALIGNMENT_MODE=FALSE,AXISTEN_IF_RC_ALIGNMENT_MODE=FALSE,AXISTEN_IF_RC_STRADDLE=TRUE,AXISTEN_IF_RQ_ALIGNMENT_MODE=FALSE,PF0_AER_CAP_ECRC_CHECK_CAPABLE=FALSE,PF0_AER_CAP_ECRC_GEN_CAPABLE=FALSE,PF0_AER_CAP_NEXTPTR=0x300,PF0_ARI_CAP_NEXTPTR=0x000,VF0_ARI_CAP_NEXTPTR=0x000,VF1_ARI_CAP_NEXTPTR=0x000,VF2_ARI_CAP_NEXTPTR=0x000,VF3_ARI_CAP_NEXTPTR=0x000,VF4_ARI_CAP_NEXTPTR=0x000,VF5_ARI_CAP_NEXTPTR=0x000,PF0_BAR0_APERTURE_SIZE=0b10001,PF0_BAR0_CONTROL=0b111,PF0_BAR1_APERTURE_SIZE=0b00000,PF0_BAR1_CONTROL=0b000,PF0_BAR2_APERTURE_SIZE=0b10001,PF0_BAR2_CONTROL=0b111,PF0_BAR3_APERTURE_SIZE=0b00000,PF0_BAR3_CONTROL=0b000,PF0_BAR4_APERTURE_SIZE=0b01001,PF0_BAR4_CONTROL=0b111,PF0_BAR5_APERTURE_SIZE=0b00000,PF0_BAR5_CONTROL=0b000,PF0_CAPABILITY_POINTER=0x80,PF0_CLASS_CODE=0x058000,PF0_VENDOR_ID=0x1234,PF0_DEVICE_ID=0x0001,PF0_DEV_CAP2_128B_CAS_ATOMIC_COMPLETER_SUPPORT=FALSE,PF0_DEV_CAP2_32B_ATOMIC_COMPLETER_SUPPORT=FALSE,PF0_DEV_CAP2_64B_ATOMIC_COMPLETER_SUPPORT=FALSE,PF0_DEV_CAP2_LTR_SUPPORT=FALSE,PF0_DEV_CAP2_OBFF_SUPPORT=00,PF0_DEV_CAP2_TPH_COMPLETER_SUPPORT=FALSE,PF0_DEV_CAP_EXT_TAG_SUPPORTED=TRUE,PF0_DEV_CAP_FUNCTION_LEVEL_RESET_CAPABLE=FALSE,PF0_DEV_CAP_MAX_PAYLOAD_SIZE=0b011,PF0_DPA_CAP_NEXTPTR=0x300,PF0_DPA_CAP_SUB_STATE_POWER_ALLOCATION0=0x00,PF0_DPA_CAP_SUB_STATE_POWER_ALLOCATION1=0x00,PF0_DPA_CAP_SUB_STATE_POWER_ALLOCATION2=0x00,PF0_DPA_CAP_SUB_STATE_POWER_ALLOCATION3=0x00,PF0_DPA_CAP_SUB_STATE_POWER_ALLOCATION4=0x00,PF0_DPA_CAP_SUB_STATE_POWER_ALLOCATION5=0x00,PF0_DPA_CAP_SUB_STATE_POWER_ALLOCATION6=0x00,PF0_DPA_CAP_SUB_STATE_POWER_ALLOCATION7=0x00,PF1_DPA_CAP_SUB_STATE_POWER_ALLOCATION0=0x00,PF1_DPA_CAP_SUB_STATE_POWER_ALLOCATION1=0x00,PF1_DPA_CAP_SUB_STATE_POWER_ALLOCATION2=0x00,PF1_DPA_CAP_SUB_STATE_POWER_ALLOCATION3=0x00,PF1_DPA_CAP_SUB_STATE_POWER_ALLOCATION4=0x00,PF1_DPA_CAP_SUB_STATE_POWER_ALLOCATION5=0x00,PF1_DPA_CAP_SUB_STATE_POWER_ALLOCATION6=0x00,PF1_DPA_CAP_SUB_STATE_POWER_ALLOCATION7=0x00,PF0_DSN_CAP_NEXTPTR=0x300,PF0_EXPANSION_ROM_APERTURE_SIZE=0b00000,PF0_EXPANSION_ROM_ENABLE=FALSE,PF0_INTERRUPT_PIN=0x1,PF0_LINK_STATUS_SLOT_CLOCK_CONFIG=TRUE,PF0_LTR_CAP_NEXTPTR=0x300,PF0_MSIX_CAP_NEXTPTR=0xC0,PF0_MSIX_CAP_PBA_BIR=4,PF0_MSIX_CAP_PBA_OFFSET=0x00008000,PF0_MSIX_CAP_TABLE_BIR=4,PF0_MSIX_CAP_TABLE_OFFSET=0x00000000,PF0_MSIX_CAP_TABLE_SIZE=0x01F,PF0_MSI_CAP_MULTIMSGCAP=0,PF0_MSI_CAP_NEXTPTR=0x00,PF0_PB_CAP_NEXTPTR=0x274,PF0_PM_CAP_NEXTPTR=0xB0,PF0_PM_CAP_PMESUPPORT_D0=FALSE,PF0_PM_CAP_PMESUPPORT_D1=FALSE,PF0_PM_CAP_PMESUPPORT_D3HOT=FALSE,PF0_PM_CAP_SUPP_D1_STATE=FALSE,PF0_RBAR_CAP_ENABLE=FALSE,PF0_RBAR_CAP_NEXTPTR=0x300,PF0_RBAR_CAP_SIZE0=0x00000,PF0_RBAR_CAP_SIZE1=0x00000,PF0_RBAR_CAP_SIZE2=0x00000,PF1_RBAR_CAP_SIZE0=0x00000,PF1_RBAR_CAP_SIZE1=0x00000,PF1_RBAR_CAP_SIZE2=0x00000,PF0_REVISION_ID=0x00,PF0_SRIOV_BAR0_APERTURE_SIZE=0b00000,PF0_SRIOV_BAR0_CONTROL=0b000,PF0_SRIOV_BAR1_APERTURE_SIZE=0b00000,PF0_SRIOV_BAR1_CONTROL=0b000,PF0_SRIOV_BAR2_APERTURE_SIZE=0b00000,PF0_SRIOV_BAR2_CONTROL=0b000,PF0_SRIOV_BAR3_APERTURE_SIZE=0b00000,PF0_SRIOV_BAR3_CONTROL=0b000,PF0_SRIOV_BAR4_APERTURE_SIZE=0b00000,PF0_SRIOV_BAR4_CONTROL=0b000,PF0_SRIOV_BAR5_APERTURE_SIZE=0b00000,PF0_SRIOV_BAR5_CONTROL=0b000,PF0_SRIOV_CAP_INITIAL_VF=0x0000,PF0_SRIOV_CAP_NEXTPTR=0x300,PF0_SRIOV_CAP_TOTAL_VF=0x0000,PF0_SRIOV_CAP_VER=0x0,PF0_SRIOV_FIRST_VF_OFFSET=0x0000,PF0_SRIOV_FUNC_DEP_LINK=0x0000,PF0_SRIOV_SUPPORTED_PAGE_SIZE=0x00000553,PF0_SRIOV_VF_DEVICE_ID=0x0000,PF0_SUBSYSTEM_VENDOR_ID=0x1ce4,PF0_SUBSYSTEM_ID=0x0003,PF0_TPHR_CAP_ENABLE=FALSE,PF0_TPHR_CAP_NEXTPTR=0x300,VF0_TPHR_CAP_NEXTPTR=0x000,VF1_TPHR_CAP_NEXTPTR=0x000,VF2_TPHR_CAP_NEXTPTR=0x000,VF3_TPHR_CAP_NEXTPTR=0x000,VF4_TPHR_CAP_NEXTPTR=0x000,VF5_TPHR_CAP_NEXTPTR=0x000,PF0_TPHR_CAP_ST_MODE_SEL=0x2,PF0_TPHR_CAP_ST_TABLE_LOC=0x2,PF0_TPHR_CAP_ST_TABLE_SIZE=0x000,PF0_TPHR_CAP_VER=0x1,PF1_TPHR_CAP_ST_MODE_SEL=0x0,PF1_TPHR_CAP_ST_TABLE_LOC=0x0,PF1_TPHR_CAP_ST_TABLE_SIZE=0x000,PF1_TPHR_CAP_VER=0x1,VF0_TPHR_CAP_ST_MODE_SEL=0x0,VF0_TPHR_CAP_ST_TABLE_LOC=0x0,VF0_TPHR_CAP_ST_TABLE_SIZE=0x000,VF0_TPHR_CAP_VER=0x1,VF1_TPHR_CAP_ST_MODE_SEL=0x0,VF1_TPHR_CAP_ST_TABLE_LOC=0x0,VF1_TPHR_CAP_ST_TABLE_SIZE=0x000,VF1_TPHR_CAP_VER=0x1,VF2_TPHR_CAP_ST_MODE_SEL=0x0,VF2_TPHR_CAP_ST_TABLE_LOC=0x0,VF2_TPHR_CAP_ST_TABLE_SIZE=0x000,VF2_TPHR_CAP_VER=0x1,VF3_TPHR_CAP_ST_MODE_SEL=0x0,VF3_TPHR_CAP_ST_TABLE_LOC=0x0,VF3_TPHR_CAP_ST_TABLE_SIZE=0x000,VF3_TPHR_CAP_VER=0x1,VF4_TPHR_CAP_ST_MODE_SEL=0x0,VF4_TPHR_CAP_ST_TABLE_LOC=0x0,VF4_TPHR_CAP_ST_TABLE_SIZE=0x000,VF4_TPHR_CAP_VER=0x1,VF5_TPHR_CAP_ST_MODE_SEL=0x0,VF5_TPHR_CAP_ST_TABLE_LOC=0x0,VF5_TPHR_CAP_ST_TABLE_SIZE=0x000,VF5_TPHR_CAP_VER=0x1,PF0_TPHR_CAP_DEV_SPECIFIC_MODE=FALSE,PF0_TPHR_CAP_INT_VEC_MODE=TRUE,PF1_TPHR_CAP_DEV_SPECIFIC_MODE=TRUE,PF1_TPHR_CAP_INT_VEC_MODE=FALSE,VF0_TPHR_CAP_DEV_SPECIFIC_MODE=TRUE,VF0_TPHR_CAP_INT_VEC_MODE=FALSE,VF1_TPHR_CAP_DEV_SPECIFIC_MODE=TRUE,VF1_TPHR_CAP_INT_VEC_MODE=FALSE,VF2_TPHR_CAP_DEV_SPECIFIC_MODE=TRUE,VF2_TPHR_CAP_INT_VEC_MODE=FALSE,VF3_TPHR_CAP_DEV_SPECIFIC_MODE=TRUE,VF3_TPHR_CAP_INT_VEC_MODE=FALSE,VF4_TPHR_CAP_DEV_SPECIFIC_MODE=TRUE,VF4_TPHR_CAP_INT_VEC_MODE=FALSE,VF5_TPHR_CAP_DEV_SPECIFIC_MODE=TRUE,VF5_TPHR_CAP_INT_VEC_MODE=FALSE,PF0_VC_CAP_NEXTPTR=0x000,SPARE_WORD1=0x00000000,PF1_AER_CAP_ECRC_CHECK_CAPABLE=FALSE,PF1_AER_CAP_ECRC_GEN_CAPABLE=FALSE,PF1_AER_CAP_NEXTPTR=0x000,PF1_ARI_CAP_NEXTPTR=0x000,PF1_BAR0_APERTURE_SIZE=0b00000,PF1_BAR0_CONTROL=0b000,PF1_BAR1_APERTURE_SIZE=0b00000,PF1_BAR1_CONTROL=0b000,PF1_BAR2_APERTURE_SIZE=0b00000,PF1_BAR2_CONTROL=0b000,PF1_BAR3_APERTURE_SIZE=0b00000,PF1_BAR3_CONTROL=0b000,PF1_BAR4_APERTURE_SIZE=0b00000,PF1_BAR4_CONTROL=0b000,PF1_BAR5_APERTURE_SIZE=0b00000,PF1_BAR5_CONTROL=0b000,PF1_CAPABILITY_POINTER=0x80,PF1_CLASS_CODE=0x058000,PF1_DEVICE_ID=0x7011,PF1_DEV_CAP_MAX_PAYLOAD_SIZE=0b010,PF1_DPA_CAP_NEXTPTR=0x000,PF1_DSN_CAP_NEXTPTR=0x000,PF1_EXPANSION_ROM_APERTURE_SIZE=0b00000,PF1_EXPANSION_ROM_ENABLE=FALSE,PF1_INTERRUPT_PIN=0x0,PF1_MSIX_CAP_NEXTPTR=0x00,PF1_MSIX_CAP_PBA_BIR=0,PF1_MSIX_CAP_PBA_OFFSET=0x00000000,PF1_MSIX_CAP_TABLE_BIR=0,PF1_MSIX_CAP_TABLE_OFFSET=0x00000000,PF1_MSIX_CAP_TABLE_SIZE=0x000,PF1_MSI_CAP_MULTIMSGCAP=0,PF1_MSI_CAP_NEXTPTR=0x00,PF1_PB_CAP_NEXTPTR=0x000,PF1_PM_CAP_NEXTPTR=0x00,PF1_RBAR_CAP_ENABLE=FALSE,PF1_RBAR_CAP_NEXTPTR=0x000,PF1_REVISION_ID=0x00,PF1_SRIOV_BAR0_APERTURE_SIZE=0b00000,PF1_SRIOV_BAR0_CONTROL=0b000,PF1_SRIOV_BAR1_APERTURE_SIZE=0b00000,PF1_SRIOV_BAR1_CONTROL=0b000,PF1_SRIOV_BAR2_APERTURE_SIZE=0b00000,PF1_SRIOV_BAR2_CONTROL=0b000,PF1_SRIOV_BAR3_APERTURE_SIZE=0b00000,PF1_SRIOV_BAR3_CONTROL=0b000,PF1_SRIOV_BAR4_APERTURE_SIZE=0b00000,PF1_SRIOV_BAR4_CONTROL=0b000,PF1_SRIOV_BAR5_APERTURE_SIZE=0b00000,PF1_SRIOV_BAR5_CONTROL=0b000,PF1_SRIOV_CAP_INITIAL_VF=0x0000,PF1_SRIOV_CAP_NEXTPTR=0x000,PF1_SRIOV_CAP_TOTAL_VF=0x0000,PF1_SRIOV_CAP_VER=0x0,PF1_SRIOV_FIRST_VF_OFFSET=0x0000,PF1_SRIOV_FUNC_DEP_LINK=0x0001,PF1_SRIOV_SUPPORTED_PAGE_SIZE=0x00000553,PF1_SRIOV_VF_DEVICE_ID=0x0000,PF1_SUBSYSTEM_ID=0x0007,PF1_TPHR_CAP_ENABLE=FALSE,PF1_TPHR_CAP_NEXTPTR=0x000,PL_UPSTREAM_FACING=TRUE,SRIOV_CAP_ENABLE=FALSE,TL_CREDITS_CD=0x000,TL_CREDITS_CH=0x00000000,TL_CREDITS_NPD=0x028,TL_CREDITS_NPH=0x20,TL_CREDITS_PD=0x198,TL_CREDITS_PH=0x20,TL_EXTENDED_CFG_EXTEND_INTERFACE_ENABLE=FALSE,TL_LEGACY_MODE_ENABLE=FALSE,TL_PF_ENABLE_REG=FALSE,VF0_CAPABILITY_POINTER=0x80,VF0_MSIX_CAP_PBA_BIR=0,VF0_MSIX_CAP_PBA_OFFSET=0x00000000,VF0_MSIX_CAP_TABLE_BIR=0,VF0_MSIX_CAP_TABLE_OFFSET=0x00000000,VF0_MSIX_CAP_TABLE_SIZE=0x000,VF0_MSI_CAP_MULTIMSGCAP=0,VF0_PM_CAP_NEXTPTR=00000000,VF1_MSIX_CAP_PBA_BIR=0,VF1_MSIX_CAP_PBA_OFFSET=0x00000000,VF1_MSIX_CAP_TABLE_BIR=0,VF1_MSIX_CAP_TABLE_OFFSET=0x00000000,VF1_MSIX_CAP_TABLE_SIZE=0x000,VF1_MSI_CAP_MULTIMSGCAP=0,VF1_PM_CAP_NEXTPTR=00000000,VF2_MSIX_CAP_PBA_BIR=0,VF2_MSIX_CAP_PBA_OFFSET=0x00000000,VF2_MSIX_CAP_TABLE_BIR=0,VF2_MSIX_CAP_TABLE_OFFSET=0x00000000,VF2_MSIX_CAP_TABLE_SIZE=0x000,VF2_MSI_CAP_MULTIMSGCAP=0,VF2_PM_CAP_NEXTPTR=00000000,VF3_MSIX_CAP_PBA_BIR=0,VF3_MSIX_CAP_PBA_OFFSET=0x00000000,VF3_MSIX_CAP_TABLE_BIR=0,VF3_MSIX_CAP_TABLE_OFFSET=0x00000000,VF3_MSIX_CAP_TABLE_SIZE=0x000,VF3_MSI_CAP_MULTIMSGCAP=0,VF3_PM_CAP_NEXTPTR=00000000,VF4_MSIX_CAP_PBA_BIR=0,VF4_MSIX_CAP_PBA_OFFSET=0x00000000,VF4_MSIX_CAP_TABLE_BIR=0,VF4_MSIX_CAP_TABLE_OFFSET=0x00000000,VF4_MSIX_CAP_TABLE_SIZE=0x000,VF4_MSI_CAP_MULTIMSGCAP=0,VF4_PM_CAP_NEXTPTR=00000000,VF5_MSIX_CAP_PBA_BIR=0,VF5_MSIX_CAP_PBA_OFFSET=0x00000000,VF5_MSIX_CAP_TABLE_BIR=0,VF5_MSIX_CAP_TABLE_OFFSET=0x00000000,VF5_MSIX_CAP_TABLE_SIZE=0x000,VF5_MSI_CAP_MULTIMSGCAP=0,VF5_PM_CAP_NEXTPTR=00000000,COMPLETION_SPACE=16KB,gen_x0y0_ucf=1,gen_x0y3_ucf=0,gen_x0y2_ucf=0,gen_x0y1_ucf=0,silicon_revision=Production,xlnx_ref_board=0,pcie_blk_locn=0,SHARED_LOGIC_IN_CORE=TRUE,PIPE_SIM=FALSE,MSI_EN=FALSE,MSIX_EN=TRUE,PCIE_EXT_CLK=FALSE,PCIE_EXT_GT_COMMON=FALSE,EXT_CH_GT_DRP=FALSE,CFG_STATUS_IF=TRUE,TX_FC_IF=TRUE,CFG_EXT_IF=TRUE,CFG_FC_IF=TRUE,PER_FUNC_STATUS_IF=TRUE,CFG_MGMT_IF=TRUE,RCV_MSG_IF=TRUE,CFG_TX_MSG_IF=TRUE,CFG_CTL_IF=TRUE,PCIE_DRP=FALSE,TRANSCEIVER_CTRL_STATUS_PORTS=FALSE,AXISTEN_IF_ENABLE_CLIENT_TAG=TRUE,PCIE_USE_MODE=2.1,PCIE_FAST_CONFIG=NONE,EXT_STARTUP_PRIMITIVE=FALSE,EXT_PIPE_INTERFACE=FALSE,AXISTEN_IF_ENABLE_MSG_ROUTE=0x00000,AXISTEN_IF_ENABLE_RX_MSG_INTFC=FALSE,POWER_DOWN=FALSE,DEV_PORT_TYPE=00,ENABLE_JTAG_DBG=FALSE,ENABLE_LTSSM_DBG=FALSE,MULT_PF_DES=TRUE,WIN10_INTEROP=FALSE}" *) (* DowngradeIPIdentifiedWarnings = "yes" *) 
(* X_CORE_INFO = "pcie3_7x_0_pcie_3_0_7vx,Vivado 2024.2" *) 
module pcie3_7x_0(pci_exp_txn, pci_exp_txp, pci_exp_rxn, 
  pci_exp_rxp, int_pclk_out_slave, int_pipe_rxusrclk_out, int_rxoutclk_out, int_dclk_out, 
  int_userclk1_out, int_userclk2_out, int_oobclk_out, int_qplllock_out, int_qplloutclk_out, 
  int_qplloutrefclk_out, int_pclk_sel_slave, mmcm_lock, user_clk, user_reset, user_lnk_up, 
  user_app_rdy, s_axis_rq_tlast, s_axis_rq_tdata, s_axis_rq_tuser, s_axis_rq_tkeep, 
  s_axis_rq_tready, s_axis_rq_tvalid, m_axis_rc_tdata, m_axis_rc_tuser, m_axis_rc_tlast, 
  m_axis_rc_tkeep, m_axis_rc_tvalid, m_axis_rc_tready, m_axis_cq_tdata, m_axis_cq_tuser, 
  m_axis_cq_tlast, m_axis_cq_tkeep, m_axis_cq_tvalid, m_axis_cq_tready, s_axis_cc_tdata, 
  s_axis_cc_tuser, s_axis_cc_tlast, s_axis_cc_tkeep, s_axis_cc_tvalid, s_axis_cc_tready, 
  pcie_rq_seq_num, pcie_rq_seq_num_vld, pcie_rq_tag, pcie_rq_tag_vld, pcie_tfc_nph_av, 
  pcie_tfc_npd_av, pcie_cq_np_req, pcie_cq_np_req_count, cfg_phy_link_down, 
  cfg_phy_link_status, cfg_negotiated_width, cfg_current_speed, cfg_max_payload, 
  cfg_max_read_req, cfg_function_status, cfg_function_power_state, cfg_vf_status, 
  cfg_vf_power_state, cfg_link_power_state, cfg_mgmt_addr, cfg_mgmt_write, 
  cfg_mgmt_write_data, cfg_mgmt_byte_enable, cfg_mgmt_read, cfg_mgmt_read_data, 
  cfg_mgmt_read_write_done, cfg_mgmt_type1_cfg_reg_access, cfg_err_cor_out, 
  cfg_err_nonfatal_out, cfg_err_fatal_out, cfg_ltr_enable, cfg_ltssm_state, cfg_rcb_status, 
  cfg_dpa_substate_change, cfg_obff_enable, cfg_pl_status_change, 
  cfg_tph_requester_enable, cfg_tph_st_mode, cfg_vf_tph_requester_enable, 
  cfg_vf_tph_st_mode, cfg_msg_received, cfg_msg_received_data, cfg_msg_received_type, 
  cfg_msg_transmit, cfg_msg_transmit_type, cfg_msg_transmit_data, cfg_msg_transmit_done, 
  cfg_fc_ph, cfg_fc_pd, cfg_fc_nph, cfg_fc_npd, cfg_fc_cplh, cfg_fc_cpld, cfg_fc_sel, 
  cfg_per_func_status_control, cfg_per_func_status_data, cfg_per_function_number, 
  cfg_per_function_output_request, cfg_per_function_update_done, cfg_subsys_vend_id, 
  cfg_dsn, cfg_power_state_change_ack, cfg_power_state_change_interrupt, cfg_err_cor_in, 
  cfg_err_uncor_in, cfg_flr_in_process, cfg_flr_done, cfg_vf_flr_in_process, 
  cfg_vf_flr_done, cfg_link_training_enable, cfg_interrupt_int, cfg_interrupt_pending, 
  cfg_interrupt_sent, cfg_interrupt_msix_enable, cfg_interrupt_msix_mask, 
  cfg_interrupt_msix_vf_enable, cfg_interrupt_msix_vf_mask, cfg_interrupt_msix_data, 
  cfg_interrupt_msix_address, cfg_interrupt_msix_int, cfg_interrupt_msix_sent, 
  cfg_interrupt_msix_fail, cfg_interrupt_msi_function_number, cfg_hot_reset_out, 
  cfg_config_space_enable, cfg_req_pm_transition_l23_ready, cfg_hot_reset_in, 
  cfg_ds_port_number, cfg_ds_bus_number, cfg_ds_device_number, cfg_ds_function_number, 
  sys_clk, sys_reset)
/* synthesis syn_black_box black_box_pad_pin="pci_exp_txn[7:0],pci_exp_txp[7:0],pci_exp_rxn[7:0],pci_exp_rxp[7:0],int_rxoutclk_out[7:0],int_qplllock_out[1:0],int_qplloutclk_out[1:0],int_qplloutrefclk_out[1:0],int_pclk_sel_slave[7:0],mmcm_lock,user_reset,user_lnk_up,user_app_rdy,s_axis_rq_tlast,s_axis_rq_tdata[255:0],s_axis_rq_tuser[59:0],s_axis_rq_tkeep[7:0],s_axis_rq_tready[3:0],s_axis_rq_tvalid,m_axis_rc_tdata[255:0],m_axis_rc_tuser[74:0],m_axis_rc_tlast,m_axis_rc_tkeep[7:0],m_axis_rc_tvalid,m_axis_rc_tready,m_axis_cq_tdata[255:0],m_axis_cq_tuser[84:0],m_axis_cq_tlast,m_axis_cq_tkeep[7:0],m_axis_cq_tvalid,m_axis_cq_tready,s_axis_cc_tdata[255:0],s_axis_cc_tuser[32:0],s_axis_cc_tlast,s_axis_cc_tkeep[7:0],s_axis_cc_tvalid,s_axis_cc_tready[3:0],pcie_rq_seq_num[3:0],pcie_rq_seq_num_vld,pcie_rq_tag[5:0],pcie_rq_tag_vld,pcie_tfc_nph_av[1:0],pcie_tfc_npd_av[1:0],pcie_cq_np_req,pcie_cq_np_req_count[5:0],cfg_phy_link_down,cfg_phy_link_status[1:0],cfg_negotiated_width[3:0],cfg_current_speed[2:0],cfg_max_payload[2:0],cfg_max_read_req[2:0],cfg_function_status[7:0],cfg_function_power_state[5:0],cfg_vf_status[11:0],cfg_vf_power_state[17:0],cfg_link_power_state[1:0],cfg_mgmt_addr[18:0],cfg_mgmt_write,cfg_mgmt_write_data[31:0],cfg_mgmt_byte_enable[3:0],cfg_mgmt_read,cfg_mgmt_read_data[31:0],cfg_mgmt_read_write_done,cfg_mgmt_type1_cfg_reg_access,cfg_err_cor_out,cfg_err_nonfatal_out,cfg_err_fatal_out,cfg_ltr_enable,cfg_ltssm_state[5:0],cfg_rcb_status[1:0],cfg_dpa_substate_change[1:0],cfg_obff_enable[1:0],cfg_pl_status_change,cfg_tph_requester_enable[1:0],cfg_tph_st_mode[5:0],cfg_vf_tph_requester_enable[5:0],cfg_vf_tph_st_mode[17:0],cfg_msg_received,cfg_msg_received_data[7:0],cfg_msg_received_type[4:0],cfg_msg_transmit,cfg_msg_transmit_type[2:0],cfg_msg_transmit_data[31:0],cfg_msg_transmit_done,cfg_fc_ph[7:0],cfg_fc_pd[11:0],cfg_fc_nph[7:0],cfg_fc_npd[11:0],cfg_fc_cplh[7:0],cfg_fc_cpld[11:0],cfg_fc_sel[2:0],cfg_per_func_status_control[2:0],cfg_per_func_status_data[15:0],cfg_per_function_number[2:0],cfg_per_function_output_request,cfg_per_function_update_done,cfg_subsys_vend_id[15:0],cfg_dsn[63:0],cfg_power_state_change_ack,cfg_power_state_change_interrupt,cfg_err_cor_in,cfg_err_uncor_in,cfg_flr_in_process[1:0],cfg_flr_done[1:0],cfg_vf_flr_in_process[5:0],cfg_vf_flr_done[5:0],cfg_link_training_enable,cfg_interrupt_int[3:0],cfg_interrupt_pending[1:0],cfg_interrupt_sent,cfg_interrupt_msix_enable[1:0],cfg_interrupt_msix_mask[1:0],cfg_interrupt_msix_vf_enable[5:0],cfg_interrupt_msix_vf_mask[5:0],cfg_interrupt_msix_data[31:0],cfg_interrupt_msix_address[63:0],cfg_interrupt_msix_int,cfg_interrupt_msix_sent,cfg_interrupt_msix_fail,cfg_interrupt_msi_function_number[2:0],cfg_hot_reset_out,cfg_config_space_enable,cfg_req_pm_transition_l23_ready,cfg_hot_reset_in,cfg_ds_port_number[7:0],cfg_ds_bus_number[7:0],cfg_ds_device_number[4:0],cfg_ds_function_number[2:0],sys_reset" */
/* synthesis syn_force_seq_prim="int_pclk_out_slave" */
/* synthesis syn_force_seq_prim="int_pipe_rxusrclk_out" */
/* synthesis syn_force_seq_prim="int_dclk_out" */
/* synthesis syn_force_seq_prim="int_userclk1_out" */
/* synthesis syn_force_seq_prim="int_userclk2_out" */
/* synthesis syn_force_seq_prim="int_oobclk_out" */
/* synthesis syn_force_seq_prim="user_clk" */
/* synthesis syn_force_seq_prim="sys_clk" */;
  (* X_INTERFACE_INFO = "xilinx.com:interface:pcie_7x_mgt:1.0 pcie_7x_mgt txn" *) (* X_INTERFACE_MODE = "master" *) output [7:0]pci_exp_txn;
  (* X_INTERFACE_INFO = "xilinx.com:interface:pcie_7x_mgt:1.0 pcie_7x_mgt txp" *) output [7:0]pci_exp_txp;
  (* X_INTERFACE_INFO = "xilinx.com:interface:pcie_7x_mgt:1.0 pcie_7x_mgt rxn" *) input [7:0]pci_exp_rxn;
  (* X_INTERFACE_INFO = "xilinx.com:interface:pcie_7x_mgt:1.0 pcie_7x_mgt rxp" *) input [7:0]pci_exp_rxp;
  (* X_INTERFACE_INFO = "xilinx.com:interface:pcie_sharedlogic_int_clk:1.0 pcie3_sharedlogic_int_clk pclk_slave" *) (* X_INTERFACE_MODE = "master" *) output int_pclk_out_slave /* synthesis syn_isclock = 1 */;
  (* X_INTERFACE_INFO = "xilinx.com:interface:pcie_sharedlogic_int_clk:1.0 pcie3_sharedlogic_int_clk pipe_rxusrclk" *) output int_pipe_rxusrclk_out /* synthesis syn_isclock = 1 */;
  (* X_INTERFACE_INFO = "xilinx.com:interface:pcie_sharedlogic_int_clk:1.0 pcie3_sharedlogic_int_clk rxoutclk" *) output [7:0]int_rxoutclk_out;
  (* X_INTERFACE_INFO = "xilinx.com:interface:pcie_sharedlogic_int_clk:1.0 pcie3_sharedlogic_int_clk dclk" *) output int_dclk_out /* synthesis syn_isclock = 1 */;
  (* X_INTERFACE_INFO = "xilinx.com:interface:pcie_sharedlogic_int_clk:1.0 pcie3_sharedlogic_int_clk usrclk1" *) output int_userclk1_out /* synthesis syn_isclock = 1 */;
  (* X_INTERFACE_INFO = "xilinx.com:interface:pcie_sharedlogic_int_clk:1.0 pcie3_sharedlogic_int_clk usrclk2" *) output int_userclk2_out /* synthesis syn_isclock = 1 */;
  (* X_INTERFACE_INFO = "xilinx.com:interface:pcie_sharedlogic_int_clk:1.0 pcie3_sharedlogic_int_clk oobclk" *) output int_oobclk_out /* synthesis syn_isclock = 1 */;
  (* X_INTERFACE_INFO = "xilinx.com:interface:pcie_sharedlogic_int_clk:1.0 pcie3_sharedlogic_int_clk qplllock" *) output [1:0]int_qplllock_out;
  (* X_INTERFACE_INFO = "xilinx.com:interface:pcie_sharedlogic_int_clk:1.0 pcie3_sharedlogic_int_clk qplloutclk" *) output [1:0]int_qplloutclk_out;
  (* X_INTERFACE_INFO = "xilinx.com:interface:pcie_sharedlogic_int_clk:1.0 pcie3_sharedlogic_int_clk qplloutrefclk" *) output [1:0]int_qplloutrefclk_out;
  (* X_INTERFACE_INFO = "xilinx.com:interface:pcie_sharedlogic_int_clk:1.0 pcie3_sharedlogic_int_clk pclk_sel_slave" *) input [7:0]int_pclk_sel_slave;
  output mmcm_lock;
  (* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 CLK.user_clk CLK" *) (* X_INTERFACE_MODE = "master" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME CLK.user_clk, ASSOCIATED_BUSIF m_axis_cq:s_axis_cc:s_axis_rq:m_axis_rc, FREQ_HZ 125000000, ASSOCIATED_RESET user_reset, FREQ_TOLERANCE_HZ 0, PHASE 0.0, INSERT_VIP 0" *) output user_clk /* synthesis syn_isclock = 1 */;
  (* X_INTERFACE_INFO = "xilinx.com:signal:reset:1.0 RST.user_reset RST" *) (* X_INTERFACE_MODE = "master" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME RST.user_reset, POLARITY ACTIVE_HIGH, INSERT_VIP 0" *) output user_reset;
  output user_lnk_up;
  output user_app_rdy;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 s_axis_rq TLAST" *) (* X_INTERFACE_MODE = "slave" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME s_axis_rq, TDATA_NUM_BYTES 32, TDEST_WIDTH 0, TID_WIDTH 0, TUSER_WIDTH 60, HAS_TREADY 1, HAS_TSTRB 0, HAS_TKEEP 1, HAS_TLAST 1, FREQ_HZ 100000000, PHASE 0.0, LAYERED_METADATA undef, INSERT_VIP 0" *) input s_axis_rq_tlast;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 s_axis_rq TDATA" *) input [255:0]s_axis_rq_tdata;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 s_axis_rq TUSER" *) input [59:0]s_axis_rq_tuser;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 s_axis_rq TKEEP" *) input [7:0]s_axis_rq_tkeep;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 s_axis_rq TREADY" *) output [3:0]s_axis_rq_tready;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 s_axis_rq TVALID" *) input s_axis_rq_tvalid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 m_axis_rc TDATA" *) (* X_INTERFACE_MODE = "master" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME m_axis_rc, TDATA_NUM_BYTES 32, TDEST_WIDTH 0, TID_WIDTH 0, TUSER_WIDTH 75, HAS_TREADY 1, HAS_TSTRB 0, HAS_TKEEP 1, HAS_TLAST 1, FREQ_HZ 100000000, PHASE 0.0, LAYERED_METADATA undef, INSERT_VIP 0" *) output [255:0]m_axis_rc_tdata;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 m_axis_rc TUSER" *) output [74:0]m_axis_rc_tuser;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 m_axis_rc TLAST" *) output m_axis_rc_tlast;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 m_axis_rc TKEEP" *) output [7:0]m_axis_rc_tkeep;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 m_axis_rc TVALID" *) output m_axis_rc_tvalid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 m_axis_rc TREADY" *) input m_axis_rc_tready;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 m_axis_cq TDATA" *) (* X_INTERFACE_MODE = "master" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME m_axis_cq, TDATA_NUM_BYTES 32, TDEST_WIDTH 0, TID_WIDTH 0, TUSER_WIDTH 85, HAS_TREADY 1, HAS_TSTRB 0, HAS_TKEEP 1, HAS_TLAST 1, FREQ_HZ 100000000, PHASE 0.0, LAYERED_METADATA undef, INSERT_VIP 0" *) output [255:0]m_axis_cq_tdata;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 m_axis_cq TUSER" *) output [84:0]m_axis_cq_tuser;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 m_axis_cq TLAST" *) output m_axis_cq_tlast;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 m_axis_cq TKEEP" *) output [7:0]m_axis_cq_tkeep;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 m_axis_cq TVALID" *) output m_axis_cq_tvalid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 m_axis_cq TREADY" *) input m_axis_cq_tready;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 s_axis_cc TDATA" *) (* X_INTERFACE_MODE = "slave" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME s_axis_cc, TDATA_NUM_BYTES 32, TDEST_WIDTH 0, TID_WIDTH 0, TUSER_WIDTH 33, HAS_TREADY 1, HAS_TSTRB 0, HAS_TKEEP 1, HAS_TLAST 1, FREQ_HZ 100000000, PHASE 0.0, LAYERED_METADATA undef, INSERT_VIP 0" *) input [255:0]s_axis_cc_tdata;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 s_axis_cc TUSER" *) input [32:0]s_axis_cc_tuser;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 s_axis_cc TLAST" *) input s_axis_cc_tlast;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 s_axis_cc TKEEP" *) input [7:0]s_axis_cc_tkeep;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 s_axis_cc TVALID" *) input s_axis_cc_tvalid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 s_axis_cc TREADY" *) output [3:0]s_axis_cc_tready;
  (* X_INTERFACE_INFO = "xilinx.com:interface:pcie3_cfg_status:1.0 pcie3_cfg_status rq_seq_num" *) (* X_INTERFACE_MODE = "master" *) output [3:0]pcie_rq_seq_num;
  (* X_INTERFACE_INFO = "xilinx.com:interface:pcie3_cfg_status:1.0 pcie3_cfg_status rq_seq_num_vld" *) output pcie_rq_seq_num_vld;
  (* X_INTERFACE_INFO = "xilinx.com:interface:pcie3_cfg_status:1.0 pcie3_cfg_status rq_tag" *) output [5:0]pcie_rq_tag;
  (* X_INTERFACE_INFO = "xilinx.com:interface:pcie3_cfg_status:1.0 pcie3_cfg_status rq_tag_vld" *) output pcie_rq_tag_vld;
  (* X_INTERFACE_INFO = "xilinx.com:interface:pcie3_transmit_fc:1.0 pcie3_transmit_fc nph_av" *) (* X_INTERFACE_MODE = "master" *) output [1:0]pcie_tfc_nph_av;
  (* X_INTERFACE_INFO = "xilinx.com:interface:pcie3_transmit_fc:1.0 pcie3_transmit_fc npd_av" *) output [1:0]pcie_tfc_npd_av;
  (* X_INTERFACE_INFO = "xilinx.com:interface:pcie3_cfg_status:1.0 pcie3_cfg_status cq_np_req" *) input pcie_cq_np_req;
  (* X_INTERFACE_INFO = "xilinx.com:interface:pcie3_cfg_status:1.0 pcie3_cfg_status cq_np_req_count" *) output [5:0]pcie_cq_np_req_count;
  (* X_INTERFACE_INFO = "xilinx.com:interface:pcie3_cfg_status:1.0 pcie3_cfg_status phy_link_down" *) output cfg_phy_link_down;
  (* X_INTERFACE_INFO = "xilinx.com:interface:pcie3_cfg_status:1.0 pcie3_cfg_status phy_link_status" *) output [1:0]cfg_phy_link_status;
  (* X_INTERFACE_INFO = "xilinx.com:interface:pcie3_cfg_status:1.0 pcie3_cfg_status negotiated_width" *) output [3:0]cfg_negotiated_width;
  (* X_INTERFACE_INFO = "xilinx.com:interface:pcie3_cfg_status:1.0 pcie3_cfg_status current_speed" *) output [2:0]cfg_current_speed;
  (* X_INTERFACE_INFO = "xilinx.com:interface:pcie3_cfg_status:1.0 pcie3_cfg_status max_payload" *) output [2:0]cfg_max_payload;
  (* X_INTERFACE_INFO = "xilinx.com:interface:pcie3_cfg_status:1.0 pcie3_cfg_status max_read_req" *) output [2:0]cfg_max_read_req;
  (* X_INTERFACE_INFO = "xilinx.com:interface:pcie3_cfg_status:1.0 pcie3_cfg_status function_status" *) output [7:0]cfg_function_status;
  (* X_INTERFACE_INFO = "xilinx.com:interface:pcie3_cfg_status:1.0 pcie3_cfg_status function_power_state" *) output [5:0]cfg_function_power_state;
  (* X_INTERFACE_INFO = "xilinx.com:interface:pcie3_cfg_status:1.0 pcie3_cfg_status vf_status" *) output [11:0]cfg_vf_status;
  (* X_INTERFACE_INFO = "xilinx.com:interface:pcie3_cfg_status:1.0 pcie3_cfg_status vf_power_state" *) output [17:0]cfg_vf_power_state;
  (* X_INTERFACE_INFO = "xilinx.com:interface:pcie3_cfg_status:1.0 pcie3_cfg_status link_power_state" *) output [1:0]cfg_link_power_state;
  (* X_INTERFACE_INFO = "xilinx.com:interface:pcie_cfg_mgmt:1.0 pcie_cfg_mgmt ADDR" *) (* X_INTERFACE_MODE = "slave" *) input [18:0]cfg_mgmt_addr;
  (* X_INTERFACE_INFO = "xilinx.com:interface:pcie_cfg_mgmt:1.0 pcie_cfg_mgmt WRITE_EN" *) input cfg_mgmt_write;
  (* X_INTERFACE_INFO = "xilinx.com:interface:pcie_cfg_mgmt:1.0 pcie_cfg_mgmt WRITE_DATA" *) input [31:0]cfg_mgmt_write_data;
  (* X_INTERFACE_INFO = "xilinx.com:interface:pcie_cfg_mgmt:1.0 pcie_cfg_mgmt BYTE_EN" *) input [3:0]cfg_mgmt_byte_enable;
  (* X_INTERFACE_INFO = "xilinx.com:interface:pcie_cfg_mgmt:1.0 pcie_cfg_mgmt READ_EN" *) input cfg_mgmt_read;
  (* X_INTERFACE_INFO = "xilinx.com:interface:pcie_cfg_mgmt:1.0 pcie_cfg_mgmt READ_DATA" *) output [31:0]cfg_mgmt_read_data;
  (* X_INTERFACE_INFO = "xilinx.com:interface:pcie_cfg_mgmt:1.0 pcie_cfg_mgmt READ_WRITE_DONE" *) output cfg_mgmt_read_write_done;
  (* X_INTERFACE_INFO = "xilinx.com:interface:pcie_cfg_mgmt:1.0 pcie_cfg_mgmt TYPE1_CFG_REG_ACCESS" *) input cfg_mgmt_type1_cfg_reg_access;
  (* X_INTERFACE_INFO = "xilinx.com:interface:pcie3_cfg_status:1.0 pcie3_cfg_status err_cor_out" *) output cfg_err_cor_out;
  (* X_INTERFACE_INFO = "xilinx.com:interface:pcie3_cfg_status:1.0 pcie3_cfg_status err_nonfatal_out" *) output cfg_err_nonfatal_out;
  (* X_INTERFACE_INFO = "xilinx.com:interface:pcie3_cfg_status:1.0 pcie3_cfg_status err_fatal_out" *) output cfg_err_fatal_out;
  (* X_INTERFACE_INFO = "xilinx.com:interface:pcie3_cfg_status:1.0 pcie3_cfg_status ltr_enable" *) output cfg_ltr_enable;
  (* X_INTERFACE_INFO = "xilinx.com:interface:pcie3_cfg_status:1.0 pcie3_cfg_status ltssm_state" *) output [5:0]cfg_ltssm_state;
  (* X_INTERFACE_INFO = "xilinx.com:interface:pcie3_cfg_status:1.0 pcie3_cfg_status rcb_status" *) output [1:0]cfg_rcb_status;
  (* X_INTERFACE_INFO = "xilinx.com:interface:pcie3_cfg_status:1.0 pcie3_cfg_status dpa_substate_change" *) output [1:0]cfg_dpa_substate_change;
  (* X_INTERFACE_INFO = "xilinx.com:interface:pcie3_cfg_status:1.0 pcie3_cfg_status obff_enable" *) output [1:0]cfg_obff_enable;
  (* X_INTERFACE_INFO = "xilinx.com:interface:pcie3_cfg_status:1.0 pcie3_cfg_status pl_status_change" *) output cfg_pl_status_change;
  (* X_INTERFACE_INFO = "xilinx.com:interface:pcie3_cfg_status:1.0 pcie3_cfg_status tph_requester_enable" *) output [1:0]cfg_tph_requester_enable;
  (* X_INTERFACE_INFO = "xilinx.com:interface:pcie3_cfg_status:1.0 pcie3_cfg_status tph_st_mode" *) output [5:0]cfg_tph_st_mode;
  (* X_INTERFACE_INFO = "xilinx.com:interface:pcie3_cfg_status:1.0 pcie3_cfg_status vf_tph_requester_enable" *) output [5:0]cfg_vf_tph_requester_enable;
  (* X_INTERFACE_INFO = "xilinx.com:interface:pcie3_cfg_status:1.0 pcie3_cfg_status vf_tph_st_mode" *) output [17:0]cfg_vf_tph_st_mode;
  (* X_INTERFACE_INFO = "xilinx.com:interface:pcie3_cfg_msg_received:1.0 pcie3_cfg_mesg_rcvd recd" *) (* X_INTERFACE_MODE = "master" *) output cfg_msg_received;
  (* X_INTERFACE_INFO = "xilinx.com:interface:pcie3_cfg_msg_received:1.0 pcie3_cfg_mesg_rcvd recd_data" *) output [7:0]cfg_msg_received_data;
  (* X_INTERFACE_INFO = "xilinx.com:interface:pcie3_cfg_msg_received:1.0 pcie3_cfg_mesg_rcvd recd_type" *) output [4:0]cfg_msg_received_type;
  (* X_INTERFACE_INFO = "xilinx.com:interface:pcie3_cfg_mesg_tx:1.0 pcie3_cfg_mesg_tx TRANSMIT" *) (* X_INTERFACE_MODE = "master" *) input cfg_msg_transmit;
  (* X_INTERFACE_INFO = "xilinx.com:interface:pcie3_cfg_mesg_tx:1.0 pcie3_cfg_mesg_tx TRANSMIT_TYPE" *) input [2:0]cfg_msg_transmit_type;
  (* X_INTERFACE_INFO = "xilinx.com:interface:pcie3_cfg_mesg_tx:1.0 pcie3_cfg_mesg_tx TRANSMIT_DATA" *) input [31:0]cfg_msg_transmit_data;
  (* X_INTERFACE_INFO = "xilinx.com:interface:pcie3_cfg_mesg_tx:1.0 pcie3_cfg_mesg_tx TRANSMIT_DONE" *) output cfg_msg_transmit_done;
  (* X_INTERFACE_INFO = "xilinx.com:interface:pcie_cfg_fc:1.0 pcie_cfg_fc PH" *) (* X_INTERFACE_MODE = "master" *) output [7:0]cfg_fc_ph;
  (* X_INTERFACE_INFO = "xilinx.com:interface:pcie_cfg_fc:1.0 pcie_cfg_fc PD" *) output [11:0]cfg_fc_pd;
  (* X_INTERFACE_INFO = "xilinx.com:interface:pcie_cfg_fc:1.0 pcie_cfg_fc NPH" *) output [7:0]cfg_fc_nph;
  (* X_INTERFACE_INFO = "xilinx.com:interface:pcie_cfg_fc:1.0 pcie_cfg_fc NPD" *) output [11:0]cfg_fc_npd;
  (* X_INTERFACE_INFO = "xilinx.com:interface:pcie_cfg_fc:1.0 pcie_cfg_fc CPLH" *) output [7:0]cfg_fc_cplh;
  (* X_INTERFACE_INFO = "xilinx.com:interface:pcie_cfg_fc:1.0 pcie_cfg_fc CPLD" *) output [11:0]cfg_fc_cpld;
  (* X_INTERFACE_INFO = "xilinx.com:interface:pcie_cfg_fc:1.0 pcie_cfg_fc SEL" *) input [2:0]cfg_fc_sel;
  (* X_INTERFACE_INFO = "xilinx.com:interface:pcie3_per_func_status:1.0 pcie3_per_func_status STATUS_CONTROL" *) (* X_INTERFACE_MODE = "master" *) input [2:0]cfg_per_func_status_control;
  (* X_INTERFACE_INFO = "xilinx.com:interface:pcie3_per_func_status:1.0 pcie3_per_func_status STATUS_DATA" *) output [15:0]cfg_per_func_status_data;
  (* X_INTERFACE_INFO = "xilinx.com:interface:pcie3_cfg_control:1.0 pcie3_cfg_control per_function_number" *) (* X_INTERFACE_MODE = "slave" *) input [2:0]cfg_per_function_number;
  (* X_INTERFACE_INFO = "xilinx.com:interface:pcie3_cfg_control:1.0 pcie3_cfg_control per_function_output_request" *) input cfg_per_function_output_request;
  (* X_INTERFACE_INFO = "xilinx.com:interface:pcie3_cfg_control:1.0 pcie3_cfg_control per_function_update_done" *) output cfg_per_function_update_done;
  (* X_INTERFACE_INFO = "xilinx.com:interface:pcie3_cfg_control:1.0 pcie3_cfg_control subsys_vend_id" *) input [15:0]cfg_subsys_vend_id;
  (* X_INTERFACE_INFO = "xilinx.com:interface:pcie3_cfg_control:1.0 pcie3_cfg_control dsn" *) input [63:0]cfg_dsn;
  (* X_INTERFACE_INFO = "xilinx.com:interface:pcie3_cfg_control:1.0 pcie3_cfg_control power_state_change_ack" *) input cfg_power_state_change_ack;
  (* X_INTERFACE_INFO = "xilinx.com:interface:pcie3_cfg_control:1.0 pcie3_cfg_control power_state_change_interrupt" *) output cfg_power_state_change_interrupt;
  (* X_INTERFACE_INFO = "xilinx.com:interface:pcie3_cfg_control:1.0 pcie3_cfg_control err_cor_in" *) input cfg_err_cor_in;
  (* X_INTERFACE_INFO = "xilinx.com:interface:pcie3_cfg_control:1.0 pcie3_cfg_control err_uncor_in" *) input cfg_err_uncor_in;
  (* X_INTERFACE_INFO = "xilinx.com:interface:pcie3_cfg_control:1.0 pcie3_cfg_control flr_in_process" *) output [1:0]cfg_flr_in_process;
  (* X_INTERFACE_INFO = "xilinx.com:interface:pcie3_cfg_control:1.0 pcie3_cfg_control flr_done" *) input [1:0]cfg_flr_done;
  (* X_INTERFACE_INFO = "xilinx.com:interface:pcie3_cfg_control:1.0 pcie3_cfg_control vf_flr_in_process" *) output [5:0]cfg_vf_flr_in_process;
  (* X_INTERFACE_INFO = "xilinx.com:interface:pcie3_cfg_control:1.0 pcie3_cfg_control vf_flr_done" *) input [5:0]cfg_vf_flr_done;
  (* X_INTERFACE_INFO = "xilinx.com:interface:pcie3_cfg_control:1.0 pcie3_cfg_control link_training_enable" *) input cfg_link_training_enable;
  (* X_INTERFACE_INFO = "xilinx.com:interface:pcie3_cfg_interrupt:1.0 pcie3_cfg_interrupt INTx_VECTOR" *) (* X_INTERFACE_MODE = "slave" *) input [3:0]cfg_interrupt_int;
  (* X_INTERFACE_INFO = "xilinx.com:interface:pcie3_cfg_interrupt:1.0 pcie3_cfg_interrupt PENDING" *) input [1:0]cfg_interrupt_pending;
  (* X_INTERFACE_INFO = "xilinx.com:interface:pcie3_cfg_interrupt:1.0 pcie3_cfg_interrupt SENT" *) output cfg_interrupt_sent;
  (* X_INTERFACE_INFO = "xilinx.com:interface:pcie3_cfg_msix:1.0 pcie3_cfg_msix enable" *) (* X_INTERFACE_MODE = "slave" *) output [1:0]cfg_interrupt_msix_enable;
  (* X_INTERFACE_INFO = "xilinx.com:interface:pcie3_cfg_msix:1.0 pcie3_cfg_msix mask" *) output [1:0]cfg_interrupt_msix_mask;
  (* X_INTERFACE_INFO = "xilinx.com:interface:pcie3_cfg_msix:1.0 pcie3_cfg_msix vf_enable" *) output [5:0]cfg_interrupt_msix_vf_enable;
  (* X_INTERFACE_INFO = "xilinx.com:interface:pcie3_cfg_msix:1.0 pcie3_cfg_msix vf_mask" *) output [5:0]cfg_interrupt_msix_vf_mask;
  (* X_INTERFACE_INFO = "xilinx.com:interface:pcie3_cfg_msix:1.0 pcie3_cfg_msix data" *) input [31:0]cfg_interrupt_msix_data;
  (* X_INTERFACE_INFO = "xilinx.com:interface:pcie3_cfg_msix:1.0 pcie3_cfg_msix address" *) input [63:0]cfg_interrupt_msix_address;
  (* X_INTERFACE_INFO = "xilinx.com:interface:pcie3_cfg_msix:1.0 pcie3_cfg_msix int_vector" *) input cfg_interrupt_msix_int;
  (* X_INTERFACE_INFO = "xilinx.com:interface:pcie3_cfg_msix:1.0 pcie3_cfg_msix sent" *) output cfg_interrupt_msix_sent;
  (* X_INTERFACE_INFO = "xilinx.com:interface:pcie3_cfg_msix:1.0 pcie3_cfg_msix fail" *) output cfg_interrupt_msix_fail;
  input [2:0]cfg_interrupt_msi_function_number;
  (* X_INTERFACE_INFO = "xilinx.com:interface:pcie3_cfg_control:1.0 pcie3_cfg_control hot_reset_out" *) output cfg_hot_reset_out;
  (* X_INTERFACE_INFO = "xilinx.com:interface:pcie3_cfg_control:1.0 pcie3_cfg_control config_space_enable" *) input cfg_config_space_enable;
  (* X_INTERFACE_INFO = "xilinx.com:interface:pcie3_cfg_control:1.0 pcie3_cfg_control req_pm_transition_l23_ready" *) input cfg_req_pm_transition_l23_ready;
  (* X_INTERFACE_INFO = "xilinx.com:interface:pcie3_cfg_control:1.0 pcie3_cfg_control hot_reset_in" *) input cfg_hot_reset_in;
  (* X_INTERFACE_INFO = "xilinx.com:interface:pcie3_cfg_control:1.0 pcie3_cfg_control ds_port_number" *) input [7:0]cfg_ds_port_number;
  (* X_INTERFACE_INFO = "xilinx.com:interface:pcie3_cfg_control:1.0 pcie3_cfg_control ds_bus_number" *) input [7:0]cfg_ds_bus_number;
  (* X_INTERFACE_INFO = "xilinx.com:interface:pcie3_cfg_control:1.0 pcie3_cfg_control ds_device_number" *) input [4:0]cfg_ds_device_number;
  (* X_INTERFACE_INFO = "xilinx.com:interface:pcie3_cfg_control:1.0 pcie3_cfg_control ds_function_number" *) input [2:0]cfg_ds_function_number;
  (* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 CLK.sys_clk CLK" *) (* X_INTERFACE_MODE = "slave" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME CLK.sys_clk, FREQ_HZ 100000000, FREQ_TOLERANCE_HZ 0, PHASE 0.0, INSERT_VIP 0" *) input sys_clk /* synthesis syn_isclock = 1 */;
  (* X_INTERFACE_INFO = "xilinx.com:signal:reset:1.0 RST.sys_rst RST" *) (* X_INTERFACE_MODE = "slave" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME RST.sys_rst, POLARITY ACTIVE_HIGH, INSERT_VIP 0" *) input sys_reset;
endmodule

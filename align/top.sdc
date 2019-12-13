# (C) 1992-2017 Intel Corporation.                            
# Intel, the Intel logo, Intel, MegaCore, NIOS II, Quartus and TalkBack words    
# and logos are trademarks of Intel Corporation or its subsidiaries in the U.S.  
# and/or other countries. Other marks and brands may be claimed as the property  
# of others. See Trademarks on intel.com for full list of Intel trademarks or    
# the Trademarks & Brands Names Database (if Intel) or See www.Intel.com/legal (if Altera) 
# Your use of Intel Corporation's design tools, logic functions and other        
# software and tools, and its AMPP partner logic functions, and any output       
# files any of the foregoing (including device programming or simulation         
# files), and any associated documentation or information are expressly subject  
# to the terms and conditions of the Altera Program License Subscription         
# Agreement, Intel MegaCore Function License Agreement, or other applicable      
# license agreement, including, without limitation, that your use is for the     
# sole purpose of programming logic devices manufactured by Intel and sold by    
# Intel or its authorized distributors.  Please refer to the applicable          
# agreement for further details.                                                 


#**************************************************************
# Create Clock
#**************************************************************
create_clock -name EMIF_REF_CLOCK -period 7.5 [get_ports emif_ref_clk]

create_clock -period "100 MHz"   -name {fpga_clk_100} {fpga_clk_100}
create_clock -period "100 MHz"   -name {clk_fpga_b2_p} {clk_fpga_b2_p}
create_clock -period "148.5 MHz" -name {refclk_sdi_p} {refclk_sdi_p}
create_clock -period "270 MHz"   -name {refclk_dp_p} {refclk_dp_p}
create_clock -period "125 MHz"   -name {clk_enet_fpga_p} {clk_enet_fpga_p}

# for enhancing USB BlasterII to be reliable, 25MHz
create_clock -name {altera_reserved_tck} -period 40 {altera_reserved_tck}
set_input_delay  -clock altera_reserved_tck -clock_fall 3 [get_ports altera_reserved_tdi]
set_input_delay  -clock altera_reserved_tck -clock_fall 3 [get_ports altera_reserved_tms]
set_output_delay -clock altera_reserved_tck -clock_fall 3 [get_ports altera_reserved_tdo]

# for I2C
create_clock -name {i2c_scl} -period 300 {i2c_scl}

#**************************************************************
# Create Generated Clock
#**************************************************************
derive_pll_clocks

#**************************************************************
# Set Clock Uncertainty
#**************************************************************
derive_clock_uncertainty

#**************************************************************
# Set Asynchronous Clocks
#**************************************************************
set_clock_groups -asynchronous \
-group { \
   fpga_clk_100 \
} -group { \
   altera_ts_clk \
}

#**************************************************************
# Set False Path
#**************************************************************
# FPGA IO port constraints
set_false_path -from [get_ports {fpga_button_pio[0]}] -to *
set_false_path -from [get_ports {fpga_button_pio[1]}] -to *
set_false_path -from [get_ports {fpga_dipsw_pio[0]}] -to *
set_false_path -from [get_ports {fpga_dipsw_pio[1]}] -to *
set_false_path -from [get_ports {fpga_dipsw_pio[2]}] -to *
set_false_path -from [get_ports {fpga_dipsw_pio[3]}] -to *
set_false_path -from * -to [get_ports {fpga_led_pio[0]}]
set_false_path -from * -to [get_ports {fpga_led_pio[1]}]
set_false_path -from * -to [get_ports {fpga_led_pio[2]}]
set_false_path -from * -to [get_ports {fpga_led_pio[3]}]

# HPS peripherals port false path setting to workaround the unconstraint path (setting false_path for hps_0 ports will not affect the routing as it is hard silicon)
set_false_path -from * -to [get_ports {hps_emac1_TX_CLK}] 
set_false_path -from * -to [get_ports {hps_emac1_TXD0}] 
set_false_path -from * -to [get_ports {hps_emac1_TXD1}] 
set_false_path -from * -to [get_ports {hps_emac1_TXD2}] 
set_false_path -from * -to [get_ports {hps_emac1_TXD3}] 
set_false_path -from * -to [get_ports {hps_emac1_MDC}] 
set_false_path -from * -to [get_ports {hps_emac1_TX_CTL}] 
set_false_path -from * -to [get_ports {hps_qspi_SS0}] 
set_false_path -from * -to [get_ports {hps_qspi_CLK}] 
set_false_path -from * -to [get_ports {hps_sdio_CLK}] 
set_false_path -from * -to [get_ports {hps_usb1_STP}] 
set_false_path -from * -to [get_ports {hps_spim0_CLK}] 
set_false_path -from * -to [get_ports {hps_spim0_MOSI}] 
set_false_path -from * -to [get_ports {hps_spim0_SS0}] 
set_false_path -from * -to [get_ports {hps_uart0_TX}] 
set_false_path -from * -to [get_ports {hps_can0_TX}] 
set_false_path -from * -to [get_ports {hps_trace_CLK}] 
set_false_path -from * -to [get_ports {hps_trace_D0}] 
set_false_path -from * -to [get_ports {hps_trace_D1}] 
set_false_path -from * -to [get_ports {hps_trace_D2}] 
set_false_path -from * -to [get_ports {hps_trace_D3}] 
set_false_path -from * -to [get_ports {hps_trace_D4}] 
set_false_path -from * -to [get_ports {hps_trace_D5}] 
set_false_path -from * -to [get_ports {hps_trace_D6}] 
set_false_path -from * -to [get_ports {hps_trace_D7}] 

set_false_path -from * -to [get_ports {hps_emac1_MDIO}] 
set_false_path -from * -to [get_ports {hps_qspi_IO0}] 
set_false_path -from * -to [get_ports {hps_qspi_IO1}] 
set_false_path -from * -to [get_ports {hps_qspi_IO2}] 
set_false_path -from * -to [get_ports {hps_qspi_IO3}] 
set_false_path -from * -to [get_ports {hps_sdio_CMD}] 
set_false_path -from * -to [get_ports {hps_sdio_D0}] 
set_false_path -from * -to [get_ports {hps_sdio_D1}] 
set_false_path -from * -to [get_ports {hps_sdio_D2}] 
set_false_path -from * -to [get_ports {hps_sdio_D3}] 
set_false_path -from * -to [get_ports {hps_usb1_D0}] 
set_false_path -from * -to [get_ports {hps_usb1_D1}] 
set_false_path -from * -to [get_ports {hps_usb1_D2}] 
set_false_path -from * -to [get_ports {hps_usb1_D3}] 
set_false_path -from * -to [get_ports {hps_usb1_D4}] 
set_false_path -from * -to [get_ports {hps_usb1_D5}] 
set_false_path -from * -to [get_ports {hps_usb1_D6}] 
set_false_path -from * -to [get_ports {hps_usb1_D7}] 
set_false_path -from * -to [get_ports {hps_i2c0_SDA}] 
set_false_path -from * -to [get_ports {hps_i2c0_SCL}] 
set_false_path -from * -to [get_ports {hps_gpio_GPIO09}] 
set_false_path -from * -to [get_ports {hps_gpio_GPIO35}] 
set_false_path -from * -to [get_ports {hps_gpio_GPIO41}] 
set_false_path -from * -to [get_ports {hps_gpio_GPIO42}] 
set_false_path -from * -to [get_ports {hps_gpio_GPIO43}] 
set_false_path -from * -to [get_ports {hps_gpio_GPIO44}] 

set_false_path -from [get_ports {hps_emac1_MDIO}] -to *
set_false_path -from [get_ports {hps_qspi_IO0}] -to *
set_false_path -from [get_ports {hps_qspi_IO1}] -to *
set_false_path -from [get_ports {hps_qspi_IO2}] -to *
set_false_path -from [get_ports {hps_qspi_IO3}] -to *
set_false_path -from [get_ports {hps_sdio_CMD}] -to *
set_false_path -from [get_ports {hps_sdio_D0}] -to *
set_false_path -from [get_ports {hps_sdio_D1}] -to *
set_false_path -from [get_ports {hps_sdio_D2}] -to *
set_false_path -from [get_ports {hps_sdio_D3}] -to *
set_false_path -from [get_ports {hps_usb1_D0}] -to *
set_false_path -from [get_ports {hps_usb1_D1}] -to *
set_false_path -from [get_ports {hps_usb1_D2}] -to *
set_false_path -from [get_ports {hps_usb1_D3}] -to *
set_false_path -from [get_ports {hps_usb1_D4}] -to *
set_false_path -from [get_ports {hps_usb1_D5}] -to *
set_false_path -from [get_ports {hps_usb1_D6}] -to *
set_false_path -from [get_ports {hps_usb1_D7}] -to *
set_false_path -from [get_ports {hps_i2c0_SDA}] -to *
set_false_path -from [get_ports {hps_i2c0_SCL}] -to *
set_false_path -from [get_ports {hps_gpio_GPIO09}] -to *
set_false_path -from [get_ports {hps_gpio_GPIO35}] -to *
set_false_path -from [get_ports {hps_gpio_GPIO41}] -to *
set_false_path -from [get_ports {hps_gpio_GPIO42}] -to *
set_false_path -from [get_ports {hps_gpio_GPIO43}] -to *
set_false_path -from [get_ports {hps_gpio_GPIO44}] -to *

set_false_path -from [get_ports {hps_usb1_CLK}] -to *
set_false_path -from [get_ports {hps_usb1_DIR}] -to *
set_false_path -from [get_ports {hps_usb1_NXT}] -to *
set_false_path -from [get_ports {hps_spim0_MISO}] -to *
set_false_path -from [get_ports {hps_uart0_RX}] -to *
set_false_path -from [get_ports {hps_can0_RX}] -to *

set_false_path -from [get_ports {emac_mdio}] -to *
set_false_path -from [get_ports {emac_rx_clk}] -to *
set_false_path -from [get_ports {emac_rx_ctl}] -to *
set_false_path -from [get_ports {emac_rxd[0]}] -to *
set_false_path -from [get_ports {emac_rxd[1]}] -to *
set_false_path -from [get_ports {emac_rxd[2]}] -to *
set_false_path -from [get_ports {emac_rxd[3]}] -to *
set_false_path -from [get_ports {i2c_sda}] -to *
set_false_path -from [get_ports {led[0]}] -to *
set_false_path -from [get_ports {led[1]}] -to *
set_false_path -from [get_ports {led[2]}] -to *
set_false_path -from [get_ports {led[3]}] -to *
set_false_path -from [get_ports {sd_cmd}] -to *
set_false_path -from [get_ports {sd_d[0]}] -to *
set_false_path -from [get_ports {sd_d[1]}] -to *
set_false_path -from [get_ports {sd_d[2]}] -to *
set_false_path -from [get_ports {sd_d[3]}] -to *
set_false_path -from [get_ports {uart_rx}] -to *

set_false_path -from * -to [get_ports {emac_mdc}] 
set_false_path -from * -to [get_ports {emac_mdio}]
set_false_path -from * -to [get_ports {emac_tx_clk}]
set_false_path -from * -to [get_ports {emac_tx_ctl}]
set_false_path -from * -to [get_ports {emac_txd[0]}]
set_false_path -from * -to [get_ports {emac_txd[1]}]
set_false_path -from * -to [get_ports {emac_txd[2]}]
set_false_path -from * -to [get_ports {emac_txd[3]}]
set_false_path -from * -to [get_ports {led[0]}]
set_false_path -from * -to [get_ports {led[1]}]
set_false_path -from * -to [get_ports {led[2]}]
set_false_path -from * -to [get_ports {led[3]}]
set_false_path -from * -to [get_ports {sd_clk}]
set_false_path -from * -to [get_ports {sd_cmd}]
set_false_path -from * -to [get_ports {sd_d[0]}]
set_false_path -from * -to [get_ports {sd_d[1]}]
set_false_path -from * -to [get_ports {sd_d[2]}]
set_false_path -from * -to [get_ports {sd_d[3]}]
set_false_path -from * -to [get_ports {uart_tx}]

# Qsys will synchronize the reset input
set_false_path -from [get_ports fpga_reset_n] -to *

# LED switching will be slow
set_false_path -from * -to [get_ports fpga_led_output[*]]

# Cut path to freeze signal - this signal is asynchronous
set_false_path -from board_inst|alt_pr|alt_pr_cb_host|alt_pr_cb_controller_v2|freeze_reg -to *

# Make the kernel reset multicycle
set_multicycle_path -to * -setup 4 -from {board_inst|kernel_interface|reset_controller_sw|alt_rst_sync_uq1|altera_reset_synchronizer_int_chain_out}
set_multicycle_path -to * -hold 3 -from {board_inst|kernel_interface|reset_controller_sw|alt_rst_sync_uq1|altera_reset_synchronizer_int_chain_out}
set_multicycle_path -to * -setup 4 -from {freeze_wrapper_inst|kernel_system_clock_reset_reset_reset_n}
set_multicycle_path -to * -hold 3 -from {freeze_wrapper_inst|kernel_system_clock_reset_reset_reset_n}

# Cut path to twoXclock_consumer (this instance is only there to keep 
# kernel interface consistent and prevents kernel_clk2x to be swept away by synthesis)
set_false_path -from * -to freeze_wrapper_inst|kernel_system_inst|*|twoXclock_consumer_NO_SHIFT_REG

# Other
set_false_path -from [get_clocks {fpga_clk_100}] -to [get_clocks {board_inst|emif_a10_hps_phy_clk_0}]
set_false_path -from [get_clocks {fpga_clk_100}] -to [get_clocks {board_inst|emif_a10_hps_phy_clk_1}]

#set_false_path -from {dcnt[10]} -to {board_inst|emif_a10_hps|arch|arch_inst|altera_emif_arch_nf_top:arch_inst|altera_emif_arch_nf_io_tiles:io_tiles_inst|tile_gen[1].lane_gen[3].l1.lane_inst~phy_reg0}
#set_false_path -from {dcnt[10]} -to {board_inst|emif_a10_hps|arch|arch_inst|altera_emif_arch_nf_top:arch_inst|altera_emif_arch_nf_io_tiles:io_tiles_inst|tile_gen[1].lane_gen[0].l1.lane_inst~phy_reg0} 
#set_false_path -from {dcnt[10]} -to {board_inst|emif_a10_hps|arch|arch_inst|altera_emif_arch_nf_top:arch_inst|altera_emif_arch_nf_io_tiles:io_tiles_inst|tile_gen[0].lane_gen[2].l1.lane_inst~phy_reg0} 
#set_false_path -from {dcnt[10]} -to {board_inst|emif_a10_hps|arch|arch_inst|altera_emif_arch_nf_top:arch_inst|altera_emif_arch_nf_io_tiles:io_tiles_inst|tile_gen[0].lane_gen[1].l1.lane_inst~phy_reg0} 
#set_false_path -from {dcnt[10]} -to {board_inst|emif_a10_hps|arch|arch_inst|altera_emif_arch_nf_top:arch_inst|altera_emif_arch_nf_io_tiles:io_tiles_inst|tile_gen[1].lane_gen[1].l1.lane_inst~phy_reg0} 
#set_false_path -from {dcnt[10]} -to {board_inst|emif_a10_hps|arch|arch_inst|altera_emif_arch_nf_top:arch_inst|altera_emif_arch_nf_io_tiles:io_tiles_inst|tile_gen[0].lane_gen[0].l1.lane_inst~phy_reg0} 
#set_false_path -from {dcnt[10]} -to {board_inst|emif_a10_hps|arch|arch_inst|altera_emif_arch_nf_top:arch_inst|altera_emif_arch_nf_io_tiles:io_tiles_inst|tile_gen[0].tile_ctrl_inst~hmc_reg0} 
#set_false_path -from {dcnt[10]} -to {board_inst|emif_a10_hps|arch|arch_inst|altera_emif_arch_nf_top:arch_inst|altera_emif_arch_nf_io_tiles:io_tiles_inst|tile_gen[1].lane_gen[2].l1.lane_inst~phy_reg0} 
#set_false_path -from {dcnt[10]} -to {board_inst|emif_a10_hps|arch|arch_inst|altera_emif_arch_nf_top:arch_inst|altera_emif_arch_nf_io_tiles:io_tiles_inst|tile_gen[0].tile_ctrl_inst~_Duplicatehmc_reg0}

set_false_path -from [get_clocks {board_inst|xcvr_fpll_a10|outclk0}] -to [get_clocks {u_sdi_ii_ed|ch1_tx_native_phy|xcvr_native_a10_0|tx_clkout}]

# Relax Kernel constraints - only do this during base revision compiles
if {! [string equal $::TimeQuestInfo(nameofexecutable) "quartus_map"]} {
  # Case 196028 can't call get_current_revision in parallel map
  if { [get_current_revision] eq "base" } {
    post_message -type critical_warning "Compiling with slowed OpenCL Kernel clock.  This is to help achieve timing closure for board bringup."
    if {! [string equal $::TimeQuestInfo(nameofexecutable) "quartus_sta"]} {
      set kernel_keepers [get_keepers freeze_wrapper_inst\|kernel_system_inst\|*] 
      set_max_delay 5 -from $kernel_keepers -to $kernel_keepers
    }
  }
}
set_false_path -from {board_inst|alt_pr|alt_pr|alt_pr_cb_host|alt_pr_cb_controller_v2|freeze_reg*} -to {freeze_wrapper_inst|freeze_kernel_clk[0]}

set_false_path -from {dcnt[10]} -to {board_inst|emif_a10_hps|emif_a10_hps|arch|arch_inst|io_tiles_wrap_inst|io_tiles_inst|tile_gen[0].lane_gen[1].lane_inst~phy_reg0}
set_false_path -from {dcnt[10]} -to {board_inst|emif_a10_hps|emif_a10_hps|arch|arch_inst|io_tiles_wrap_inst|io_tiles_inst|tile_gen[0].lane_gen[2].lane_inst~phy_reg0}
set_false_path -from {dcnt[10]} -to {board_inst|emif_a10_hps|emif_a10_hps|arch|arch_inst|io_tiles_wrap_inst|io_tiles_inst|tile_gen[0].lane_gen[0].lane_inst~phy_reg0}
set_false_path -from {dcnt[10]} -to {board_inst|emif_a10_hps|emif_a10_hps|arch|arch_inst|io_tiles_wrap_inst|io_tiles_inst|tile_gen[0].tile_ctrl_inst~hmc_reg0}
set_false_path -from {dcnt[10]} -to {board_inst|emif_a10_hps|emif_a10_hps|arch|arch_inst|io_tiles_wrap_inst|io_tiles_inst|tile_gen[1].lane_gen[2].lane_inst~phy_reg0}
set_false_path -from {dcnt[10]} -to {board_inst|emif_a10_hps|emif_a10_hps|arch|arch_inst|io_tiles_wrap_inst|io_tiles_inst|tile_gen[1].lane_gen[3].lane_inst~phy_reg0}
set_false_path -from {dcnt[10]} -to {board_inst|emif_a10_hps|emif_a10_hps|arch|arch_inst|io_tiles_wrap_inst|io_tiles_inst|tile_gen[1].lane_gen[1].lane_inst~phy_reg0}
set_false_path -from {dcnt[10]} -to {board_inst|emif_a10_hps|emif_a10_hps|arch|arch_inst|io_tiles_wrap_inst|io_tiles_inst|tile_gen[1].lane_gen[0].lane_inst~phy_reg0}
set_false_path -from {dcnt[10]} -to {board_inst|emif_a10_hps|emif_a10_hps|arch|arch_inst|io_tiles_wrap_inst|io_tiles_inst|tile_gen[0].tile_ctrl_inst~_Duplicate~hmc_reg0}

// (C) 1992-2017 Intel Corporation.                            
// Intel, the Intel logo, Intel, MegaCore, NIOS II, Quartus and TalkBack words    
// and logos are trademarks of Intel Corporation or its subsidiaries in the U.S.  
// and/or other countries. Other marks and brands may be claimed as the property  
// of others. See Trademarks on intel.com for full list of Intel trademarks or    
// the Trademarks & Brands Names Database (if Intel) or See www.Intel.com/legal (if Altera) 
// Your use of Intel Corporation's design tools, logic functions and other        
// software and tools, and its AMPP partner logic functions, and any output       
// files any of the foregoing (including device programming or simulation         
// files), and any associated documentation or information are expressly subject  
// to the terms and conditions of the Altera Program License Subscription         
// Agreement, Intel MegaCore Function License Agreement, or other applicable      
// license agreement, including, without limitation, that your use is for the     
// sole purpose of programming logic devices manufactured by Intel and sold by    
// Intel or its authorized distributors.  Please refer to the applicable          
// agreement for further details.                                                 


module top (
  // FPGA clock and reset
  input  wire          fpga_clk_100,
  input  wire          fpga_reset_n,

  input  wire          clk_fpga_b2_p,	// 100 MHz clock
  input  wire          clk_enet_fpga_p, // another 120MHz clock
  input  wire	       refclk_dp_p,	// SDI Simplex Reference Clock 270MHz 

  // HPS peripherals
  output wire          hps_emac0_TX_CLK,   
  output wire          hps_emac0_TXD0,     
  output wire          hps_emac0_TXD1,     
  output wire          hps_emac0_TXD2,     
  output wire          hps_emac0_TXD3,     
  input  wire          hps_emac0_RXD0,     
  inout  wire          hps_emac0_MDIO,     
  output wire          hps_emac0_MDC,      
  input  wire          hps_emac0_RX_CTL,   
  output wire          hps_emac0_TX_CTL,   
  input  wire          hps_emac0_RX_CLK,   
  input  wire          hps_emac0_RXD1,     
  input  wire          hps_emac0_RXD2,     
  input  wire          hps_emac0_RXD3, 
  inout  wire          hps_usb0_D0,        
  inout  wire          hps_usb0_D1,        
  inout  wire          hps_usb0_D2,        
  inout  wire          hps_usb0_D3,        
  inout  wire          hps_usb0_D4,        
  inout  wire          hps_usb0_D5,        
  inout  wire          hps_usb0_D6,        
  inout  wire          hps_usb0_D7,        
  input  wire          hps_usb0_CLK,       
  output wire          hps_usb0_STP,       
  input  wire          hps_usb0_DIR,       
  input  wire          hps_usb0_NXT,   
  output wire          hps_spim1_CLK,
  output wire          hps_spim1_MOSI,
  input  wire          hps_spim1_MISO,
  output wire          hps_spim1_SS0_N,
  output wire          hps_spim1_SS1_N,
  input  wire          hps_uart1_RX,       
  output wire          hps_uart1_TX,       
  inout  wire          hps_i2c1_SDA,       
  inout  wire          hps_i2c1_SCL,       
  inout  wire          hps_sdio_CMD,
  output wire          hps_sdio_CLK,
  inout  wire          hps_sdio_D0,
  inout  wire          hps_sdio_D1,
  inout  wire          hps_sdio_D2,
  inout  wire          hps_sdio_D3,
  inout  wire          hps_sdio_D4,
  inout  wire          hps_sdio_D5,
  inout  wire          hps_sdio_D6,
  inout  wire          hps_sdio_D7,
  output wire          hps_sdio_PWR_ENA,  
  inout  wire          hps_gpio_GPIO14,    
  inout  wire          hps_gpio_GPIO16,    
  inout  wire          hps_gpio_GPIO17, 
  inout  wire          hps_gpio_GPIO05,

  // HPS memory controller ports
  output wire          hps_memory_mem_act_n,
  output wire          hps_memory_mem_bg,
  output wire          hps_memory_mem_par,
  input  wire          hps_memory_mem_alert_n,
  inout  wire [3:0]    hps_memory_mem_dbi_n,
  output wire [16:0]   hps_memory_mem_a,                           
  output wire [1:0]    hps_memory_mem_ba,
  output wire          hps_memory_mem_ck,                          
  output wire          hps_memory_mem_ck_n,                        
  output wire          hps_memory_mem_cke,                         
  output wire          hps_memory_mem_cs_n,                                            
  output wire          hps_memory_mem_reset_n,                     
  inout  wire [31:0]   hps_memory_mem_dq,                          
  inout  wire [3:0]    hps_memory_mem_dqs,                         
  inout  wire [3:0]    hps_memory_mem_dqs_n,                       
  output wire          hps_memory_mem_odt,                                          
  input  wire          hps_memory_oct_rzqin,     
  input  wire          emif_ref_clk,  
  input  wire          emif_uart_rxd,
  output wire          emif_uart_txd,

  // FPGA peripherals ports
  output wire [3:0]    fpga_led_pio                     
 
);

//=======================================================
//  REG/WIRE declarations
//=======================================================
wire         	alt_pr_freeze_freeze;	

wire		board_kernel_clk_clk;
wire		board_kernel_clk2x_clk;
wire         	board_kernel_reset_reset_n;
wire [0:0]   	board_kernel_irq_irq;
wire		board_kernel_cra_waitrequest;
wire [63:0]	board_kernel_cra_readdata;
wire         	board_kernel_cra_readdatavalid;
wire [0:0]  	board_kernel_cra_burstcount;
wire [63:0]  	board_kernel_cra_writedata;
wire [29:0]  	board_kernel_cra_address;
wire         	board_kernel_cra_write;
wire         	board_kernel_cra_read;
wire [7:0]   	board_kernel_cra_byteenable;
wire         	board_kernel_cra_debugaccess;
wire         	board_kernel_mem0_waitrequest;
wire [255:0] 	board_kernel_mem0_readdata;
wire         	board_kernel_mem0_readdatavalid;
wire [4:0]   	board_kernel_mem0_burstcount;
wire [255:0] 	board_kernel_mem0_writedata;
wire [24:0]  	board_kernel_mem0_address;
wire         	board_kernel_mem0_write;
wire         	board_kernel_mem0_read;
wire [31:0]  	board_kernel_mem0_byteenable;
wire         	board_kernel_mem0_debugaccess;

wire            system_reset_n;
wire          iopll_locked;



//=======================================================
// board instantiation
//=======================================================
board board_inst
(
  // Clocks and Resets
  .clk_100_clk               (fpga_clk_100),
  .reset_100_reset_n         (system_reset_n),

  .board_iopll_0_locked_export     (iopll_locked),
  .reset_iopll_reset_n       (fpga_reset_n),
  .board_kernel_pll_ref_clock_in_clk_clk             (clk_fpga_b2_p),   
  .board_pll_ref_clock_in_clk_clk                    (clk_enet_fpga_p),
  .board_emif_a10_hps_0_pll_ref_clk_clock_sink_clk   (emif_ref_clk),

  // HPS peripherals
  .hps_io_hps_io_phery_emac0_TX_CLK              (hps_emac0_TX_CLK), 
  .hps_io_hps_io_phery_emac0_TXD0                (hps_emac0_TXD0),   
  .hps_io_hps_io_phery_emac0_TXD1                (hps_emac0_TXD1),   
  .hps_io_hps_io_phery_emac0_TXD2                (hps_emac0_TXD2),   
  .hps_io_hps_io_phery_emac0_TXD3                (hps_emac0_TXD3),   
  .hps_io_hps_io_phery_emac0_MDIO                (hps_emac0_MDIO),   
  .hps_io_hps_io_phery_emac0_MDC                 (hps_emac0_MDC),    
  .hps_io_hps_io_phery_emac0_RX_CTL              (hps_emac0_RX_CTL), 
  .hps_io_hps_io_phery_emac0_TX_CTL              (hps_emac0_TX_CTL), 
  .hps_io_hps_io_phery_emac0_RX_CLK              (hps_emac0_RX_CLK), 
  .hps_io_hps_io_phery_emac0_RXD0                (hps_emac0_RXD0),   
  .hps_io_hps_io_phery_emac0_RXD1                (hps_emac0_RXD1),   
  .hps_io_hps_io_phery_emac0_RXD2                (hps_emac0_RXD2),   
  .hps_io_hps_io_phery_emac0_RXD3                (hps_emac0_RXD3),
  .hps_io_hps_io_phery_usb0_DATA0                (hps_usb0_D0),      
  .hps_io_hps_io_phery_usb0_DATA1                (hps_usb0_D1),      
  .hps_io_hps_io_phery_usb0_DATA2                (hps_usb0_D2),      
  .hps_io_hps_io_phery_usb0_DATA3                (hps_usb0_D3),      
  .hps_io_hps_io_phery_usb0_DATA4                (hps_usb0_D4),      
  .hps_io_hps_io_phery_usb0_DATA5                (hps_usb0_D5),      
  .hps_io_hps_io_phery_usb0_DATA6                (hps_usb0_D6),      
  .hps_io_hps_io_phery_usb0_DATA7                (hps_usb0_D7),      
  .hps_io_hps_io_phery_usb0_CLK                  (hps_usb0_CLK),     
  .hps_io_hps_io_phery_usb0_STP                  (hps_usb0_STP),     
  .hps_io_hps_io_phery_usb0_DIR                  (hps_usb0_DIR),     
  .hps_io_hps_io_phery_usb0_NXT                  (hps_usb0_NXT),   
  .hps_io_hps_io_phery_spim1_CLK                 (hps_spim1_CLK),
  .hps_io_hps_io_phery_spim1_MOSI                (hps_spim1_MOSI),
  .hps_io_hps_io_phery_spim1_MISO                (hps_spim1_MISO),
  .hps_io_hps_io_phery_spim1_SS0_N               (hps_spim1_SS0_N),
  .hps_io_hps_io_phery_spim1_SS1_N               (hps_spim1_SS1_N),
  .hps_io_hps_io_phery_uart1_RX                  (hps_uart1_RX),     
  .hps_io_hps_io_phery_uart1_TX                  (hps_uart1_TX),  
  .hps_io_hps_io_phery_sdmmc_CMD                 (hps_sdio_CMD),     
  .hps_io_hps_io_phery_sdmmc_D0                  (hps_sdio_D0),      
  .hps_io_hps_io_phery_sdmmc_D1                  (hps_sdio_D1),      
  .hps_io_hps_io_phery_sdmmc_D2                  (hps_sdio_D2),      
  .hps_io_hps_io_phery_sdmmc_D3                  (hps_sdio_D3),      
  .hps_io_hps_io_phery_sdmmc_D4                  (hps_sdio_D4),
  .hps_io_hps_io_phery_sdmmc_D5                  (hps_sdio_D5),
  .hps_io_hps_io_phery_sdmmc_D6                  (hps_sdio_D6),
  .hps_io_hps_io_phery_sdmmc_D7                  (hps_sdio_D7),
  .hps_io_hps_io_phery_sdmmc_CCLK                (hps_sdio_CLK),   
  .hps_io_hps_io_phery_sdmmc_PWR_ENA             (hps_sdio_PWR_ENA),
  .hps_io_hps_io_phery_i2c1_SDA                  (hps_i2c1_SDA),
  .hps_io_hps_io_phery_i2c1_SCL                  (hps_i2c1_SCL),  
  .hps_io_hps_io_gpio_gpio1_io14                 (hps_gpio_GPIO14),
  .hps_io_hps_io_gpio_gpio1_io16                 (hps_gpio_GPIO16),
  .hps_io_hps_io_gpio_gpio1_io17                 (hps_gpio_GPIO17),
  .hps_io_hps_io_gpio_gpio1_io5                  (hps_gpio_GPIO05),  
  //.hps_io_hps_io_phery_trace_CLK                 (hps_trace_CLK),

  // HPS memory 
  .hps_memory_mem_ck         (hps_memory_mem_ck),     
  .hps_memory_mem_ck_n       (hps_memory_mem_ck_n),   
  .hps_memory_mem_a          (hps_memory_mem_a),      
  .hps_memory_mem_act_n      (hps_memory_mem_act_n),
  .hps_memory_mem_ba         (hps_memory_mem_ba), 
  .hps_memory_mem_bg         (hps_memory_mem_bg),
  .hps_memory_mem_cke        (hps_memory_mem_cke),    
  .hps_memory_mem_cs_n       (hps_memory_mem_cs_n),   
  .hps_memory_mem_odt        (hps_memory_mem_odt),    
  .hps_memory_mem_reset_n    (hps_memory_mem_reset_n),
  .hps_memory_mem_par        (hps_memory_mem_par), 
  .hps_memory_mem_alert_n    (hps_memory_mem_alert_n), 
  .hps_memory_mem_dqs        (hps_memory_mem_dqs),    
  .hps_memory_mem_dqs_n      (hps_memory_mem_dqs_n),  
  .hps_memory_mem_dq         (hps_memory_mem_dq), 
  .hps_memory_mem_dbi_n      (hps_memory_mem_dbi_n), 
  .hps_memory_oct_oct_rzqin  (hps_memory_oct_rzqin), 

  // signals for PR
  .alt_pr_freeze_freeze(alt_pr_freeze_freeze),

  // board ports
  .kernel_clk_clk(board_kernel_clk_clk),
  .kernel_clk2x_clk(board_kernel_clk2x_clk),
  .kernel_reset_reset_n(board_kernel_reset_reset_n),
  .kernel_irq_irq(board_kernel_irq_irq),
  .kernel_cra_waitrequest(board_kernel_cra_waitrequest),
  .kernel_cra_readdata(board_kernel_cra_readdata),
  .kernel_cra_readdatavalid(board_kernel_cra_readdatavalid),
  .kernel_cra_burstcount(board_kernel_cra_burstcount),
  .kernel_cra_writedata(board_kernel_cra_writedata),
  .kernel_cra_address(board_kernel_cra_address),
  .kernel_cra_write(board_kernel_cra_write),
  .kernel_cra_read(board_kernel_cra_read),
  .kernel_cra_byteenable(board_kernel_cra_byteenable),
  .kernel_cra_debugaccess(board_kernel_cra_debugaccess),
  .kernel_mem0_waitrequest(board_kernel_mem0_waitrequest),
  .kernel_mem0_readdata(board_kernel_mem0_readdata),
  .kernel_mem0_readdatavalid(board_kernel_mem0_readdatavalid),
  .kernel_mem0_burstcount(board_kernel_mem0_burstcount),
  .kernel_mem0_writedata(board_kernel_mem0_writedata),
  .kernel_mem0_address(board_kernel_mem0_address),
  .kernel_mem0_write(board_kernel_mem0_write),
  .kernel_mem0_read(board_kernel_mem0_read),
  .kernel_mem0_byteenable(board_kernel_mem0_byteenable),
  .kernel_mem0_debugaccess(board_kernel_mem0_debugaccess)
);

//=======================================================
// freeze wrapper instantiation
//=======================================================
freeze_wrapper freeze_wrapper_inst
(
  .freeze(alt_pr_freeze_freeze),  
  
  // board ports
  .board_kernel_clk_clk(board_kernel_clk_clk),
  .board_kernel_clk2x_clk(board_kernel_clk2x_clk),
  .board_kernel_reset_reset_n(board_kernel_reset_reset_n),
  .board_kernel_irq_irq(board_kernel_irq_irq),
  .board_kernel_cra_waitrequest(board_kernel_cra_waitrequest),
  .board_kernel_cra_readdata(board_kernel_cra_readdata),
  .board_kernel_cra_readdatavalid(board_kernel_cra_readdatavalid),
  .board_kernel_cra_burstcount(board_kernel_cra_burstcount),
  .board_kernel_cra_writedata(board_kernel_cra_writedata),
  .board_kernel_cra_address(board_kernel_cra_address),
  .board_kernel_cra_write(board_kernel_cra_write),
  .board_kernel_cra_read(board_kernel_cra_read),
  .board_kernel_cra_byteenable(board_kernel_cra_byteenable),
  .board_kernel_cra_debugaccess(board_kernel_cra_debugaccess),
  .board_kernel_mem0_waitrequest(board_kernel_mem0_waitrequest),
  .board_kernel_mem0_readdata(board_kernel_mem0_readdata),
  .board_kernel_mem0_readdatavalid(board_kernel_mem0_readdatavalid),
  .board_kernel_mem0_burstcount(board_kernel_mem0_burstcount),
  .board_kernel_mem0_writedata(board_kernel_mem0_writedata),
  .board_kernel_mem0_address(board_kernel_mem0_address),
  .board_kernel_mem0_write(board_kernel_mem0_write),
  .board_kernel_mem0_read(board_kernel_mem0_read),
  .board_kernel_mem0_byteenable(board_kernel_mem0_byteenable),
  .board_kernel_mem0_debugaccess(board_kernel_mem0_debugaccess)
);

//=======================================================
// LEDs for debug
//=======================================================
reg [25:0] cnt1;
reg [25:0] cnt2;
always @(posedge fpga_clk_100) begin
  cnt1 <= cnt1+1;
end
always @(posedge board_kernel_clk_clk) begin
  cnt2 <= cnt2+1;
end

assign fpga_led_pio[1:0] = cnt1[25:24];
assign fpga_led_pio[3:2] = cnt2[25:24];

//=======================================================
// Power on Reset
//=======================================================
reg [10:0] dcnt=0;
always @(posedge fpga_clk_100) begin
    if (dcnt[10] == 1'b0) begin
        dcnt <= dcnt+1;
    end
end

assign system_reset_n = dcnt[10] & fpga_reset_n & iopll_locked;

endmodule



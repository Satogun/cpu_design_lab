


module fpga(
    input clk_i,
    input rst,
    output wire [7:0] led_en,
    output wire led_ca_o,
    output wire led_cb_o,
    output wire led_cc_o,
    output wire led_cd_o,
    output wire led_ce_o,
    output wire led_cf_o,
    output wire led_cg_o,
    output wire led_dp_o,
    
    
    input [23:0] device_sw,
    output[23:0] device_led
    );
    
    wire rst_n=!rst;
    wire clk;
   
    wire[31:0] rD2,alu_result,DRAM_rd;
    wire led_we,DRAM_WE;
    
    cpuclk cpuclk(
         .clk_in1(clk_i),
         .clk_out1(clk)
    );
    
    LED_CTRL display(
       .clk(clk),
       .rst_n(rst_n),
       .led_en(led_en),
       .led_ca_o(led_ca_o),
       .led_cb_o(led_cb_o),
       .led_cc_o(led_cc_o),
       .led_cd_o(led_cd_o),
       .led_ce_o(led_ce_o),
       .led_cf_o(led_cf_o),
       .led_cg_o(led_cg_o),
       .led_dp_o(led_dp_o),
       .rD2(rD2),
       .led_we(led_we)
    
    );
    
    


    BUS_CPU testcpu(
      .clk(clk),
      .rst_n(rst_n),
      .rD2(rD2),
      .alu_result(alu_result),
      .DRAM_rd(DRAM_rd),
      .DRAM_WE(DRAM_WE),
      .led_we(led_we),
      .device_led(device_led),
      .device_sw(device_sw)
      
    );
    
     DRAM UDRAM_BUS
    (
          .clk(clk),
          .addr(alu_result),
          .we(DRAM_WE),       
          .wr(rD2),  
          .rd(DRAM_rd),
          .device_sw(device_sw),
          .device_led(device_led)
    );

endmodule

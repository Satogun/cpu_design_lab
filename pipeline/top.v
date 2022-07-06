//trace 用
module top(

    input clk,
    input rst_n,
    output        debug_wb_have_inst,   // WB阶段是否有指令 (对单周期CPU，此flag恒为1)
    output [31:0] debug_wb_pc,          // WB阶段的PC (若wb_have_inst=0，此项可为任意值)
    output        debug_wb_ena,         // WB阶段的寄存器写使能 (若wb_have_inst=0，此项可为任意值)
    output [4:0]  debug_wb_reg,         // WB阶段写入的寄存器号 (若wb_ena或wb_have_inst=0，此项可为任意值)
    output [31:0] debug_wb_value

);

   wire[31:0]pc,inst;
   wire[31:0] dram_rd,alu_result,rD2;
   wire DRAM_WE;

  TRACE_CPU cpu_fortrace(
         .clk            (clk),
        .rst_n          (rst_n),
        .inst           (inst),
        .dram_rd         (dram_rd),
        .pc             (pc),
        .alu_result     (alu_result),
        .rD2            (rD2),
        .DRAM_WE        (DRAM_WE),
        .debug_wb_have_inst(debug_wb_have_inst),
        .debug_wb_pc    (debug_wb_pc),  
        .debug_wb_ena   (debug_wb_ena), 
        .debug_wb_reg   (debug_wb_reg), 
        .debug_wb_value (debug_wb_value)
  
  );
  
  
  inst_mem imem(
      .a(pc[15:2]),
      .spo(inst)
  );
  
  data_mem dmem(
     .clk(!clk),
     .a(alu_result[15:2]),
     .spo(dram_rd),
     .we(DRAM_WE),
     .d(rD2)
  );
  


endmodule

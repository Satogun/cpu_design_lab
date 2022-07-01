//trace ”√
module top(

    input clk,
    input rst_n,
    output        debug_wb_have_inst,   //for trace test 
    output [31:0] debug_wb_pc,          
    output        debug_wb_ena,         
    output [4:0]  debug_wb_reg,        
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

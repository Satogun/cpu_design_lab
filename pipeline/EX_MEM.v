    

module EX_MEM(
      input clk,
      input rst_n,
      input [31:0] alu_result,
      input [31:0] ex_rD2,
      input [31:0] ex_pc4,
      input [31:0] ex_inst,
      input [1:0] ex_wD_sel,
      input ex_DRAM_we,
      input ex_RF_WE,
      
      
      output reg [31:0] mem_inst,
      output reg mem_DRAM_we,
      output reg mem_RF_WE,
      output reg [1:0] mem_wD_sel,
      output reg [31:0] mem_pc4,
      output reg [31:0] mem_alu_result,
      output reg [31:0] mem_rD2
      
    );
    
    
    always@(posedge clk or negedge rst_n)
    begin
          if(!rst_n) mem_pc4<=32'b0;
          else mem_pc4<=ex_pc4;
    end
    
    always@(posedge clk or negedge rst_n)
    begin
          if(!rst_n) mem_alu_result<=32'b0;
          else mem_alu_result<=alu_result;
    end
    
    always@(posedge clk or negedge rst_n)
    begin
          if(!rst_n) mem_inst<=32'b0;
          else mem_inst<=ex_inst;
    end
    
    always@(posedge clk or negedge rst_n)
    begin
          if(!rst_n) mem_rD2<=32'b0;
          else mem_rD2<=ex_rD2;
    end
    
    always@(posedge clk or negedge rst_n)
    begin
          if(!rst_n) mem_alu_result<=32'b0;
          else mem_alu_result<=alu_result;
    end
    
    always@(posedge clk or negedge rst_n)
    begin
          if(!rst_n) mem_wD_sel<=32'b0;
          else mem_wD_sel<=ex_wD_sel;
    end
    
    always@(posedge clk or negedge rst_n)
    begin
          if(!rst_n) mem_DRAM_we<=1'b0;
          else mem_DRAM_we<=ex_DRAM_we;
    end
    
    always@(posedge clk or negedge rst_n)
    begin
          if(!rst_n) mem_RF_WE<=1'b0;
          else mem_RF_WE<=ex_RF_WE;
    end
   
endmodule
    
    
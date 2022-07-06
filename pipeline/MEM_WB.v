module MEM_WB(
     input clk,
     input rst_n,
     input [31:0] mem_alu_result,
     input [31:0] DRAM_rd,
     input [31:0] mem_pc4,
     input [1:0] mem_wD_sel,
     input mem_RF_WE,
     input [31:0] mem_inst,
     
     output reg [31:0] wb_inst,
     output reg wb_RF_WE,
     output reg [31:0] wb_alu_result,
     output reg [31:0] wb_DRAM_rd,
     output reg [31:0] wb_pc4,
     output reg [1:0] wb_wD_sel

    );
    
    always@(posedge clk or negedge rst_n)
    begin
         if(!rst_n) wb_alu_result<=32'b0;
         else wb_alu_result <= mem_alu_result;
    end
    
    always@(posedge clk or negedge rst_n)
    begin
         if(!rst_n) wb_DRAM_rd<=32'b0;
         else wb_DRAM_rd <= DRAM_rd;
    end
    
    always@(posedge clk or negedge rst_n)
    begin
         if(!rst_n) wb_pc4<=32'b0;
         else wb_pc4 <= mem_pc4;
    end
    
    always@(posedge clk or negedge rst_n)
    begin
         if(!rst_n) wb_inst<=32'b0;
         else wb_inst <= mem_inst;
    end
    
    
     always@(posedge clk or negedge rst_n)
    begin
         if(!rst_n) wb_RF_WE<=1'b0;
         else wb_RF_WE <= mem_RF_WE;
    end
    
    always@(posedge clk or negedge rst_n)
    begin
         if(!rst_n) wb_wD_sel<=2'b00;
         else wb_wD_sel <= mem_wD_sel;
    end
    
    
endmodule

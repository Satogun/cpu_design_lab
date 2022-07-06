module ID_EX(
     input clk,
     input rst_n,
     input [31:0] id_pc,
     input [31:0] id_pc4,
     input [31:0] imm,
     input [31:0] rD1,
     input [31:0] rD2,
     input [31:0] id_inst,
     input [3:0] alu_op,
     input [1:0] npc_op,
     input [1:0] wD_sel,
     input DRAM_we,
     input RF_WE,
     input A_sel,
     input B_sel,
     
     output reg [31:0] ex_pc,
     output reg [31:0] ex_pc4,
     output reg [31:0] ex_rD1,
     output reg [31:0] ex_rD2,
     output reg [31:0] ex_imm,
     output reg [3:0] ex_alu_op,
     output reg [31:0] ex_inst,
     output reg [1:0] ex_npc_op,
     output reg [1:0] ex_wD_sel,
     output reg ex_A_sel,
     output reg ex_B_sel,
     output reg ex_RF_WE,
     output reg ex_DRAM_we 
     
    );
    
    always@(posedge clk or negedge rst_n)
    begin
        if(!rst_n) ex_pc<=32'b0;
        else ex_pc<=id_pc;
    end
    
    always@(posedge clk or negedge rst_n)
    begin
        if(!rst_n) ex_pc4<=32'b0;
        else ex_pc4<=id_pc4;
    end
    
    always@(posedge clk or negedge rst_n)
    begin
        if(!rst_n) ex_rD1<=32'b0;
        else ex_rD1<=rD1;
    end
    
    always@(posedge clk or negedge rst_n)
    begin
        if(!rst_n) ex_rD2<=32'b0;
        else ex_rD2<=rD2;
    end
    
    always@(posedge clk or negedge rst_n)
    begin
        if(!rst_n) ex_imm<=32'b0;
        else ex_imm<=imm;
    end
    
    always@(posedge clk or negedge rst_n)
    begin
        if(!rst_n) ex_wD_sel<=32'b0;
        else ex_wD_sel<=wD_sel;
    end
    
    always@(posedge clk or negedge rst_n)
    begin
        if(!rst_n) ex_inst<=32'b0;
        else ex_inst<=id_inst;
    end
    
    
    
    always@(posedge clk or negedge rst_n)
    begin
        if(!rst_n) ex_alu_op<=4'b0;
        else ex_alu_op<=alu_op;
    end
    
    always@(posedge clk or negedge rst_n)
    begin
        if(!rst_n) ex_npc_op<=2'b0;
        else ex_npc_op<=npc_op;
    end
    
    always@(posedge clk or negedge rst_n)
    begin
        if(!rst_n) ex_DRAM_we<=1'b0;
        else ex_DRAM_we<=DRAM_we;
    end
    
    always@(posedge clk or negedge rst_n)
    begin
        if(!rst_n) ex_RF_WE<=1'b0;
        else ex_RF_WE<=RF_WE;
    end
    
    always@(posedge clk or negedge rst_n)
    begin
        if(!rst_n) ex_A_sel<=1'b0;
        else ex_A_sel<=A_sel;
    end
    
    always@(posedge clk or negedge rst_n)
    begin
        if(!rst_n) ex_B_sel<=1'b0;
        else ex_B_sel<=B_sel;
    end
    
    
    
    
    
endmodule

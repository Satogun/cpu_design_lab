


module BUS_CPU(
     input clk,
     input rst_n,
     
     output led_we,
     output [31:0] rD2,    //RF输出的rD2  直连入DRAM
     output [31:0] DRAM_rd,
     output [31:0] alu_result,
     output DRAM_WE,
     input [23:0]device_sw,
     output [23:0]device_led
     
     
    );
    
    wire RF_WE,A_sel,B_sel;
    wire zero,sign;
    wire pc_en;
    wire [1:0] npc_op,wD_sel;
    wire [2:0] imm_sel;
    wire [3:0] alu_op;
    wire [31:0] pc,npc,pc4,inst;
    wire [31:0] imm;
    wire [31:0] rD1,wD;
    
    assign led_we=(inst[6:0]==7'b0100011)?1:0;

    
    PC UPC(
         .clk(clk),
         .rst_n(rst_n),
         .en(pc_en),
         .npc(npc),
         .pc_o(pc)
      );
      
      IROM UIROM_BUS(
         .pc(pc),
         .inst(inst)
        );
      
      NPC UNPC(
          .pc(pc),
          .imm(imm),
          .alu_result(alu_result),
          .npc_op(npc_op),
          .npc(npc),
          .pc_add4(pc4)
        );
        
        SEXT USEXT(
           .imm_in(inst[31:7]),
           .imm_out(imm),
           .imm_sel(imm_sel)
         );
         
         RF URF(
           .clk(clk),
           .rst_n(rst_n),
           .rR1(inst[19:15]),
           .rR2(inst[24:20]),
           .wR(inst[11:7]),
           .wD_sel(wD_sel),
           .alu_result(alu_result),
           .dram_data(DRAM_rd),
           .imm(imm),
           .pc4(pc4),
           .WE(RF_WE),
           .rD1(rD1),
           .rD2(rD2),
           .wD(wD)
         );
         
         Branch UBranch(
           .Data1(rD1),
           .Data2(rD2),
           .sign(sign),
           .zero(zero)
         );
        
        ALU UALU(
           .Data1(rD1),
           .Data2(rD2),
           .imm(imm),
           .pc(pc),
           .alu_op(alu_op),
           .A_sel(A_sel),
           .B_sel(B_sel),
           .out(alu_result)
        );
        
        CONTROL UCONTROL(
         .func7(inst[31:25]),
         .func3(inst[14:12]),
         .opcode(inst[6:0]),
         .zero(zero),
         .sign(sign),
         .A_sel(A_sel),
         .B_sel(B_sel),
         .wD_sel(wD_sel),//写回数据选择信号
         .npc_op(npc_op),//NPC op
         .RF_WE(RF_WE),     //寄存器堆写回信号
         .imm_sel(imm_sel), //立即数扩展op
         .alu_op(alu_op),  //运算op
         .DRAM_WE(DRAM_WE),         //访存信号
         .PC_en(pc_en)   
        );
        
       
         
endmodule

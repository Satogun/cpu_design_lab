

module NOBUS_CPU(
    input clk_i,
    input rst_n,
    output [31:0] PC,
    input [23:0] device_sw,
    output[23:0] device_led
    );
    
    wire clk=clk_i;
    wire RF_WE,A_sel,B_sel,DRAM_WE;
    wire sign,zero;
    wire pc_en;
    wire [1:0] wD_sel,npc_op;
    wire [2:0] imm_sel;
    wire [3:0] alu_op;
    
    
    wire [31:0] npc,pc4;
    wire [31:0] inst;
    wire [31:0] imm;
    wire [31:0] rD1,rD2,alu_result,wD;
    wire [31:0] dram_rd;
    
//    cpuclk_sim UCLK(
//       .clk_in1(clk_i),
//       .clk_out1(clk)
//      );
      
      PC UPC(
         .clk(clk),
         .rst_n(rst_n),
         .en(pc_en),
         .npc(npc),
         .pc_o(PC)
      );
      
      IROM UIROM(
         .pc(PC),
         .inst(inst)
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
           .dram_data(dram_rd),
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
           .pc(PC),
           .alu_op(alu_op),
           .A_sel(A_sel),
           .B_sel(B_sel),
           .out(alu_result)
        );
        
        NPC UNPC(
          .pc(PC),
          .imm(imm),
          .alu_result(alu_result),
          .npc_op(npc_op),
          .npc(npc),
          .pc_add4(pc4)
        );
       
        DRAM UDRAM(
          .clk(clk),
          .addr(alu_result),
          .we(DRAM_WE),       
          .wr(rD2),  
          .rd(dram_rd),  
          .device_sw(device_sw), 
          .device_led(device_led)  
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


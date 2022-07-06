



module pipe_cpu(
     input clk,
     input rst_n,
     
     output led_we,
     output [31:0] rD2,    //RF输出的rD2  直连入DRAM
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
    wire[31:0] alu_result;
    wire [31:0] DRAM_rd;
    wire DRAM_we;
    
    wire [31:0]id_pc,id_inst,id_pc4;
    
    wire [31:0] ex_pc,ex_pc4,ex_rD1,ex_imm,ex_rD2,ex_inst;
    wire ex_A_sel,ex_B_sel,ex_dram_wd;
    wire ex_DRAM_we,ex_RF_WE;
    wire [2:0] ex_wD_sel;
    wire [3:0] ex_alu_op;
    wire [1:0] ex_npc_op;
    
    wire [31:0] mem_rD2,mem_pc4,mem_inst;
    wire [1:0] mem_wD_sel;
    wire [31:0] mem_alu_result;
    wire  mem_DRAM_we,mem_RF_WE;
    
    wire [31:0] wb_pc4,wb_alu_result,wb_DRAM_rd,wb_inst;
    wire [1:0] wb_wD_sel;
    wire wb_RF_WE;
    
    
    
     
    assign led_we=(inst[6:0]==7'b0100011)?1:0;

    
    PC UPC(
         .clk(clk),
         .rst_n(rst_n),
         .en(pc_en),
         .npc(npc),
         .pc_o(pc),
         .pc4(pc4)
      );
      
      IROM UIROM_BUS(
         .pc(pc),
         .inst(inst)
        );
      
        IF_ID uid_id(
           .clk(clk),
           .rst_n(rst_n),
           .if_pc4(pc4),
           .if_pc(pc),
           .if_inst(inst),
           .id_pc4(id_pc4),
           .id_pc(id_pc),
           .id_inst(id_inst)
        );
        
        SEXT USEXT(
           .imm_in(id_inst[31:7]),
           .imm_out(imm),
           .imm_sel(imm_sel)
         );
         
         RF URF(
           .clk(clk),
           .rst_n(rst_n),
           .rR1(id_inst[19:15]),
           .rR2(id_inst[24:20]),
           .wR(wb_inst[11:7]),
           .wD_sel(wb_wD_sel),
           .alu_result(wb_alu_result),
           .dram_data(wb_DRAM_rd),
           .pc4(wb_pc4),
           .WE(wb_RF_WE),
           .rD1(rD1),
           .rD2(rD2),
           .wD(wD)
         );
         
         CONTROL UCONTROL(
         .func7(id_inst[31:25]),
         .func3(id_inst[14:12]),
         .opcode(id_inst[6:0]),
         .zero(zero),
         .sign(sign),
         .A_sel(A_sel),
         .B_sel(B_sel),
         .wD_sel(wD_sel),//写回数据选择信号
         .npc_op(npc_op),//NPC op
         .RF_WE(RF_WE),     //寄存器堆写回信号
         .imm_sel(imm_sel), //立即数扩展op
         .alu_op(alu_op),  //运算op
         .DRAM_WE(DRAM_we),         //访存信号
         .PC_en(pc_en)   
        );
        
        Branch UBranch(
           .Data1(rD1),
           .Data2(rD2),
           .sign(sign),
           .zero(zero)
         );
        
        
          
         ID_EX UID_EX(
            .clk(clk),
            .rst_n(rst_n),
            .id_pc(id_pc),
            .id_pc4(id_pc4),
            .id_inst(id_inst),
            .RF_WE(RF_WE),
            .imm(imm),
            .rD1(rD1),
            .rD2(rD2),
            .wD_sel(wD_sel),
            .alu_op(alu_op),
            .npc_op(npc_op),
            .DRAM_we(DRAM_we),
            .A_sel(A_sel),
            .B_sel(B_sel),
            
            .ex_DRAM_we(ex_DRAM_we),
            .ex_alu_op(ex_alu_op),
            .ex_npc_op(ex_npc_op),
            .ex_inst(ex_inst),
            .ex_pc(ex_pc),
            .ex_pc4(ex_pc4),
            .ex_rD1(ex_rD1),
            .ex_rD2(ex_rD2),
            .ex_A_sel(ex_A_sel),
            .ex_B_sel(ex_B_sel),
            .ex_wD_sel(ex_wD_sel),
            .ex_RF_WE(ex_RF_WE),
            .ex_imm(ex_imm)
         );
         
         ALU UALU(
           .Data1(ex_rD1),
           .Data2(ex_rD2),
           .imm(ex_imm),
           .pc(ex_pc),
           .alu_op(ex_alu_op),
           .A_sel(ex_A_sel),
           .B_sel(ex_B_sel),
           .out(alu_result)
        );
         
          NPC unpc(
          .pc(pc),
          .imm(ex_imm),
          .alu_result(alu_result),
          .npc_op(ex_npc_op),
          .npc(npc)
        );
         
         
         
         
        
        
        
        
        EX_MEM uexe
        (
           .clk(clk),
           .rst_n(rst_n),
           .ex_DRAM_we(ex_DRAM_we),
           .alu_result(alu_result),
           .ex_rD2(ex_rD2),
           .ex_pc4(ex_pc4),
           .ex_wD_sel(ex_wD_sel),
           .ex_inst(ex_inst),
           .ex_RF_WE(ex_RF_WE),
           
           .mem_wD_sel(mem_wD_sel),
           .mem_DRAM_we(mem_DRAM_we),
           .mem_inst(mem_inst),
           .mem_alu_result(mem_alu_result),
           .mem_rD2(mem_rD2),
           .mem_RF_WE(mem_RF_WE),
           .mem_pc4(mem_pc4)
           
        
        );
        
        DRAM UDRAM_BUS
    (
          .clk(clk),
          .addr(mem_alu_result),
          .we(mem_DRAM_we),       
          .wr(mem_rD2),  
          .rst_n(rst_n),
          .rd(DRAM_rd),
          .device_sw(device_sw),
          .device_led(device_led)
    );
    
    MEM_WB umem_wb(
       .clk(clk),
       .rst_n(rst_n),
       .mem_alu_result(mem_alu_result),
       .mem_inst(mem_inst),
       .mem_RF_WE(mem_RF_WE),
       .DRAM_rd(DRAM_rd),
       .mem_wD_sel(mem_wD_sel),
       .mem_pc4(mem_pc4),
       
       .wb_DRAM_rd(wb_DRAM_rd),
       .wb_RF_WE(wb_RF_WE),
       .wb_inst(wb_inst),
       .wb_alu_result(wb_alu_result),
       .wb_wD_sel(wb_wD_sel),
       .wb_pc4(wb_pc4)
    );
        
        
        
       
         
endmodule

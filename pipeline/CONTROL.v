module CONTROL(
      input [6:0]func7,
      input [2:0]func3,
      input [6:0] opcode,
      input zero,
      input sign,
      output wire A_sel,
      output wire B_sel,
      output reg [1:0] wD_sel,//写回数据选择信号
      output reg [1:0] npc_op,//NPC op
      output wire RF_WE,     //寄存器堆写回信号
      output reg [2:0]imm_sel, //立即数扩展op
      output reg[3:0] alu_op,  //运算op
      output wire DRAM_WE,         //访存信号
      output wire PC_en           //PC使能
    );
    assign PC_en={func7,func3,opcode}!=17'b0;
    //npc 选择信号
    always@(*)
    begin
       case(opcode)
        7'b0110011:npc_op=2'b00;//R
        7'b0010011:npc_op=2'b00;//I
        7'b0000011:npc_op=2'b00;//lw
        7'b0100011:npc_op=2'b00;//sw
        7'b0110111:npc_op=2'b00;//lui
        7'b1100011: //B
                  case(func3)
                  3'b000:npc_op=zero?2'b01:2'b00;//beq
                  3'b001:npc_op=zero?2'b00:2'b01;//bne
                  3'b100:npc_op=sign?2'b01:2'b00;//blt
                  3'b101:npc_op=sign?2'b00:2'b01;//bge
                  endcase
        
        7'b1101111:npc_op=2'b10;//jal
        7'b1100111:npc_op=2'b11;//jalr
        default:npc_op=2'b00;
        endcase
    end
    
    assign RF_WE=( opcode==7'b0100011 || opcode==7'b1100011)?2'b0:2'b1;//除sw和B型指令  都要写寄存器
    
    //立即数选择信号
    always@(*)
    begin
       case(opcode)
        7'b0010011:
              if(func3==3'b000||func3==3'b100||func3==3'b110||func3==3'b111) imm_sel=3'b000;//其他的I型指令
              else if(func3==3'b001||func3==3'b101) imm_sel=3'b101;//带立即数的左移右移
              else imm_sel=3'b000;
        7'b1100111:imm_sel=3'b000;//jalr
        7'b0000011:imm_sel=3'b000;//lw I
        7'b0100011:imm_sel=3'b001;//sw S
        7'b1100011:imm_sel=3'b010;//B
        7'b0110111:imm_sel=3'b011;//lui
        7'b1101111:imm_sel=3'b100;//jal J
        default:imm_sel=3'b000;
        endcase
    end
    
    //wD_sel 写回数据选择信号
    always@(*)
    begin
        case(opcode)
            7'b0110011: wD_sel=2'b00; // R
            7'b0010011: wD_sel=2'b00; // I
            7'b0000011: wD_sel=2'b01; // lw
            7'b0110111: wD_sel=2'b00; // lui
            7'b1100111: wD_sel=2'b11; // jalr
            7'b1101111: wD_sel=2'b11; // jal
            default:wD_sel=2'b00;
            endcase
    end
    
    //alu_op 选择信号
    always@(*)
    begin
         case(opcode)
         7'b0110011://R
             case(func3)
                 3'b000:alu_op=(func7[5]==1)?4'b0111:4'b0110;//sub or add
                 3'b111:alu_op=4'b0000;//and
                 3'b110:alu_op=4'b0001;//or
                 3'b100:alu_op=4'b0010;//xor
                 3'b001:alu_op=4'b0011;//sll
                 3'b101:alu_op=(func7[5]==1)?4'b0101:4'b0100;//srl or sra
                 endcase
        7'b0010011://I
              case(func3)
                 3'b000:alu_op=4'b0110;//add or sub
                 3'b111:alu_op=4'b0000;//and
                 3'b110:alu_op=4'b0001;//or
                 3'b100:alu_op=4'b0010;//xor
                 3'b001:alu_op=4'b0011;//sll
                 3'b101:alu_op=(func7[5]==1)?4'b0101:4'b0100;//srl or sra     
                 endcase          
        7'b1100111:alu_op=4'b0110;//jalr  add
        7'b0000011:alu_op=4'b0110;//lw add
        7'b0100011:alu_op=4'b0110;//sw add
        7'b1100011:alu_op=4'b0110;//B add
        7'b0110111:alu_op=4'b1000;//lui 
        7'b1101111:alu_op=4'b0110;//jal
        default:alu_op=4'b0000;
        endcase
    end
    assign A_sel=(opcode==7'b0110011||opcode==7'b0010011||opcode==7'b0000011||opcode==7'b1100111||opcode==7'b0100011)?1'b0:1'b1;
    assign B_sel=(opcode==7'b0110011)?1'b0:1'b1;
    assign DRAM_WE=(opcode==7'b0100011)?1'b1:1'b0;
    
    
    
endmodule

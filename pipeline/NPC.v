


module NPC(
     input [31:0]pc,
     input [31:0] imm,
     input [31:0] alu_result,
     input [1:0] npc_op,
     output reg [31:0] npc   
);


always@(*)
begin
     case(npc_op)
     2'b00: npc=pc+32'd4; //R I lw lui sw
     2'b01: npc=pc+imm;//B型指令的imm
     2'b10: npc=pc+imm;//jal指令的立即数
     2'b11: npc={alu_result[31:1],1'b0};//jalr的立即数 按字节寻址可以忽略最后一位
     default:npc=32'b0;
     endcase
end


endmodule




module NPC(
     input [31:0]pc,
     input [31:0] imm,
     input [31:0] alu_result,//ALU result
     input [1:0] npc_op,
     output reg [31:0] npc,
     output [31:0] pc_add4
);

assign pc_add4=pc+32'd4;

always@(*)
begin
     case(npc_op)
     2'b00: npc=pc+32'd4; //R I lw lui sw
     2'b01: npc=pc+imm;//B--imm
     2'b10: npc=pc+imm;//jal-imm
     2'b11: npc={alu_result[31:1],1'b0};//jalr--imm
     default:npc=32'b0;
     endcase
end


endmodule

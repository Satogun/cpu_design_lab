

module SEXT(
      input[24:0] imm_in,
      output reg [31:0] imm_out,
      input [2:0] imm_sel
    );
    
    wire sign=imm_in[24];
    always@(*)
    begin
        case(imm_sel)
        3'b000:imm_out={sign==1?20'hFFFFF:20'h00000,imm_in[24:13]};//I型指令
        3'b001:imm_out={sign==1?20'hFFFFF:20'h00000,imm_in[24:18],imm_in[4:0]};//S型指令
        3'b010:imm_out={sign==1?19'hFFFFF:19'h00000,imm_in[24],imm_in[0],imm_in[23:18],imm_in[4:1],1'b0};//B型指令
        3'b011:imm_out={imm_in[24:5],12'b0};//U型
        3'b100:imm_out={sign==1?11'b111_1111_1111:11'h0,imm_in[24],imm_in[12:5],imm_in[13],imm_in[23:14],1'b0};//J型
        3'b101:imm_out={27'b0,imm_in[17:13]};//移位
        default:imm_out=32'b0;
        endcase
    end
endmodule

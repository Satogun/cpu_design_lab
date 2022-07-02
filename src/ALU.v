module ALU(
     input [31:0] Data1,
     input [31:0] Data2,
     input [31:0] imm,
     input [31:0] pc,
     input [3:0] alu_op,
     input A_sel,
     input B_sel,
     output reg [31:0]out 

    );
    
    wire[31:0] A=(A_sel==1'b0)?Data1:pc;
    wire[31:0] B=(B_sel==1'b0)?Data2:imm;
    
    always@(*)
    begin
        case(alu_op)
        4'b0000:out=A&B;
        4'b0001:out=A|B;
        4'b0010:out=A^B;
        4'b0011:out=A<<B[4:0];
        4'b0100:out=A>>B[4:0];
        4'b0101:out=$signed(A)>>>B[4:0];
        4'b0110:out=A+B;
        4'b0111:out=A+~B+1;
        4'b1000:out=B;  //lui 
         default:out=A;
          endcase
                 
    end
    
endmodule

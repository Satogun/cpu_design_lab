module Branch
(
   input [31:0]Data1,
   input [31:0]Data2,
   output sign,
   output zero

    );
   
    assign sign=(Data1+~Data2+1)>>31;
    assign zero=((Data1+~Data2+1)==32'b0)?1'b1:1'b0;
endmodule

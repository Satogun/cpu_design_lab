

module IROM(
      input [31:0] pc,
      output [31:0] inst
    );
    
   prgrom UIROM(
       .a(pc[15:2]),
       .spo(inst)
   );
  

endmodule

module IF_ID(
     input clk,
     inout rst_n,
     input [31:0] if_pc,
     input [31:0] if_pc4,
     input [31:0] if_inst,
     output reg [31:0] id_pc,
     output reg [31:0] id_pc4,
     output reg [31:0] id_inst
     );
     
     always@(posedge clk or negedge rst_n)
     begin
          if(!rst_n) id_pc<=32'b0;
          else id_pc<=if_pc; 
     end
     
     always@(posedge clk or negedge rst_n)
     begin
          if(!rst_n) id_pc4<=32'b0;
          else id_pc4<=if_pc4; 
     end
     
     always@(posedge clk or negedge rst_n)
     begin
          if(!rst_n) id_inst<=32'b0;
          else id_inst<=if_inst; 
     end
endmodule

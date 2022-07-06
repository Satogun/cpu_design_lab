
module PC(
    input  clk,
    input  rst_n,
    input en,
    input  [31:0] npc,
    output reg[31:0] pc_o,
    output [31:0] pc4
    
    );
    
    reg rst_n_delay;
    always@(posedge clk)
    begin
        rst_n_delay<=rst_n;
    end
    assign pc4=pc_o+32'd4;
    always@(posedge clk or negedge rst_n)
    begin
          if(!rst_n) pc_o<=32'b0;
          else if(!rst_n_delay) pc_o<=32'b0;
          else if(en)  pc_o<=npc;
          else pc_o<=pc_o;   
    end
endmodule

module DRAM(
      input clk,
      input [31:0] addr,
      input we,       
      input [31:0] wr,  
      output reg [31:0] rd,  
      input [23:0] device_sw,  
      output reg [23:0] device_led  
    );
    reg WE;
    wire clk_n=~clk;
    always@(*)
    begin
        if(addr==32'hFFFFF_060 && we) begin
                                WE=1'b0; 
                                device_led={device_led[23:16],wr[15:0]};
                                end
      
        else begin
              WE=we;
              device_led=device_led;
              end
    end
    
    wire [31:0]tem_rd;
    always@(*)
    begin
        if(addr==32'hFFFFF_070) rd={8'b0,device_sw[23:0]};
        else rd=tem_rd;
    end
    
    wire[31:0] addr_tmp=addr-16'h4000;
    
    dram UDRAM(
       .clk(clk_n),
       .a(addr_tmp[15:2]),
       .spo(tem_rd),
       .we(WE),
       .d(wr)
    );
   
endmodule

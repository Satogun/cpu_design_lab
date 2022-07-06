
module DRAM(
      input clk,
      input [31:0] addr,//地址
      input rst_n,
      input we,       //使能是信号
      input [31:0] wr,  //要写进去的数据  input [31:0] wr,  //要写进去的数据
      output reg [31:0] rd,  //读出的数据
      input [23:0] device_sw,  //开关的数据  读
      output reg [23:0] device_led  //led的数据 写
    );
    reg WE;
    wire clk_n=~clk;
    always@(*)
    begin
       if(!rst_n) device_led=24'b0;
        else if(addr==32'hFFFFF_060 && we) begin
                                WE=1'b0; //如果是led的地址则不进入DRAM写数据
                                device_led={8'b0,wr[15:0]};
                                end
        else begin
              WE=we;
              device_led=device_led;
              end
    end
    
    wire [31:0]tem_rd;
    always@(*)
    begin
        if(addr==32'hFFFFF_070) rd={8'b0,device_sw[23:0]};//如果是拨码开关的地址，则不从DRAM读数据
        else rd=tem_rd;
    end
    
    wire[31:0] addr_tmp=addr-16'h4000;
    
    dram UDRAM(
       .clk(clk_n),
       .a(addr[15:2]),
       .spo(tem_rd),
       .we(WE),
       .d(wr)
    );
   
endmodule

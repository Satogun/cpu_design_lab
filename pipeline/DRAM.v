
module DRAM(
      input clk,
      input [31:0] addr,//��ַ
      input rst_n,
      input we,       //ʹ�����ź�
      input [31:0] wr,  //Ҫд��ȥ������  input [31:0] wr,  //Ҫд��ȥ������
      output reg [31:0] rd,  //����������
      input [23:0] device_sw,  //���ص�����  ��
      output reg [23:0] device_led  //led������ д
    );
    reg WE;
    wire clk_n=~clk;
    always@(*)
    begin
       if(!rst_n) device_led=24'b0;
        else if(addr==32'hFFFFF_060 && we) begin
                                WE=1'b0; //�����led�ĵ�ַ�򲻽���DRAMд����
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
        if(addr==32'hFFFFF_070) rd={8'b0,device_sw[23:0]};//����ǲ��뿪�صĵ�ַ���򲻴�DRAM������
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

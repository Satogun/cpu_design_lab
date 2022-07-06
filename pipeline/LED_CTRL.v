
module LED_CTRL(
   
   input clk,
   input rst_n,

    
    output reg [7:0] led_en,
    
    output reg led_ca_o,
    output reg led_cb_o,
    output reg led_cc_o,
    output reg led_cd_o,
    output reg led_ce_o,
    output reg led_cf_o,
    output reg led_cg_o,
    output reg led_dp_o,
    input led_we,

    input [31:0] rD2

    );
    
    parameter re_0=7'b0000001;
    parameter re_1=7'b1001111;
    parameter re_2=7'b0010010;
    parameter re_3=7'b0000110;
    parameter re_4=7'b1001100;
    parameter re_5=7'b0100100;
    parameter re_6=7'b0100000;
    parameter re_7=7'b0001111;
    parameter re_8=7'b0000000;
    parameter re_9=7'b0000100;
    parameter re_a=7'b0001000;
    parameter re_b=7'b1100000;
    parameter re_c=7'b0110001;
    parameter re_d=7'b1000010;
    parameter re_e=7'b0110000;
    parameter re_f=7'b0111000;
    
    
    reg [24:0] cnt;

    
    //2ms计数器 刷新数码管使能
    always@(posedge clk or negedge rst_n)
    begin
         if(!rst_n) cnt<=0;
         else if(cnt==4999) cnt<=0;
         else cnt<=cnt+1;
    end
    
    
    always @(posedge clk or negedge rst_n)
    begin
         if(!rst_n) led_en<=8'b11111111;
         else if(cnt==19999)
                begin
                     if(led_en==8'b1111_1111) led_en<=8'b1111_1110;
                     else led_en<={led_en[6:0],led_en[7]};
                end
         else led_en<=led_en;
    end
    
   reg[31:0] final;
   always@(posedge clk or negedge rst_n)
   begin
        if(!rst_n) final=32'b0;
        else if(led_we) final<=rD2;
        else final<=final;
   end

    

    
    
    
    
    
    always@(posedge clk or negedge rst_n)
    begin
         if(!rst_n) {led_ca_o,led_cb_o,led_cc_o,led_cd_o,led_ce_o,led_cf_o,led_cg_o}=7'b1111111;
         else
             begin
             case(led_en)
                    8'b11111110:
                             case(final[3:0])
                             4'd0:{led_ca_o,led_cb_o,led_cc_o,led_cd_o,led_ce_o,led_cf_o,led_cg_o}<=re_0;
                             4'd1:{led_ca_o,led_cb_o,led_cc_o,led_cd_o,led_ce_o,led_cf_o,led_cg_o}<=re_1;
                             4'd2:{led_ca_o,led_cb_o,led_cc_o,led_cd_o,led_ce_o,led_cf_o,led_cg_o}<=re_2;
                             4'd3:{led_ca_o,led_cb_o,led_cc_o,led_cd_o,led_ce_o,led_cf_o,led_cg_o}<=re_3;
                             4'd4:{led_ca_o,led_cb_o,led_cc_o,led_cd_o,led_ce_o,led_cf_o,led_cg_o}<=re_4;
                             4'd5:{led_ca_o,led_cb_o,led_cc_o,led_cd_o,led_ce_o,led_cf_o,led_cg_o}<=re_5;
                             4'd6:{led_ca_o,led_cb_o,led_cc_o,led_cd_o,led_ce_o,led_cf_o,led_cg_o}<=re_6;
                             4'd7:{led_ca_o,led_cb_o,led_cc_o,led_cd_o,led_ce_o,led_cf_o,led_cg_o}<=re_7;
                             4'd8:{led_ca_o,led_cb_o,led_cc_o,led_cd_o,led_ce_o,led_cf_o,led_cg_o}<=re_8;
                             4'd9:{led_ca_o,led_cb_o,led_cc_o,led_cd_o,led_ce_o,led_cf_o,led_cg_o}<=re_9;
                             4'd10:{led_ca_o,led_cb_o,led_cc_o,led_cd_o,led_ce_o,led_cf_o,led_cg_o}<=re_a;
                             4'd11:{led_ca_o,led_cb_o,led_cc_o,led_cd_o,led_ce_o,led_cf_o,led_cg_o}<=re_b;
                             4'd12:{led_ca_o,led_cb_o,led_cc_o,led_cd_o,led_ce_o,led_cf_o,led_cg_o}<=re_c;
                             4'd13:{led_ca_o,led_cb_o,led_cc_o,led_cd_o,led_ce_o,led_cf_o,led_cg_o}<=re_d;
                             4'd14:{led_ca_o,led_cb_o,led_cc_o,led_cd_o,led_ce_o,led_cf_o,led_cg_o}<=re_e;
                             4'd15:{led_ca_o,led_cb_o,led_cc_o,led_cd_o,led_ce_o,led_cf_o,led_cg_o}<=re_f;
                             endcase
             8'b11111101:
                             case(final[7:4])
                             4'd0:{led_ca_o,led_cb_o,led_cc_o,led_cd_o,led_ce_o,led_cf_o,led_cg_o}<=re_0;
                             4'd1:{led_ca_o,led_cb_o,led_cc_o,led_cd_o,led_ce_o,led_cf_o,led_cg_o}<=re_1;
                             4'd2:{led_ca_o,led_cb_o,led_cc_o,led_cd_o,led_ce_o,led_cf_o,led_cg_o}<=re_2;
                             4'd3:{led_ca_o,led_cb_o,led_cc_o,led_cd_o,led_ce_o,led_cf_o,led_cg_o}<=re_3;
                             4'd4:{led_ca_o,led_cb_o,led_cc_o,led_cd_o,led_ce_o,led_cf_o,led_cg_o}<=re_4;
                             4'd5:{led_ca_o,led_cb_o,led_cc_o,led_cd_o,led_ce_o,led_cf_o,led_cg_o}<=re_5;
                             4'd6:{led_ca_o,led_cb_o,led_cc_o,led_cd_o,led_ce_o,led_cf_o,led_cg_o}<=re_6;
                             4'd7:{led_ca_o,led_cb_o,led_cc_o,led_cd_o,led_ce_o,led_cf_o,led_cg_o}<=re_7;
                             4'd8:{led_ca_o,led_cb_o,led_cc_o,led_cd_o,led_ce_o,led_cf_o,led_cg_o}<=re_8;
                             4'd9:{led_ca_o,led_cb_o,led_cc_o,led_cd_o,led_ce_o,led_cf_o,led_cg_o}<=re_9;
                             4'd10:{led_ca_o,led_cb_o,led_cc_o,led_cd_o,led_ce_o,led_cf_o,led_cg_o}<=re_a;
                             4'd11:{led_ca_o,led_cb_o,led_cc_o,led_cd_o,led_ce_o,led_cf_o,led_cg_o}<=re_b;
                             4'd12:{led_ca_o,led_cb_o,led_cc_o,led_cd_o,led_ce_o,led_cf_o,led_cg_o}<=re_c;
                             4'd13:{led_ca_o,led_cb_o,led_cc_o,led_cd_o,led_ce_o,led_cf_o,led_cg_o}<=re_d;
                             4'd14:{led_ca_o,led_cb_o,led_cc_o,led_cd_o,led_ce_o,led_cf_o,led_cg_o}<=re_e;
                             4'd15:{led_ca_o,led_cb_o,led_cc_o,led_cd_o,led_ce_o,led_cf_o,led_cg_o}<=re_f;
                             endcase
                 8'b11111011:
                             case(final[11:8])
                             4'd0:{led_ca_o,led_cb_o,led_cc_o,led_cd_o,led_ce_o,led_cf_o,led_cg_o}<=re_0;
                             4'd1:{led_ca_o,led_cb_o,led_cc_o,led_cd_o,led_ce_o,led_cf_o,led_cg_o}<=re_1;
                             4'd2:{led_ca_o,led_cb_o,led_cc_o,led_cd_o,led_ce_o,led_cf_o,led_cg_o}<=re_2;
                             4'd3:{led_ca_o,led_cb_o,led_cc_o,led_cd_o,led_ce_o,led_cf_o,led_cg_o}<=re_3;
                             4'd4:{led_ca_o,led_cb_o,led_cc_o,led_cd_o,led_ce_o,led_cf_o,led_cg_o}<=re_4;
                             4'd5:{led_ca_o,led_cb_o,led_cc_o,led_cd_o,led_ce_o,led_cf_o,led_cg_o}<=re_5;
                             4'd6:{led_ca_o,led_cb_o,led_cc_o,led_cd_o,led_ce_o,led_cf_o,led_cg_o}<=re_6;
                             4'd7:{led_ca_o,led_cb_o,led_cc_o,led_cd_o,led_ce_o,led_cf_o,led_cg_o}<=re_7;
                             4'd8:{led_ca_o,led_cb_o,led_cc_o,led_cd_o,led_ce_o,led_cf_o,led_cg_o}<=re_8;
                             4'd9:{led_ca_o,led_cb_o,led_cc_o,led_cd_o,led_ce_o,led_cf_o,led_cg_o}<=re_9;
                             4'd10:{led_ca_o,led_cb_o,led_cc_o,led_cd_o,led_ce_o,led_cf_o,led_cg_o}<=re_a;
                             4'd11:{led_ca_o,led_cb_o,led_cc_o,led_cd_o,led_ce_o,led_cf_o,led_cg_o}<=re_b;
                             4'd12:{led_ca_o,led_cb_o,led_cc_o,led_cd_o,led_ce_o,led_cf_o,led_cg_o}<=re_c;
                             4'd13:{led_ca_o,led_cb_o,led_cc_o,led_cd_o,led_ce_o,led_cf_o,led_cg_o}<=re_d;
                             4'd14:{led_ca_o,led_cb_o,led_cc_o,led_cd_o,led_ce_o,led_cf_o,led_cg_o}<=re_e;
                             4'd15:{led_ca_o,led_cb_o,led_cc_o,led_cd_o,led_ce_o,led_cf_o,led_cg_o}<=re_f;
                             endcase
             8'b11110111:
                             case(final[15:12])
                             4'd0:{led_ca_o,led_cb_o,led_cc_o,led_cd_o,led_ce_o,led_cf_o,led_cg_o}<=re_0;
                             4'd1:{led_ca_o,led_cb_o,led_cc_o,led_cd_o,led_ce_o,led_cf_o,led_cg_o}<=re_1;
                             4'd2:{led_ca_o,led_cb_o,led_cc_o,led_cd_o,led_ce_o,led_cf_o,led_cg_o}<=re_2;
                             4'd3:{led_ca_o,led_cb_o,led_cc_o,led_cd_o,led_ce_o,led_cf_o,led_cg_o}<=re_3;
                             4'd4:{led_ca_o,led_cb_o,led_cc_o,led_cd_o,led_ce_o,led_cf_o,led_cg_o}<=re_4;
                             4'd5:{led_ca_o,led_cb_o,led_cc_o,led_cd_o,led_ce_o,led_cf_o,led_cg_o}<=re_5;
                             4'd6:{led_ca_o,led_cb_o,led_cc_o,led_cd_o,led_ce_o,led_cf_o,led_cg_o}<=re_6;
                             4'd7:{led_ca_o,led_cb_o,led_cc_o,led_cd_o,led_ce_o,led_cf_o,led_cg_o}<=re_7;
                             4'd8:{led_ca_o,led_cb_o,led_cc_o,led_cd_o,led_ce_o,led_cf_o,led_cg_o}<=re_8;
                             4'd9:{led_ca_o,led_cb_o,led_cc_o,led_cd_o,led_ce_o,led_cf_o,led_cg_o}<=re_9;
                             4'd10:{led_ca_o,led_cb_o,led_cc_o,led_cd_o,led_ce_o,led_cf_o,led_cg_o}<=re_a;
                             4'd11:{led_ca_o,led_cb_o,led_cc_o,led_cd_o,led_ce_o,led_cf_o,led_cg_o}<=re_b;
                             4'd12:{led_ca_o,led_cb_o,led_cc_o,led_cd_o,led_ce_o,led_cf_o,led_cg_o}<=re_c;
                             4'd13:{led_ca_o,led_cb_o,led_cc_o,led_cd_o,led_ce_o,led_cf_o,led_cg_o}<=re_d;
                             4'd14:{led_ca_o,led_cb_o,led_cc_o,led_cd_o,led_ce_o,led_cf_o,led_cg_o}<=re_e;
                             4'd15:{led_ca_o,led_cb_o,led_cc_o,led_cd_o,led_ce_o,led_cf_o,led_cg_o}<=re_f;
                             endcase
                  
            
             8'b11101111:
                             case(final[19:16])
                             4'd0:{led_ca_o,led_cb_o,led_cc_o,led_cd_o,led_ce_o,led_cf_o,led_cg_o}<=re_0;
                             4'd1:{led_ca_o,led_cb_o,led_cc_o,led_cd_o,led_ce_o,led_cf_o,led_cg_o}<=re_1;
                             4'd2:{led_ca_o,led_cb_o,led_cc_o,led_cd_o,led_ce_o,led_cf_o,led_cg_o}<=re_2;
                             4'd3:{led_ca_o,led_cb_o,led_cc_o,led_cd_o,led_ce_o,led_cf_o,led_cg_o}<=re_3;
                             4'd4:{led_ca_o,led_cb_o,led_cc_o,led_cd_o,led_ce_o,led_cf_o,led_cg_o}<=re_4;
                             4'd5:{led_ca_o,led_cb_o,led_cc_o,led_cd_o,led_ce_o,led_cf_o,led_cg_o}<=re_5;
                             4'd6:{led_ca_o,led_cb_o,led_cc_o,led_cd_o,led_ce_o,led_cf_o,led_cg_o}<=re_6;
                             4'd7:{led_ca_o,led_cb_o,led_cc_o,led_cd_o,led_ce_o,led_cf_o,led_cg_o}<=re_7;
                             4'd8:{led_ca_o,led_cb_o,led_cc_o,led_cd_o,led_ce_o,led_cf_o,led_cg_o}<=re_8;
                             4'd9:{led_ca_o,led_cb_o,led_cc_o,led_cd_o,led_ce_o,led_cf_o,led_cg_o}<=re_9;
                             4'd10:{led_ca_o,led_cb_o,led_cc_o,led_cd_o,led_ce_o,led_cf_o,led_cg_o}<=re_a;
                             4'd11:{led_ca_o,led_cb_o,led_cc_o,led_cd_o,led_ce_o,led_cf_o,led_cg_o}<=re_b;
                             4'd12:{led_ca_o,led_cb_o,led_cc_o,led_cd_o,led_ce_o,led_cf_o,led_cg_o}<=re_c;
                             4'd13:{led_ca_o,led_cb_o,led_cc_o,led_cd_o,led_ce_o,led_cf_o,led_cg_o}<=re_d;
                             4'd14:{led_ca_o,led_cb_o,led_cc_o,led_cd_o,led_ce_o,led_cf_o,led_cg_o}<=re_e;
                             4'd15:{led_ca_o,led_cb_o,led_cc_o,led_cd_o,led_ce_o,led_cf_o,led_cg_o}<=re_f;
                             endcase
                   
             8'b11011111:
                             case(final[23:20])
                             4'd0:{led_ca_o,led_cb_o,led_cc_o,led_cd_o,led_ce_o,led_cf_o,led_cg_o}<=re_0;
                             4'd1:{led_ca_o,led_cb_o,led_cc_o,led_cd_o,led_ce_o,led_cf_o,led_cg_o}<=re_1;
                             4'd2:{led_ca_o,led_cb_o,led_cc_o,led_cd_o,led_ce_o,led_cf_o,led_cg_o}<=re_2;
                             4'd3:{led_ca_o,led_cb_o,led_cc_o,led_cd_o,led_ce_o,led_cf_o,led_cg_o}<=re_3;
                             4'd4:{led_ca_o,led_cb_o,led_cc_o,led_cd_o,led_ce_o,led_cf_o,led_cg_o}<=re_4;
                             4'd5:{led_ca_o,led_cb_o,led_cc_o,led_cd_o,led_ce_o,led_cf_o,led_cg_o}<=re_5;
                             4'd6:{led_ca_o,led_cb_o,led_cc_o,led_cd_o,led_ce_o,led_cf_o,led_cg_o}<=re_6;
                             4'd7:{led_ca_o,led_cb_o,led_cc_o,led_cd_o,led_ce_o,led_cf_o,led_cg_o}<=re_7;
                             4'd8:{led_ca_o,led_cb_o,led_cc_o,led_cd_o,led_ce_o,led_cf_o,led_cg_o}<=re_8;
                             4'd9:{led_ca_o,led_cb_o,led_cc_o,led_cd_o,led_ce_o,led_cf_o,led_cg_o}<=re_9;
                             4'd10:{led_ca_o,led_cb_o,led_cc_o,led_cd_o,led_ce_o,led_cf_o,led_cg_o}<=re_a;
                             4'd11:{led_ca_o,led_cb_o,led_cc_o,led_cd_o,led_ce_o,led_cf_o,led_cg_o}<=re_b;
                             4'd12:{led_ca_o,led_cb_o,led_cc_o,led_cd_o,led_ce_o,led_cf_o,led_cg_o}<=re_c;
                             4'd13:{led_ca_o,led_cb_o,led_cc_o,led_cd_o,led_ce_o,led_cf_o,led_cg_o}<=re_d;
                             4'd14:{led_ca_o,led_cb_o,led_cc_o,led_cd_o,led_ce_o,led_cf_o,led_cg_o}<=re_e;
                             4'd15:{led_ca_o,led_cb_o,led_cc_o,led_cd_o,led_ce_o,led_cf_o,led_cg_o}<=re_f;
                             endcase
                   
             8'b10111111:
                             case(final[27:24])
                             4'd0:{led_ca_o,led_cb_o,led_cc_o,led_cd_o,led_ce_o,led_cf_o,led_cg_o}<=re_0;
                             4'd1:{led_ca_o,led_cb_o,led_cc_o,led_cd_o,led_ce_o,led_cf_o,led_cg_o}<=re_1;
                             4'd2:{led_ca_o,led_cb_o,led_cc_o,led_cd_o,led_ce_o,led_cf_o,led_cg_o}<=re_2;
                             4'd3:{led_ca_o,led_cb_o,led_cc_o,led_cd_o,led_ce_o,led_cf_o,led_cg_o}<=re_3;
                             4'd4:{led_ca_o,led_cb_o,led_cc_o,led_cd_o,led_ce_o,led_cf_o,led_cg_o}<=re_4;
                             4'd5:{led_ca_o,led_cb_o,led_cc_o,led_cd_o,led_ce_o,led_cf_o,led_cg_o}<=re_5;
                             4'd6:{led_ca_o,led_cb_o,led_cc_o,led_cd_o,led_ce_o,led_cf_o,led_cg_o}<=re_6;
                             4'd7:{led_ca_o,led_cb_o,led_cc_o,led_cd_o,led_ce_o,led_cf_o,led_cg_o}<=re_7;
                             4'd8:{led_ca_o,led_cb_o,led_cc_o,led_cd_o,led_ce_o,led_cf_o,led_cg_o}<=re_8;
                             4'd9:{led_ca_o,led_cb_o,led_cc_o,led_cd_o,led_ce_o,led_cf_o,led_cg_o}<=re_9;
                             4'd10:{led_ca_o,led_cb_o,led_cc_o,led_cd_o,led_ce_o,led_cf_o,led_cg_o}<=re_a;
                             4'd11:{led_ca_o,led_cb_o,led_cc_o,led_cd_o,led_ce_o,led_cf_o,led_cg_o}<=re_b;
                             4'd12:{led_ca_o,led_cb_o,led_cc_o,led_cd_o,led_ce_o,led_cf_o,led_cg_o}<=re_c;
                             4'd13:{led_ca_o,led_cb_o,led_cc_o,led_cd_o,led_ce_o,led_cf_o,led_cg_o}<=re_d;
                             4'd14:{led_ca_o,led_cb_o,led_cc_o,led_cd_o,led_ce_o,led_cf_o,led_cg_o}<=re_e;
                             4'd15:{led_ca_o,led_cb_o,led_cc_o,led_cd_o,led_ce_o,led_cf_o,led_cg_o}<=re_f;
                             endcase
                   
             8'b01111111:
                             case(final[31:28])
                             4'd0:{led_ca_o,led_cb_o,led_cc_o,led_cd_o,led_ce_o,led_cf_o,led_cg_o}<=re_0;
                             4'd1:{led_ca_o,led_cb_o,led_cc_o,led_cd_o,led_ce_o,led_cf_o,led_cg_o}<=re_1;
                             4'd2:{led_ca_o,led_cb_o,led_cc_o,led_cd_o,led_ce_o,led_cf_o,led_cg_o}<=re_2;
                             4'd3:{led_ca_o,led_cb_o,led_cc_o,led_cd_o,led_ce_o,led_cf_o,led_cg_o}<=re_3;
                             4'd4:{led_ca_o,led_cb_o,led_cc_o,led_cd_o,led_ce_o,led_cf_o,led_cg_o}<=re_4;
                             4'd5:{led_ca_o,led_cb_o,led_cc_o,led_cd_o,led_ce_o,led_cf_o,led_cg_o}<=re_5;
                             4'd6:{led_ca_o,led_cb_o,led_cc_o,led_cd_o,led_ce_o,led_cf_o,led_cg_o}<=re_6;
                             4'd7:{led_ca_o,led_cb_o,led_cc_o,led_cd_o,led_ce_o,led_cf_o,led_cg_o}<=re_7;
                             4'd8:{led_ca_o,led_cb_o,led_cc_o,led_cd_o,led_ce_o,led_cf_o,led_cg_o}<=re_8;
                             4'd9:{led_ca_o,led_cb_o,led_cc_o,led_cd_o,led_ce_o,led_cf_o,led_cg_o}<=re_9;
                             4'd10:{led_ca_o,led_cb_o,led_cc_o,led_cd_o,led_ce_o,led_cf_o,led_cg_o}<=re_a;
                             4'd11:{led_ca_o,led_cb_o,led_cc_o,led_cd_o,led_ce_o,led_cf_o,led_cg_o}<=re_b;
                             4'd12:{led_ca_o,led_cb_o,led_cc_o,led_cd_o,led_ce_o,led_cf_o,led_cg_o}<=re_c;
                             4'd13:{led_ca_o,led_cb_o,led_cc_o,led_cd_o,led_ce_o,led_cf_o,led_cg_o}<=re_d;
                             4'd14:{led_ca_o,led_cb_o,led_cc_o,led_cd_o,led_ce_o,led_cf_o,led_cg_o}<=re_e;
                             4'd15:{led_ca_o,led_cb_o,led_cc_o,led_cd_o,led_ce_o,led_cf_o,led_cg_o}<=re_f;
                             endcase
                   default:{led_ca_o,led_cb_o,led_cc_o,led_cd_o,led_ce_o,led_cf_o,led_cg_o}<=7'b1111111;
             endcase
             end
         
    end
    
    
    
    
endmodule


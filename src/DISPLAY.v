module DISPLAY(
   
   input clk,
   input rst_n,

    
    output wire led0_en_o,
    output wire led1_en_o,
    output wire led2_en_o,
    output wire led3_en_o,
    output wire led4_en_o,
    output wire led5_en_o,
    output wire led6_en_o,
    output wire led7_en_o,
    
    output wire led_ca_o,
    output wire led_cb_o,
    output wire led_cc_o,
    output wire led_cd_o,
    output wire led_ce_o,
    output wire led_cf_o,
    output wire led_cg_o,
    output wire led_dp_o,
    

    input [31:0] pc

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
    parameter re_9=7'b0001100;
    parameter re_a=7'b0001000;
    parameter re_b=7'b1100000;
    parameter re_c=7'b0110001;
    parameter re_d=7'b1000010;
    parameter re_e=7'b0110000;
    parameter re_f=7'b0111000;
    
    
    reg a,b,c,d,e,f,g;
    reg [24:0] cnt;
    reg [3:0] led_cnt;
    assign led_ca_o=a;
    assign led_cb_o=b;
    assign led_cc_o=c;
    assign led_cd_o=d;
    assign led_ce_o=e;
    assign led_cf_o=f;
    assign led_cg_o=g;
    assign led_dp_o=1;
    
    //2ms count
    always@(posedge clk or negedge rst_n)
    begin
         if(!rst_n) cnt<=0;
         else if(cnt==25'd1) cnt<=0;
         else cnt<=cnt+1;
    end
    
    wire flag=(led_cnt==8);
    always@(posedge clk or negedge rst_n)
    begin
        if(!rst_n) led_cnt<=0;
        else if(flag) led_cnt<=0;
        else if(cnt==25'd1)
                      begin
                          led_cnt<=led_cnt+1;
                      end
    end
    
    
    assign led0_en_o=(led_cnt==0)?0:1;
    assign led1_en_o=(led_cnt==1)?0:1;
    assign led2_en_o=(led_cnt==2)?0:1;
    assign led3_en_o=(led_cnt==3)?0:1;
    assign led4_en_o=(led_cnt==4)?0:1;
    assign led5_en_o=(led_cnt==5)?0:1;
    assign led6_en_o=(led_cnt==6)?0:1;
    assign led7_en_o=(led_cnt==7)?0:1;
    
     wire [3:0]led_1=pc[3:0];
     wire [3:0]led_2=pc[7:4];
     wire [3:0]led_3=pc[11:8];
     wire [3:0]led_4=pc[15:12];
     wire [3:0]led_5=pc[19:16];
     wire [3:0]led_6=pc[23:20];
     wire [3:0]led_7=pc[27:24];
     wire [3:0]led_8=pc[31:28];
    
    
    
    
    
    always@(posedge clk or negedge rst_n)
    begin
         if(!rst_n) {a,b,c,d,e,f,g}=7'b1111111;
         else 
             begin
             case(led_cnt)
                    4'd0:
                             case(led_1)
                             4'd0:{a,b,c,d,e,f,g}<=re_0;
                             4'd1:{a,b,c,d,e,f,g}<=re_1;
                             4'd2:{a,b,c,d,e,f,g}<=re_2;
                             4'd3:{a,b,c,d,e,f,g}<=re_3;
                             4'd4:{a,b,c,d,e,f,g}<=re_4;
                             4'd5:{a,b,c,d,e,f,g}<=re_5;
                             4'd6:{a,b,c,d,e,f,g}<=re_6;
                             4'd7:{a,b,c,d,e,f,g}<=re_7;
                             4'd8:{a,b,c,d,e,f,g}<=re_8;
                             4'd9:{a,b,c,d,e,f,g}<=re_9;
                             4'd10:{a,b,c,d,e,f,g}<=re_a;
                             4'd11:{a,b,c,d,e,f,g}<=re_b;
                             4'd12:{a,b,c,d,e,f,g}<=re_c;
                             4'd13:{a,b,c,d,e,f,g}<=re_d;
                             4'd14:{a,b,c,d,e,f,g}<=re_e;
                             4'd15:{a,b,c,d,e,f,g}<=re_f;
                             endcase
             4'd1:
                             case(led_2)
                             4'd0:{a,b,c,d,e,f,g}<=re_0;
                             4'd1:{a,b,c,d,e,f,g}<=re_1;
                             4'd2:{a,b,c,d,e,f,g}<=re_2;
                             4'd3:{a,b,c,d,e,f,g}<=re_3;
                             4'd4:{a,b,c,d,e,f,g}<=re_4;
                             4'd5:{a,b,c,d,e,f,g}<=re_5;
                             4'd6:{a,b,c,d,e,f,g}<=re_6;
                             4'd7:{a,b,c,d,e,f,g}<=re_7;
                             4'd8:{a,b,c,d,e,f,g}<=re_8;
                             4'd9:{a,b,c,d,e,f,g}<=re_9;
                             4'd10:{a,b,c,d,e,f,g}<=re_a;
                             4'd11:{a,b,c,d,e,f,g}<=re_b;
                             4'd12:{a,b,c,d,e,f,g}<=re_c;
                             4'd13:{a,b,c,d,e,f,g}<=re_d;
                             4'd14:{a,b,c,d,e,f,g}<=re_e;
                             4'd15:{a,b,c,d,e,f,g}<=re_f;
                             endcase
                 4'd2:
                             case(led_3)
                             4'd0:{a,b,c,d,e,f,g}<=re_0;
                             4'd1:{a,b,c,d,e,f,g}<=re_1;
                             4'd2:{a,b,c,d,e,f,g}<=re_2;
                             4'd3:{a,b,c,d,e,f,g}<=re_3;
                             4'd4:{a,b,c,d,e,f,g}<=re_4;
                             4'd5:{a,b,c,d,e,f,g}<=re_5;
                             4'd6:{a,b,c,d,e,f,g}<=re_6;
                             4'd7:{a,b,c,d,e,f,g}<=re_7;
                             4'd8:{a,b,c,d,e,f,g}<=re_8;
                             4'd9:{a,b,c,d,e,f,g}<=re_9;
                             4'd10:{a,b,c,d,e,f,g}<=re_a;
                             4'd11:{a,b,c,d,e,f,g}<=re_b;
                             4'd12:{a,b,c,d,e,f,g}<=re_c;
                             4'd13:{a,b,c,d,e,f,g}<=re_d;
                             4'd14:{a,b,c,d,e,f,g}<=re_e;
                             4'd15:{a,b,c,d,e,f,g}<=re_f;
                             endcase
             4'd3:
                             case(led_4)
                             4'd0:{a,b,c,d,e,f,g}<=re_0;
                             4'd1:{a,b,c,d,e,f,g}<=re_1;
                             4'd2:{a,b,c,d,e,f,g}<=re_2;
                             4'd3:{a,b,c,d,e,f,g}<=re_3;
                             4'd4:{a,b,c,d,e,f,g}<=re_4;
                             4'd5:{a,b,c,d,e,f,g}<=re_5;
                             4'd6:{a,b,c,d,e,f,g}<=re_6;
                             4'd7:{a,b,c,d,e,f,g}<=re_7;
                             4'd8:{a,b,c,d,e,f,g}<=re_8;
                             4'd9:{a,b,c,d,e,f,g}<=re_9;
                             4'd10:{a,b,c,d,e,f,g}<=re_a;
                             4'd11:{a,b,c,d,e,f,g}<=re_b;
                             4'd12:{a,b,c,d,e,f,g}<=re_c;
                             4'd13:{a,b,c,d,e,f,g}<=re_d;
                             4'd14:{a,b,c,d,e,f,g}<=re_e;
                             4'd15:{a,b,c,d,e,f,g}<=re_f;
                             endcase
                  
            
             4'd4:
                             case(led_5)
                             4'd0:{a,b,c,d,e,f,g}<=re_0;
                             4'd1:{a,b,c,d,e,f,g}<=re_1;
                             4'd2:{a,b,c,d,e,f,g}<=re_2;
                             4'd3:{a,b,c,d,e,f,g}<=re_3;
                             4'd4:{a,b,c,d,e,f,g}<=re_4;
                             4'd5:{a,b,c,d,e,f,g}<=re_5;
                             4'd6:{a,b,c,d,e,f,g}<=re_6;
                             4'd7:{a,b,c,d,e,f,g}<=re_7;
                             4'd8:{a,b,c,d,e,f,g}<=re_8;
                             4'd9:{a,b,c,d,e,f,g}<=re_9;
                             4'd10:{a,b,c,d,e,f,g}<=re_a;
                             4'd11:{a,b,c,d,e,f,g}<=re_b;
                             4'd12:{a,b,c,d,e,f,g}<=re_c;
                             4'd13:{a,b,c,d,e,f,g}<=re_d;
                             4'd14:{a,b,c,d,e,f,g}<=re_e;
                             4'd15:{a,b,c,d,e,f,g}<=re_f;
                             endcase
                   
             4'd5:
                             case(led_7)
                             4'd0:{a,b,c,d,e,f,g}<=re_0;
                             4'd1:{a,b,c,d,e,f,g}<=re_1;
                             4'd2:{a,b,c,d,e,f,g}<=re_2;
                             4'd3:{a,b,c,d,e,f,g}<=re_3;
                             4'd4:{a,b,c,d,e,f,g}<=re_4;
                             4'd5:{a,b,c,d,e,f,g}<=re_5;
                             4'd6:{a,b,c,d,e,f,g}<=re_6;
                             4'd7:{a,b,c,d,e,f,g}<=re_7;
                             4'd8:{a,b,c,d,e,f,g}<=re_8;
                             4'd9:{a,b,c,d,e,f,g}<=re_9;
                             4'd10:{a,b,c,d,e,f,g}<=re_a;
                             4'd11:{a,b,c,d,e,f,g}<=re_b;
                             4'd12:{a,b,c,d,e,f,g}<=re_c;
                             4'd13:{a,b,c,d,e,f,g}<=re_d;
                             4'd14:{a,b,c,d,e,f,g}<=re_e;
                             4'd15:{a,b,c,d,e,f,g}<=re_f;
                             endcase
                   
             4'd6:
                             case(led_7)
                             4'd0:{a,b,c,d,e,f,g}<=re_0;
                             4'd1:{a,b,c,d,e,f,g}<=re_1;
                             4'd2:{a,b,c,d,e,f,g}<=re_2;
                             4'd3:{a,b,c,d,e,f,g}<=re_3;
                             4'd4:{a,b,c,d,e,f,g}<=re_4;
                             4'd5:{a,b,c,d,e,f,g}<=re_5;
                             4'd6:{a,b,c,d,e,f,g}<=re_6;
                             4'd7:{a,b,c,d,e,f,g}<=re_7;
                             4'd8:{a,b,c,d,e,f,g}<=re_8;
                             4'd9:{a,b,c,d,e,f,g}<=re_9;
                             4'd10:{a,b,c,d,e,f,g}<=re_a;
                             4'd11:{a,b,c,d,e,f,g}<=re_b;
                             4'd12:{a,b,c,d,e,f,g}<=re_c;
                             4'd13:{a,b,c,d,e,f,g}<=re_d;
                             4'd14:{a,b,c,d,e,f,g}<=re_e;
                             4'd15:{a,b,c,d,e,f,g}<=re_f;
                             endcase
                   
             4'd7:
                             case(led_8)
                             4'd0:{a,b,c,d,e,f,g}<=re_0;
                             4'd1:{a,b,c,d,e,f,g}<=re_1;
                             4'd2:{a,b,c,d,e,f,g}<=re_2;
                             4'd3:{a,b,c,d,e,f,g}<=re_3;
                             4'd4:{a,b,c,d,e,f,g}<=re_4;
                             4'd5:{a,b,c,d,e,f,g}<=re_5;
                             4'd6:{a,b,c,d,e,f,g}<=re_6;
                             4'd7:{a,b,c,d,e,f,g}<=re_7;
                             4'd8:{a,b,c,d,e,f,g}<=re_8;
                             4'd9:{a,b,c,d,e,f,g}<=re_9;
                             4'd10:{a,b,c,d,e,f,g}<=re_a;
                             4'd11:{a,b,c,d,e,f,g}<=re_b;
                             4'd12:{a,b,c,d,e,f,g}<=re_c;
                             4'd13:{a,b,c,d,e,f,g}<=re_d;
                             4'd14:{a,b,c,d,e,f,g}<=re_e;
                             4'd15:{a,b,c,d,e,f,g}<=re_f;
                             endcase
                   default:{a,b,c,d,e,f,g}<=7'b1111111;
             endcase
             end
         
    end
    
    
    
    
endmodule

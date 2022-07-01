


module RF(
     input clk,
     input rst_n,
     input [4:0] rR1,
     input [4:0] rR2,
     input [4:0] wR,
     input [1:0] wD_sel,
     input [31:0] alu_result,
     input [31:0] dram_data,//come from DRAM
     input [31:0] imm,
     input [31:0] pc4,
     input WE,
     
     output [31:0] rD1,
     output [31:0] rD2,
     output reg [31:0] wD
    );
    

    reg [31:0] reg_file[31:0];
    
    always@(*)
    begin
          case(wD_sel)
          2'b00:wD=alu_result;
          2'b01:wD=dram_data;
          2'b10:wD=imm;
          2'b11:wD=pc4;
          default:wD=32'b0;
          endcase
    end
    

    
    assign rD1=(rR1==5'b0)?32'b0:reg_file[rR1];
    assign rD2=(rR2==5'b0)?32'b0:reg_file[rR2];

    always@(posedge clk or negedge rst_n)
    begin
        if(!rst_n)
        begin
             reg_file[0]<=32'b0;
             reg_file[1]<=32'b0;
             reg_file[2]<=32'b0;
             reg_file[3]<=32'b0;
             reg_file[4]<=32'b0;
             reg_file[5]<=32'b0;
             reg_file[6]<=32'b0;
             reg_file[7]<=32'b0;
             reg_file[8]<=32'b0;
             reg_file[9]<=32'b0;
             reg_file[10]<=32'b0;
             reg_file[11]<=32'b0;
             reg_file[12]<=32'b0;
             reg_file[13]<=32'b0;
             reg_file[14]<=32'b0;
             reg_file[15]<=32'b0;
             reg_file[16]<=32'b0;
             reg_file[17]<=32'b0;
             reg_file[18]<=32'b0;
             reg_file[19]<=32'b0;
             reg_file[20]<=32'b0;
             reg_file[21]<=32'b0;
             reg_file[22]<=32'b0;
             reg_file[23]<=32'b0;
             reg_file[24]<=32'b0;
             reg_file[25]<=32'b0;
             reg_file[26]<=32'b0;
             reg_file[27]<=32'b0;
             reg_file[28]<=32'b0;
             reg_file[29]<=32'b0;
             reg_file[30]<=32'b0;
             reg_file[31]<=32'b0;
        end
        else if(WE) reg_file[wR]<=wD;
        else reg_file[0]<=32'b0;
        
    end
endmodule

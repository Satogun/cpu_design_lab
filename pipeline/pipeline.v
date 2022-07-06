
module pipeline(
     input clk,
     input rst_n,
     input [23:0] device_sw,
     output[23:0] device_led
    );
    wire clk_i;
    cpuclk tt(
        .clk_in1(clk),
        .clk_out1(clk_i)
       );
    
    pipe_cpu u_pipe
    (
       .clk(clk_i),
       .rst_n(rst_n),
       .device_led(device_led)
    );
    
    
endmodule

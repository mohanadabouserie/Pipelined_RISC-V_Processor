`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/03/2023 07:12:32 PM
// Design Name: 
// Module Name: CPU_TB
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module CPU_TB();
    
    reg rst, clk;
    CPU test ( .clk(clk) ,.rst(rst) );
    localparam clk_period = 10;
    
    initial 
        begin 
            clk = 1'b0;
            forever #(clk_period/2) clk = ~clk;
        end
    initial
        begin
            #clk_period; 
            rst = 1;
            
            #clk_period; 
            rst = 0;
            
            #(clk_period*95);
        
            $finish;
        end
    
endmodule

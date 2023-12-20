`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/13/2023 01:54:19 PM
// Design Name: 
// Module Name: nbit_reg
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

module nbit_reg #(parameter N = 32)(input clk, input reset, input load, input [N-1:0] D, output [N-1:0] Q
    );
    
    genvar i;
    wire [N-1:0]out;
    generate
        for(i=0;i<N;i=i+1)
            begin 
                mux_1bit mux_inst(D[i], Q[i], load, out[i]);
                DFlipFlop FF_inst(clk, reset, out[i], Q[i]);      
            end           
    endgenerate
endmodule

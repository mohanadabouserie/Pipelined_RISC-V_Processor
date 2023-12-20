`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/03/2023 06:00:49 PM
// Design Name: 
// Module Name: nbit_mux
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

module nbit_mux #(parameter N = 32)( input [N-1:0] A , input [N-1:0] B , input sel , output [N-1:0] out );
    genvar i;
    generate
        for(i=0; i<N; i=i+1)
            begin
                mux_1bit mux_1bit_inst(A[i], B[i], sel, out[i]);
            end
    endgenerate
endmodule

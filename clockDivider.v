`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/24/2023 12:34:46 AM
// Design Name: 
// Module Name: clockDivider
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


module clockDivider #(parameter n = 1 ) (input clk, rst, output reg clk_out);
    reg [31:0] count;
    always @ (posedge clk, posedge rst) 
        begin
            if (rst == 1'b1)
                count <= 0;
            else if (count == n-1)
                count <= 0;
            else
                count <= count + 1;
        end
    always @ (posedge clk, posedge rst) 
        begin
            if (rst)
                clk_out <= 1;
            else if (count == n-1)
                clk_out <= ~ clk_out;
        end
endmodule

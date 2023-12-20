`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/03/2023 05:52:24 PM
// Design Name: 
// Module Name: Reg_File
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


module Reg_File #(parameter N = 32) (input clk, rst, RegWrite, input [31:0] write_data, input [4:0] reg1, reg2, rd, output [31:0] reg1_data, reg2_data);
    reg [N-1:0] reg_file [31:0];
    integer i;

    always@(negedge clk)
    begin
        if (rst==1'b1)  
            begin
                for ( i = 0 ; i < 32 ; i= i+1)
                begin
                    reg_file[i] <= 0;
                end  
            end
        else 
            begin
                if(RegWrite == 1'b1 && rd != 0)
                    begin
                        reg_file[rd] <= write_data;
                    end 
            end       
    end
    assign reg1_data = reg_file[reg1];
    assign reg2_data = reg_file[reg2];
endmodule


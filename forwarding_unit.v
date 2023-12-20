`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/20/2023 04:21:56 PM
// Design Name: 
// Module Name: forwarding_unit
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


module forwarding_unit( input [4:0] ID_EX_rs1, ID_EX_rs2, MEM_WB_rd, input MEM_WB_CTRL_regwrite, output reg Forward_SelA, Forward_SelB);

    always@(*)
    
        begin 
        if ( (MEM_WB_CTRL_regwrite==1'b1) && (MEM_WB_rd != 0)  && (MEM_WB_rd ==  ID_EX_rs1) )
        Forward_SelA = 1'b1; 
        else 
        Forward_SelA = 1'b0;
        
        if ( (MEM_WB_CTRL_regwrite==1'b1) && ( MEM_WB_rd != 0) && ( MEM_WB_rd == ID_EX_rs2) )
        Forward_SelB = 1'b1;
        else 
        Forward_SelB = 1'b0;

        end
endmodule
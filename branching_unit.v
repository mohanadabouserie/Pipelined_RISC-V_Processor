`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/01/2023 06:35:55 PM
// Design Name: 
// Module Name: branching_unit
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


module branching_unit( input zeroflag , cf , sf , vf , branch , input [2:0] func3 , output reg branch_result );
    always@(*)
        begin
            case(func3) 
                `BR_BEQ : branch_result = branch && zeroflag;    
                `BR_BNE : branch_result = branch && ~zeroflag;          
                `BR_BLT : branch_result = branch && (sf != vf);            
                `BR_BGE : branch_result = branch && (sf == vf);         
                `BR_BLTU: branch_result = branch && ~cf;            
                `BR_BGEU: branch_result = branch && cf;  	
                
                default: branch_result = 0;
            endcase
        end
endmodule

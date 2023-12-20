`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/03/2023 06:04:08 PM
// Design Name: 
// Module Name: ALU_Control
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
`include "defines.v"

module ALU_Control(input [31:0] inst, input [3:0] ALUOp, output reg [4:0] ALU_Selection);
    always@(*)
        begin
            if(ALUOp == 4'b0000)
                begin
                    ALU_Selection = 5'b000_00; // lw and sw
                end
                
            else if (ALUOp == 4'b0001)
                begin
                    ALU_Selection = 5'b000_01; // all branching 
                end  
                
            else if (ALUOp == 4'b0010 && `funct3 == 3'b000 && inst[30] == 1'b0)  // additon 
                begin
                    ALU_Selection = 5'b000_00;
                end  
                
            else if (ALUOp == 4'b0010 && `funct3 == 3'b000 && inst[30] == 1'b1)  // subtraction 
                begin
                    ALU_Selection = 5'b000_01;
                end   
                
            else if (ALUOp == 4'b0010 && `funct3 == 3'b001 && inst[30] == 1'b0) // SLL 
                begin
                    ALU_Selection = 5'b010_01;
                end   
                
            else if (ALUOp == 4'b0010 && `funct3 == 3'b111 && inst[30] == 1'b0) // and
                begin
                    ALU_Selection = 5'b001_01;
                end   
                
            else if (ALUOp == 4'b0010 && `funct3 == 3'b110 && inst[30] == 1'b0) // or
                begin
                    ALU_Selection = 5'b001_00;
                end
            else if (ALUOp == 4'b0010 && `funct3 == 3'b100 ) // xor
                begin
                    ALU_Selection = 5'b001_11;
                end
            else if (ALUOp == 4'b0010 && `funct3 == 3'b101 && inst[30] ==1'b0 ) // SRL
                begin
                    ALU_Selection = 5'b010_00;
                end
            else if (ALUOp == 4'b0010 && `funct3 == 3'b101 && inst[30] ==1'b1 ) // SRA
                begin
                    ALU_Selection = 5'b010_10;
                end
             else if (ALUOp == 4'b0010 && `funct3 == 3'b010 ) // SLT
                begin
                    ALU_Selection = 5'b011_11;
                end    
             else if (ALUOp == 4'b0010 && `funct3 == 3'b011 ) // SLTU
                begin
                    ALU_Selection = 5'b011_01;
                end
             else if (ALUOp == 4'b0011 && `OPCODE == 5'b01101 ) // LUI
                begin
                    ALU_Selection = 5'b000_11;
                end
             else if (ALUOp == 4'b0011 && `OPCODE == 5'b00101 ) // AUIPC
                begin
                    ALU_Selection = 5'b000_00; // addition 
                end
             else if (ALUOp == 4'b0110 && `funct3 == 3'b000) // ADDI
                begin
                    ALU_Selection = 5'b000_00;
                end 
             else if (ALUOp == 4'b0110 && `funct3 == 3'b010) // SLTI
                begin
                    ALU_Selection = 5'b011_11;
                end
             else if (ALUOp == 4'b0110 && `funct3 == 3'b011) // SLTIU
                begin
                    ALU_Selection = 5'b011_01;
                end  
             else if (ALUOp == 4'b0110 && `funct3 == 3'b100) // XORI
                begin
                    ALU_Selection = 5'b001_11;
                end
             else if (ALUOp == 4'b0110 && `funct3 == 3'b110) // ORI
                begin
                    ALU_Selection = 5'b001_00;
                end               
             else if (ALUOp == 4'b0110 && `funct3 == 3'b111) // ANDI
                begin
                    ALU_Selection = 5'b001_01;
                end  
             else if (ALUOp == 4'b0110 && `funct3 == 3'b001) // SLLI
                begin
                    ALU_Selection = 5'b010_01;
                end    
             else if (ALUOp == 4'b0110 && `funct3 == 3'b101 && inst[30] == 1'b0) // SRLI
                begin
                    ALU_Selection = 5'b010_00;
                end  
             else if (ALUOp == 4'b0110 && `funct3 == 3'b101 && inst[30] == 1'b1) // SRAI
                begin
                    ALU_Selection = 5'b010_10;
                end     
              else if (ALUOp == 4'b0111 ) // jal and jalr
                begin
                    ALU_Selection = 5'b00000;
                end 
             else if (ALUOp == 4'b1001 && `funct3 == 3'b000) // mul extnesion start with mul
                begin
                    ALU_Selection = 5'b10000;
                end    
             else if (ALUOp == 4'b1001 && `funct3 == 3'b001) // mulh
                begin
                    ALU_Selection = 5'b10001;
                end
             else if (ALUOp == 4'b1001 && `funct3 == 3'b010) // mulhsu
                begin
                    ALU_Selection = 5'b10011;
                end 
             else if (ALUOp == 4'b1001 && `funct3 == 3'b011) // mulhu
                begin
                    ALU_Selection = 5'b10100;
                end  
             else if (ALUOp == 4'b1001 && `funct3 == 3'b100) // Div
                begin
                    ALU_Selection = 5'b10101;
                end  
             else if (ALUOp == 4'b1001 && `funct3 == 3'b101) // Divu
                begin
                    ALU_Selection = 5'b10110;
                end 
             else if (ALUOp == 4'b1001 && `funct3 == 3'b110) // Rem
                begin
                    ALU_Selection = 5'b10111;
                end  
             else if (ALUOp == 4'b1001 && `funct3 == 3'b111) // Remu
                begin
                    ALU_Selection = 5'b11000;
                end  
        end
endmodule

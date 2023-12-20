`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/03/2023 05:55:35 PM
// Design Name: 
// Module Name: Control_Unit
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

module Control_Unit( input [31:0] inst , output reg Branch, MemRead, MemtoReg, MemWrite, ALUSrc2, RegWrite,ALUSrc1,stop, jump , output reg [3:0] ALUOp);
always@(*) 
     begin
         case(`OPCODE) 
         `OPCODE_Arith_R : 
                begin
                    if (inst[25]== 1'b1) // mul extension 
                        begin
                            Branch = 1'b0;
                            MemRead = 1'b0;
                            MemtoReg = 1'b0;
                            ALUOp = 4'b1001;
                            MemWrite = 1'b0;
                            ALUSrc2 = 1'b0;
                            ALUSrc1 = 1'b0;
                            RegWrite = 1'b1;
                            stop = 1'b0;
                            jump = 1'b0;
                        end
                    else
                        begin
                            Branch = 1'b0;
                            MemRead = 1'b0;
                            MemtoReg = 1'b0;
                            ALUOp = 4'b0010;
                            MemWrite = 1'b0;
                            ALUSrc2 = 1'b0;
                            ALUSrc1 = 1'b0;
                            RegWrite = 1'b1;
                            stop = 1'b0;
                            jump = 1'b0;
                        end
                    end
          `OPCODE_Arith_I :
                    begin
                        Branch = 1'b0;
                        MemRead = 1'b0;
                        MemtoReg = 1'b0;
                        ALUOp = 4'b0110;
                        MemWrite = 1'b0;
                        ALUSrc2 = 1'b1;
                        ALUSrc1 = 1'b0;
                        RegWrite = 1'b1;
                        stop = 1'b0;
                        jump = 1'b0;
                    end
          `OPCODE_Load : 
                    begin
                        Branch = 1'b0;
                        MemRead = 1'b1;
                        MemtoReg = 1'b1;
                        ALUOp = 4'b0000;
                        MemWrite = 1'b0;
                        ALUSrc2 = 1'b1;
                        ALUSrc1 = 1'b0;
                        RegWrite = 1'b1;
                        stop = 1'b0;
                        jump = 1'b0;
                    end
           `OPCODE_Store : 
                    begin
                        Branch = 1'b0;
                        MemRead = 1'b0;
                        ALUOp = 4'b0000;
                        MemWrite = 1'b1;
                        ALUSrc2 = 1'b1;
                        ALUSrc1 = 1'b0;
                        RegWrite = 1'b0;
                        stop = 1'b0;
                        jump = 1'b0;
                    end
          `OPCODE_Branch : 
                    begin
                        Branch = 1'b1;
                        MemRead = 1'b0;
                        ALUOp = 4'b0001;
                        MemWrite = 1'b0;
                        ALUSrc2 = 1'b0;
                        ALUSrc1 = 1'b0;
                        RegWrite = 1'b0;
                        stop = 1'b0;
                        jump = 1'b0;
                    end
           `OPCODE_LUI :   
                    begin
                        Branch = 1'b0;
                        MemRead = 1'b0;
                        ALUOp = 4'b0011;
                        MemtoReg = 1'b0;
                        MemWrite = 1'b0;
                        ALUSrc2 = 1'b1;
                        ALUSrc1 = 1'b0;
                        RegWrite = 1'b1;
                        stop = 1'b0;
                        jump = 1'b0;
                    end
           `OPCODE_AUIPC :
                    begin
                        Branch = 1'b0;
                        MemRead = 1'b0;
                        ALUOp = 4'b0011;
                        MemtoReg = 1'b0;
                        MemWrite = 1'b0;
                        ALUSrc2 = 1'b1;
                        ALUSrc1 = 1'b1;
                        RegWrite = 1'b1;
                        stop = 1'b0;
                        jump = 1'b0;
                    end
            `OPCODE_Fence :
                    begin
                        Branch = 1'b0;
                        MemRead = 1'b0;
                        ALUOp = 4'b0000;
                        MemtoReg = 1'b0;
                        MemWrite = 1'b0;
                        ALUSrc2 = 1'b0;
                        ALUSrc1 = 1'b0;
                        RegWrite = 1'b0;
                        stop = 1'b0;
                        jump = 1'b0;
                    end
            `OPCODE_SYSTEM :
                    begin
                        if(inst[20])
                            begin
                                Branch = 1'b0;
                                MemRead = 1'b0;
                                ALUOp = 4'b0000;
                                MemtoReg = 1'b0;
                                MemWrite = 1'b0;
                                ALUSrc2 = 1'b0;
                                ALUSrc1 = 1'b0;
                                RegWrite = 1'b0;
                                stop = 1'b1; 
                                jump = 1'b0;
                            end
                        else
                            begin
                                Branch = 1'b0;
                                MemRead = 1'b0;
                                ALUOp = 4'b0000;
                                MemtoReg = 1'b0;
                                MemWrite = 1'b0;
                                ALUSrc2 = 1'b0;
                                ALUSrc1 = 1'b0;
                                RegWrite = 1'b0;
                                stop = 1'b0; 
                                jump = 1'b0;                        
                            end               
                    end
             `OPCODE_JALR : 
                    begin
                        Branch = 1'b0;
                        MemRead = 1'b0;
                        ALUOp = 4'b0111;
                        MemtoReg = 1'b0;
                        MemWrite = 1'b0;
                        ALUSrc2 = 1'b1;
                        ALUSrc1 = 1'b0;
                        RegWrite = 1'b1;
                        stop = 1'b0; 
                        jump = 1'b1;     
                    end
             `OPCODE_JAL : 
                    begin
                        Branch = 1'b0;
                        MemRead = 1'b0;
                        ALUOp = 4'b0111;
                        MemtoReg = 1'b0;
                        MemWrite = 1'b0;
                        ALUSrc2 = 1'b1;
                        ALUSrc1 = 1'b1;
                        RegWrite = 1'b1;
                        stop = 1'b0; 
                        jump = 1'b1;     
                    end
          endcase
      end
endmodule
`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/03/2023 06:10:54 PM
// Design Name: 
// Module Name: CPU
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


module CPU(input clk, rst);
   
   wire Branch, MemRead, MemtoReg, MemWrite, ALUSrc2, ALUSrc1, RegWrite, zeroflag, cf, sf, vf, stop, jump;
   wire [3:0] ALUOp;
   wire [31:0] reg1_data, reg2_data, gen_out, Alu_2nd_Input, Alu_output, Alu_1st_Input, Mem_Alu_MUX_out, write_data, inst;
   wire [4:0] ALU_Selection;
   wire branch_result;
   reg [31:0] PC;
   wire sclk;
   
   clockDivider cd( clk, rst,  sclk);
   
   always@(posedge sclk or posedge rst)
        begin
            if(rst == 1)
                begin
                    PC <= 0;
                end
            else
            begin
                if(EX_MEM_stop == 1)
                   PC <= PC;
                 else
                    begin
                        if(branch_result)
                            begin
                                PC <= EX_MEM_BranchAddOut ;
                            end
                         else if (EX_MEM_jump)
                             begin 
                                PC <= EX_MEM_ALU_out;
                             end
                         else
                             begin
                                PC <= PC + 4; 
                             end
                    end
                
            end
        end
   
   reg DM_MemRead, DM_EX_MEM_MemWrite;
   reg [7:0] DM_addr;
   reg [31:0] DM_data_in;
   reg [31:0] instruction, DM_data_out; 
   wire [31:0] data_out;
   
   always@(*)
    begin
        if(sclk == 1)
            begin
                DM_MemRead = 0;
                DM_EX_MEM_MemWrite = 0;
                DM_addr = PC[7:0];
                DM_data_in = 0;
                instruction = data_out;
                DM_data_out = DM_data_out;
            end
        else
            begin
                DM_MemRead = EX_MEM_MemRead;
                DM_EX_MEM_MemWrite = EX_MEM_MemWrite;
                DM_addr = EX_MEM_ALU_out[7:0];
                DM_data_in = EX_MEM_RegR2;
                instruction = instruction;
                DM_data_out = data_out;
            end
    end
    
   Data_Memory DM ( .clk(clk), .MemRead(DM_MemRead), .MemWrite(DM_EX_MEM_MemWrite), .addr(DM_addr), .data_in(DM_data_in), .data_out(data_out), .func3(EX_MEM_Inst[14:12]) );
   
   // IF/ID reg 
   wire [31:0] IF_ID_PC,IF_ID_Inst, Hazard_out, inst_MUX;
   
   //IF Stage
   
   nbit_mux stallMUX_IF ( .A(32'b00000000000000000000000000110011 ) , .B({instruction}) , .sel((branch_result || EX_MEM_jump) && sclk == 0) , .out(inst_MUX) ); 
   
   nbit_reg #(64) IF_ID (!sclk, rst, 1'b1, {PC,inst_MUX}, {IF_ID_PC, IF_ID_Inst} );
   
   // ID stage
   
   nbit_mux stallMUX_ID ( .A(32'd0) , .B({19'b0, Branch, MemRead, MemtoReg, MemWrite, ALUSrc2, ALUSrc1, RegWrite, stop, jump, ALUOp}) , .sel(branch_result || EX_MEM_jump) , .out(Hazard_out) );

   Control_Unit  CU ( .inst(IF_ID_Inst), .Branch(Branch), .MemRead(MemRead), .MemtoReg(MemtoReg), .MemWrite(MemWrite), .ALUSrc2(ALUSrc2), .ALUSrc1(ALUSrc1), .RegWrite(RegWrite), .ALUOp(ALUOp), .stop(stop), .jump(jump) );
   
   Reg_File RF ( .clk(clk), .rst(rst), .RegWrite(MEM_WB_RegWrite), .write_data(write_data), .reg1(IF_ID_Inst[19:15]), .reg2(IF_ID_Inst[24:20]), .rd(MEM_WB_Rd), .reg1_data(reg1_data), .reg2_data(reg2_data) );
   
   Imm_Gen  IMM_GEN ( .inst(IF_ID_Inst), .gen_out(gen_out) );
   
   //ID/EX reg 
   wire [31:0] ID_EX_PC, ID_EX_RegR1, ID_EX_RegR2, ID_EX_Imm, ID_EX_Inst, ForwardA_out, ForwardB_out; 
   wire ID_EX_Branch, ID_EX_MemRead, ID_EX_MemtoReg, ID_EX_MemWrite, ID_EX_ALUSrc2, ID_EX_ALUSrc1, ID_EX_RegWrite, ID_EX_stop, ID_EX_jump;  // control
   wire Forward_SelA, Forward_SelB;                                                                                                         // forward
   wire [3:0] ID_EX_ALUOp;                                                                                                                 // signals 
   wire [4:0] ID_EX_Rs1, ID_EX_Rs2, ID_EX_Rd; 
   wire [6:0] EX_Ctrl_MUX_result;
   nbit_reg #(188) ID_EX (sclk, rst, 1'b1, {Hazard_out[12:0], IF_ID_PC, reg1_data, reg2_data, gen_out, IF_ID_Inst, IF_ID_Inst[19:15], IF_ID_Inst[24:20], IF_ID_Inst[11:7]},
   {ID_EX_Branch, ID_EX_MemRead, ID_EX_MemtoReg, ID_EX_MemWrite, ID_EX_ALUSrc2, ID_EX_ALUSrc1, ID_EX_RegWrite, ID_EX_stop, ID_EX_jump,ID_EX_ALUOp,ID_EX_PC,ID_EX_RegR1,ID_EX_RegR2, ID_EX_Imm, ID_EX_Inst,ID_EX_Rs1,ID_EX_Rs2,ID_EX_Rd} ); 
   // EX stage
   ALU_Control ALU_C ( .inst(ID_EX_Inst), .ALUOp(ID_EX_ALUOp), .ALU_Selection(ALU_Selection) );
   
   forwarding_unit forward_unit( .ID_EX_rs1(ID_EX_Rs1), .ID_EX_rs2(ID_EX_Rs2), .MEM_WB_rd(MEM_WB_Rd), .MEM_WB_CTRL_regwrite(MEM_WB_RegWrite), .Forward_SelA(Forward_SelA), .Forward_SelB(Forward_SelB) );

   nbit_mux ForwardA(.A(write_data), .B(ID_EX_RegR1), .sel(Forward_SelA), .out(ForwardA_out));
   nbit_mux ForwardB(.A(write_data), .B(ID_EX_RegR2), .sel(Forward_SelB), .out(ForwardB_out));
   
   
   nbit_mux ALU_1ST_INPUT ( .A(ID_EX_PC), .B(ForwardA_out), .sel(ID_EX_ALUSrc1), .out(Alu_1st_Input) );

   nbit_mux ALU_2ND_INPUT ( .A(ID_EX_Imm), .B(ForwardB_out), .sel(ID_EX_ALUSrc2), .out(Alu_2nd_Input) );
   
   ALU alu ( .sel(ALU_Selection), .shamt(Alu_2nd_Input[4:0]), .R1(Alu_1st_Input), .R2(Alu_2nd_Input), .out(Alu_output), .zeroflag(zeroflag), .cf(cf), .vf(vf), .sf(sf) );
   
   nbit_mux stallMUX_EX ( .A(32'd0) , .B({25'b0, ID_EX_Branch, ID_EX_MemRead, ID_EX_MemtoReg, ID_EX_MemWrite, ID_EX_RegWrite, ID_EX_stop, ID_EX_jump}) , .sel(branch_result || EX_MEM_jump) , .out(EX_Ctrl_MUX_result) );
   
   // EX/MEM reg
   wire [31:0] EX_MEM_BranchAddOut, EX_MEM_ALU_out, EX_MEM_RegR2, EX_MEM_Inst, EX_MEM_PC; 
   wire EX_MEM_Branch, EX_MEM_MemRead, EX_MEM_MemtoReg, EX_MEM_MemWrite, EX_MEM_RegWrite, EX_MEM_stop, EX_MEM_jump;
   wire [4:0] EX_MEM_Rd; 
   wire EX_MEM_Zero, EX_MEM_cf, EX_MEM_vf,EX_MEM_sf;
   nbit_reg#(176) EX_MEM (!sclk,rst,1'b1,{EX_Ctrl_MUX_result,ID_EX_Inst,ID_EX_PC,{ID_EX_PC +ID_EX_Imm},zeroflag, cf, vf, sf, Alu_output, ForwardB_out, ID_EX_Rd},
   {EX_MEM_Branch, EX_MEM_MemRead, EX_MEM_MemtoReg, EX_MEM_MemWrite, EX_MEM_RegWrite, EX_MEM_stop, EX_MEM_jump,EX_MEM_Inst ,EX_MEM_PC,EX_MEM_BranchAddOut, EX_MEM_Zero, EX_MEM_cf, EX_MEM_vf,EX_MEM_sf, EX_MEM_ALU_out, EX_MEM_RegR2, EX_MEM_Rd} );
   // MEM stage
   branching_unit BU( .zeroflag( EX_MEM_Zero), .cf( EX_MEM_cf), .sf(EX_MEM_sf), .vf(EX_MEM_vf), .branch(EX_MEM_Branch), .func3(EX_MEM_Inst[14:12]), .branch_result(branch_result) );
   
   
   // MEM/WB reg
   wire [31:0] MEM_WB_Mem_out, MEM_WB_ALU_out ,MEM_WB_PC; 
   wire  MEM_WB_MemtoReg, MEM_WB_RegWrite, MEM_WB_jump ;
   wire [4:0] MEM_WB_Rd;
   nbit_reg #(104) MEM_WB (sclk,rst,1'b1,{EX_MEM_MemtoReg,EX_MEM_RegWrite,EX_MEM_jump,EX_MEM_PC,DM_data_out,EX_MEM_ALU_out, EX_MEM_Rd},
     {MEM_WB_MemtoReg, MEM_WB_RegWrite, MEM_WB_jump, MEM_WB_PC ,MEM_WB_Mem_out, MEM_WB_ALU_out, MEM_WB_Rd} );
   // WB stage
   nbit_mux Mem_ALU_MUX ( .A(MEM_WB_Mem_out), .B(MEM_WB_ALU_out), .sel(MEM_WB_MemtoReg), .out(Mem_Alu_MUX_out) );
   
   nbit_mux jump_MUX ( .A(MEM_WB_PC+4), .B(Mem_Alu_MUX_out), .sel(MEM_WB_jump), .out(write_data) );

endmodule

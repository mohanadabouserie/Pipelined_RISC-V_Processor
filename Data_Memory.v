`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/03/2023 06:05:20 PM
// Design Name: 
// Module Name: Data_Memory
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


module Data_Memory (input clk, input MemRead, input MemWrite, input [7:0] addr, input [31:0] data_in, output reg [31:0] data_out , input [2:0] func3 );
    reg [7:0] mem [0:4095];
    integer i;
    initial begin
        for(i = 0; i < 4095; i = i +1)
            begin
                mem[i] = 32'd0;
            end
//            $readmemh("C:/Users/AUC/OneDrive/Desktop/MS3_Code/project_1.srcs/sources_1/new/test_instructions.hex",mem);
//            $readmemh("C:/Users/AUC/OneDrive/Desktop/MS3_Code/project_1.srcs/sources_1/new/test_data_data.hex",mem,2048);

        //         test 1 data
//         {mem[2051], mem[2050], mem[2049], mem[2048]}=32'd17;
//         {mem[2055], mem[2054], mem[2053], mem[2052]} =32'd9;
//         {mem[2059], mem[2058], mem[2057], mem[2056]}=32'd25;
        
////         test 1 instructions
//         {mem[3], mem[2], mem[1], mem[0]}=    32'b0000000_00000_00000_000_00000_0110011 ; //add x0, x0, x0//added to be skipped since PC starts with 4 after reset 
//         {mem[7], mem[6], mem[5], mem[4]}=    32'b000000000000_00000_010_00001_0000011 ; //lw x1, 0(x0) 
//         {mem[11], mem[10], mem[9], mem[8]}=  32'b000000000100_00000_010_00010_0000011 ; //lw x2, 4(x0) 
//         {mem[15], mem[14], mem[13], mem[12]}=32'b000000001000_00000_010_00011_0000011 ; //lw x3, 8(x0) 
//         {mem[19], mem[18], mem[17], mem[16]}=32'b0000000_00010_00001_110_00100_0110011 ; //or x4, x1, x2 
//         {mem[23], mem[22], mem[21], mem[20]}=32'b00000000001100100000010001100011      ; //beq x4, x3, 8
//         {mem[27], mem[26], mem[25], mem[24]}=32'b0000000_00010_00001_000_00011_0110011 ; //add x3, x1, x2 
//         {mem[31], mem[30], mem[29], mem[28]}=32'b0000000_00010_00011_000_00101_0110011 ; //add x5, x3, x2 
//         {mem[35], mem[34], mem[33], mem[32]}=32'b0000000_00101_00000_010_01100_0100011; //sw x5, 12(x0)
//         {mem[39], mem[38], mem[37], mem[36]}=32'b000000001100_00000_010_00110_0000011 ; //lw x6, 12(x0)
//         {mem[43], mem[42], mem[41], mem[40]}=32'b0000000_00001_00110_111_00111_0110011 ; //and x7, x6, x1  
//         {mem[47], mem[46], mem[45], mem[44]}=32'b0100000_00010_00001_000_01000_0110011 ; //sub x8, x1, x2 
//         {mem[51], mem[50], mem[49], mem[48]}=32'b0000000_00010_00001_000_00000_0110011 ; //add x0, x1, x2 
//         {mem[55], mem[54], mem[53], mem[52]}=32'b0000000_00001_00000_000_01001_0110011 ; //add x9, x0, x1

        // test 2 instructions
        //  {mem[3], mem[2], mem[1], mem[0]}=32'b00000000000000001001010100010111; // auipc x10, 9
        //  {mem[7], mem[6], mem[5], mem[4]}=32'b00000000000000001001010010110111; // lui x9, 9 
        //  {mem[11], mem[10], mem[9], mem[8]}=32'b00000000010001010000010110010011; // addi x11, x10, 4
        //  {mem[15], mem[14], mem[13], mem[12]}=32'b00000000000001010000011000110011; //add x12, x10, x0 
        //  {mem[19], mem[18], mem[17], mem[16]}=32'b00000000100000000000000011101111; //jal ra,8
        //  {mem[23], mem[22], mem[21], mem[20]}=32'b00000000000100000000000001110011; // ebreak 
        //  {mem[27], mem[26], mem[25], mem[24]}=32'b00001000101101010000110001100011; //beq x10, x11, 152
        //  {mem[31], mem[30], mem[29], mem[28]}=32'b00000000101101010001010001100011 ;//bne x10, x11, 8
        //  {mem[35], mem[34], mem[33], mem[32]}=32'b00000000000000000000000001110011; // ecall 
        //  {mem[39], mem[38], mem[37], mem[36]}=32'b00000011001000000000001100010011; //addi x6, x0, 50
        //  {mem[43], mem[42], mem[41], mem[40]}=32'b00000000001000110001001100010011; //slli x6, x6, 2
        //  {mem[47], mem[46], mem[45], mem[44]}=32'b00000000001000000000001110010011 ; //addi x7, x0, 2
        //  {mem[51], mem[50], mem[49], mem[48]}=32'b00000000011100000000000000100011;//sb x7, 0(x0) 
        //  {mem[55], mem[54], mem[53], mem[52]}=32'b00000000101000000001000000100011; //sh x10, 0(x0)
        //  {mem[59], mem[58], mem[57], mem[56]}=32'b00000000101000000010000000100011; // sw x10, 0(x0)
        //  {mem[63], mem[62], mem[61], mem[60]}=32'b00000000000000000000111000000011; // lb x28, 0(x0)
        //  {mem[67], mem[66], mem[65], mem[64]}=32'b00000000000000000001111010000011;//lh x29, 0(x0)
        //  {mem[71], mem[70], mem[69], mem[68]}=32'b00000000000000000010111100000011; //lw x30, 0(x0)
        //  {mem[75], mem[74], mem[73], mem[72]}=32'b00000000000000000100111110000011; //lbu x31, 0(x0)
        //  {mem[79], mem[78], mem[77], mem[76]}=32'b00000000000000000101001100000011; //lhu x6, 0(x0)
        //  {mem[83], mem[82], mem[81], mem[80]}=32'b00000110101101100101000001100011; // bge x12, x11, 96
        //  {mem[87], mem[86], mem[85], mem[84]}=32'b00000100110001011100111001100011; //blt x11, x12, 92
        //  {mem[91], mem[90], mem[89], mem[88]}=32'b00000100101101100111110001100011; //bgeu x12, x11, 88
        //  {mem[95], mem[94], mem[93], mem[92]}=32'b00000100110001011110101001100011; //bltu x11, x12, 84
        //  {mem[99], mem[98], mem[97], mem[96]}=32'b11111001110001100011001100010011; //sltiu x6, x12, -100
        //  {mem[103], mem[102], mem[101], mem[100]}=32'b00000000001100110100111000010011; //xori x28, x6, 3
        //  {mem[107], mem[106], mem[105], mem[104]}=32'b00000000010111100110111000010011; //ori x28, x28, 5
        //  {mem[111], mem[110], mem[109], mem[108]}=32'b00000000010111100111111000010011; //andi x28, x28, 5
        //  {mem[115], mem[114], mem[113], mem[112]}=32'b00000000000111100101111000010011; //srli x28, x28, 1
        //  {mem[119], mem[118], mem[117], mem[116]}=32'b00000010100011100000111000010011; //addi x28, x28, 40
        //  {mem[123], mem[122], mem[121], mem[120]}=32'b01000000001011100101111000010011; //srai x28, x28, 2
        //  {mem[127], mem[126], mem[125], mem[124]}=32'b00000000001100000000001110010011; //addi x7, x0, 3
        //  {mem[131], mem[130], mem[129], mem[128]}=32'b01000000011111100000111000110011; // sub x28, x28, x7
        //  {mem[135], mem[134], mem[133], mem[132]}=32'b00000001110011100001111000110011; //sll x28, x28, x28
        //  {mem[139], mem[138], mem[137], mem[136]}=32'b00000001110011100010111100110011; //slt x30, x28, x28
        //  {mem[143], mem[142], mem[141], mem[140]}=32'b00000000011000000000111010010011; //addi x29, x0, 6
        //  {mem[147], mem[146], mem[145], mem[144]}=32'b00000001110011101011111100110011; //sltu x30, x29, x28
        //  {mem[151], mem[150], mem[149], mem[148]}=32'b00000001110111110100111100110011; //xor x30, x30, x29
        //  {mem[155], mem[154], mem[153], mem[152]}=32'b00000000010011110001111100010011; //slli x30, x30, 4
        //  {mem[159], mem[158], mem[157], mem[156]}=32'b00000000011111110101111100110011; //srl x30, x30, x7
        //  {mem[163], mem[162], mem[161], mem[160]}=32'b01000000011111110101111100110011; //sra x30, x30, x7
        //  {mem[167], mem[166], mem[165], mem[164]}=32'b00000000011111110110111100110011; //or x30, x30, x7
        //  {mem[171], mem[170], mem[169], mem[168]}=32'b00000001110111110111111100110011; //and x30, x30, x29
        //  {mem[175], mem[174], mem[173], mem[172]}=32'b00000000000000000000000000001111;// fence
        //  {mem[179], mem[178], mem[177], mem[176]}=32'b00000000000000001000000001100111; // jalr x0, 0(x1)
        


//         test 3 instructions
//         {mem[3], mem[2], mem[1], mem[0]} = 32'b00001100100000000000010110010011; // addi x11, x0, 200
//         {mem[7], mem[6], mem[5], mem[4]} = 32'b00000000111000000000111110010011; // addi x31, x0, 14
//         {mem[11], mem[10], mem[9], mem[8]} = 32'b00000001111101011010000000100011; // sw x31, 0(x11)
//         {mem[15], mem[14], mem[13], mem[12]} = 32'b00000001010100000000111110010011; // addi x31, x0, 21
//         {mem[19], mem[18], mem[17], mem[16]} = 32'b00000001111101011010001000100011; // sw x31, 4(x11)
//         {mem[23], mem[22], mem[21], mem[20]} = 32'b11111111101100000000111110010011; // addi x31, x0, -5
//         {mem[27], mem[26], mem[25], mem[24]} = 32'b00000001111101011010010000100011; // sw x31, 8(x11)
//         {mem[31], mem[30], mem[29], mem[28]} = 32'b00000000011100000000111110010011; // addi x31, x0, 7
//         {mem[35], mem[34], mem[33], mem[32]} = 32'b00000001111101011010011000100011; // sw x31, 12(x11)
//         {mem[39], mem[38], mem[37], mem[36]} = 32'b00000000010000000000011000010011; // addi x12, x0, 4
//         {mem[43], mem[42], mem[41], mem[40]} = 32'b00000000100000000000000011101111; // jal x1, 8
//         {mem[47], mem[46], mem[45], mem[44]} = 32'b00000000000100000000000001110011; // Ebreak
//         {mem[51], mem[50], mem[49], mem[48]} = 32'b00000000000001011010010100000011; // lw x10, 0(x11)
//         {mem[55], mem[54], mem[53], mem[52]} = 32'b00000000000000000000001100010011; // addi x6, x0, 0
//         {mem[59], mem[58], mem[57], mem[56]} = 32'b00000000001000110001001110010011; // slli x7, x6, 2
//         {mem[63], mem[62], mem[61], mem[60]} = 32'b00000000101100111000001110110011; // add x7, x7, x11
//         {mem[67], mem[66], mem[65], mem[64]} = 32'b00000000000000111010001110000011; // lw x7, 0(x7)
//         {mem[71], mem[70], mem[69], mem[68]} = 32'b00000000011101010101010001100011; // bge x10, x7, 8
//         {mem[75], mem[74], mem[73], mem[72]} = 32'b00000000000000111000010100010011; // addi x10, x7, 0
//         {mem[79], mem[78], mem[77], mem[76]} = 32'b00000000000100110000001100010011; // addi x6, x6, 1
//         {mem[83], mem[82], mem[81], mem[80]} = 32'b11111110110000110100010011100011; // blt x6, x12, -24
//         {mem[87], mem[86], mem[85], mem[84]} = 32'b00000000000000001000000001100111; // jalr x0, 0(x1)

        
//         test 4 instructions
//       {mem[3], mem[2], mem[1], mem[0]}=32'b00000000000000100000000010110111; // lui x1, 32
//       {mem[7], mem[6], mem[5], mem[4]}=32'b11111111111111101001000100110111; // lui x2, -23
//       {mem[11], mem[10], mem[9], mem[8]}=32'b00000010001000001000000110110011; // mul x3, x1, x2
//       {mem[15], mem[14], mem[13], mem[12]}=32'b00000010001000001001001000110011; // mulh x4, x1, x2
//       {mem[19], mem[18], mem[17], mem[16]}=32'b00000010001000001010001010110011;//mulhsu x5 , x1, x2
//       {mem[23], mem[22], mem[21], mem[20]}=32'b00000010000100010010001100110011; //mulhsu x6 , x2, x1
//       {mem[27], mem[26], mem[25], mem[24]}=32'b00000010001000001011001110110011; //mulhu  x7, x1, x2
//       {mem[31], mem[30], mem[29], mem[28]}=32'b00000010001000001100010000110011; //div    x8, x1, x2
//       {mem[35], mem[34], mem[33], mem[32]}=32'b00000010000100010100010010110011;//div    x9, x2, x1
//       {mem[39], mem[38], mem[37], mem[36]}=32'b00000010001000001101010100110011;//divu   x10, x1, x2
//       {mem[43], mem[42], mem[41], mem[40]}=32'b00000010000100010101010110110011;//divu   x11, x2, x1
//       {mem[47], mem[46], mem[45], mem[44]}=32'b00000010001000001110011000110011; //rem    x12, x1, x2
//       {mem[51], mem[50], mem[49], mem[48]}=32'b00000010000100010110011010110011; //rem    x13, x2, x1
//       {mem[55], mem[54], mem[53], mem[52]}=32'b00000010001000001111011100110011; //remu   x14, x1, x2
//       {mem[59], mem[58], mem[57], mem[56]}=32'b00000010000100010111011110110011;//remu   x15, x2, x1

    end
    
    always@(posedge clk)
         begin
            if(MemWrite == 1)
                case(func3)
                    3'b010:  
                        begin
                            {mem[addr + 3 + 2048], mem[addr + 2 + 2048], mem[addr + 1 + 2048], mem[addr + 2048]} = data_in;
                        end 
                    3'b001:  
                        begin
                            {mem[addr + 1 + 2048], mem[addr + 2048]} = data_in[15:0];
                        end
                    3'b000:  
                        begin
                            mem[addr + 2048] = data_in[7:0];
                        end  
                endcase
         end
    
    always@(*)
        begin
            if(MemRead == 1)
                case(func3)
                    3'b010:  
                        begin
                            data_out = {mem[addr + 3 + 2048], mem[addr + 2 + 2048], mem[addr + 1 + 2048], mem[addr + 2048]};
                        end 
                    3'b101:  
                        begin
                            data_out = {mem[addr + 1 + 2048], mem[addr + 2048]};
                        end
                    3'b100:  
                        begin
                            data_out = mem[addr + 2048];
                        end 
                    3'b001:  
                        begin
                            data_out = $signed({mem[addr + 1 + 2048], mem[addr + 2048]});
                        end   
                    3'b000:
                        begin
                            data_out = $signed(mem[addr + 2048]);
                        end 
                endcase
            else if(MemRead == 0 && MemWrite == 0)
                begin
                    data_out = {mem[addr + 3], mem[addr + 2], mem[addr + 1], mem[addr]};
                end
            else
                begin
                    data_out = 0;
                end
        end
endmodule

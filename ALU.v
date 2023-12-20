`timescale 1ns / 1ps

module ALU #(parameter N = 32)( input wire [4:0] sel,input wire [4:0] shamt, input wire [N-1:0] R1, R2, output reg [N-1:0] out , output wire zeroflag,cf,vf,sf);

    wire [N-1:0] result, op_R2, sh;
    wire [32:0] unsigned_R1 , unsigned_R2;
    wire [63:0] Rv64_R1, Rv64_R2, Rv64_unsigned_R2, Rv64_unsigned_R1;
    assign op_R2 = (~R2);
    assign {cf, result} = sel[0] ? (R1 + op_R2 + 1'b1) : (R1 + R2);
    assign zeroflag = (result == 0);
    assign sf = result[31];
    assign vf = (R1[31] ^ (op_R2[31]) ^ result[31] ^ cf); 
    Shifter shifter(.A(R1), .shamt(shamt), .type(sel[1:0]),  .out(sh));
    
    wire [31:0] div, divu, rem, remu;
    wire [63:0] mul, mulhsu, mulh;
    assign mul = R1*R2 ;
    assign mulh = $signed(R1)*$signed(R2);
    assign mulhsu = $signed(R1)*R2;
    assign div = $signed(R1)/$signed(R2);
    assign divu = R1/R2;
    assign rem = $signed(R1)%$signed(R2);
    assign remu = R1%R2;
    
    assign Rv64_R1 = {{32{R1[31]}},R1};
    assign Rv64_unsigned_R2 = {32'b0,R2};
   
    always@(*)
        begin
            case(sel)
                5'b000_00 : out = result;  // done 
                5'b000_01 : out = result; // done
                5'b000_11 : out = R2;  // lui //done
                // logic
                5'b001_00:  out = R1 | R2;  // done
                5'b001_01:  out = R1 & R2;  // done
                5'b001_11:  out = R1 ^ R2; // done
                // shift
                5'b010_00:  out = sh;  //done
                5'b010_01:  out = sh; // done
                5'b010_10:  out = sh; // done
                // slt & sltu
                5'b011_11:  out = {31'b0,(sf != vf)};  //slt // done
                5'b011_01:  out = {31'b0,(~cf)};       //sltu   // done 
                
                // mul extension start 
                5'b100_00:  out = mul[31:0]; // mul   //done
                5'b100_01:  out = mulh[63:32] ;// mulh  //done
                5'b100_11:  out = (Rv64_R1 * Rv64_unsigned_R2) >> 32  ;// mulhsu  //done
	            5'b101_00:  out = mul[63:32] ; // mulhu  //done
                5'b101_01:  out = div; //div  //done
                5'b101_10:  out = divu; // divu  //done
                5'b101_11:  out = rem; // Rem  //done
                5'b110_00:  out = remu; // Remu  //done 
                
                default: out = 0;
            endcase
        end
endmodule
`timescale 1ns / 1ps


module mux_1bit(input A, input B, input sel, output C);
    assign C = (sel) ? A : B ;
endmodule

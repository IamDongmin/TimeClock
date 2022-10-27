`timescale 1ns / 1ps

module DigitDivider(
    input [6:0] i_a, i_b,

    output [3:0] o_1a, o_10a, o_1b, o_10b
    );

    assign o_1a  = i_a % 10;
    assign o_10a = i_a / 10 % 10;
    assign o_1b  = i_b % 10;
    assign o_10b = i_b / 10 % 10;
endmodule


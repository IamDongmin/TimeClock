`timescale 1ns / 1ps

module Mux_2x1(
    input [3:0] i_a, i_b,
    input i_select,
    output [3:0] o_clockvalue
    );

    reg [3:0] r_clockvalue;

    assign o_clockvalue = r_clockvalue;

    always @(*) begin
        case (i_select)
            1'b0 : r_clockvalue <= i_a;
            1'b1 : r_clockvalue <= i_b;
        endcase
    end
endmodule

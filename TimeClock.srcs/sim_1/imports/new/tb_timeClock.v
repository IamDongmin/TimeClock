`timescale 1ns / 1ps


module tb_timeClock();

    reg i_clk = 0;
    reg i_reset = 0;
    reg i_mode_SW = 0;

    wire [3:0] o_digitPosition;
    wire [7:0] o_fndfont;

    top_TimeClock dut(
        .i_clk(i_clk),
        .i_reset(i_reset),
        .i_mode_SW(i_mode_SW),
        .o_digitPosition(o_digitPosition),
        .o_fndfont(o_fndfont)
    );

    always #1 i_clk = ~i_clk;

    initial begin
        #00 i_mode_SW = 1'b0;
        #10000 i_mode_SW = 1'b1;
        #10000 i_mode_SW = 1'b0;
        #10000 i_mode_SW = 1'b1;
        #10000 i_mode_SW = 1'b0;
        #10000 $finish;
    end
endmodule

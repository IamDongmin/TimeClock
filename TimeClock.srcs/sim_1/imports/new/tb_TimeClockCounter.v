`timescale 1ns / 1ps


module tb_TimeClockCounter();

    reg i_clk = 1'b0, i_reset;
    // wire w_clk;
    wire [5:0] o_hour, o_min, o_sec;
    wire [6:0] o_msec;

    // Clock_Divider dut0(
    //     .i_clk(i_clk),
    //     .i_reset(i_reset),
    //     .o_clk(w_clk)
    // );

    TimeClockCounter dut1(
        .i_clk(i_clk),
        .i_reset(i_reset),
        .o_hour(o_hour),
        .o_min(o_min),
        .o_sec(o_sec),
        .o_msec(o_msec)
    );

    always #1 i_clk = ~i_clk;

    initial begin
        #00 i_reset = 1'b0;
        #10000 $finish;
    end

endmodule

`timescale 1ns / 1ps

module top_TimeClock(
    input i_clk,
    input i_reset,
    input i_mode_SW,
    input i_en,
    input i_enTriBuff,

    output [3:0] o_digitPosition,
    output [7:0] o_fndfont
    );

    wire w_clk_1hz;
    wire [2:0] w_counter;
    wire [6:0] w_hour, w_min, w_sec, w_msec;
    wire [3:0] w_hour10, w_hour1, w_min10, w_min1;
    wire [3:0] w_sec10, w_sec1, w_msec10, w_msec1;
    wire [3:0] w_y0, w_y1;
    wire [3:0] w_clockvalue;

    Clock_Divider clk_div(
        .i_clk(i_clk),
        .i_reset(i_reset),
        .o_clk(w_clk_1hz)
    );

    CounterFND cntFND(
        .i_clk(w_clk_1hz),
        .i_reset(i_reset),
        .o_counter(w_counter)
    );

    DecoderFNDDigit Decoder2x4(
        .i_select(w_counter),
        .i_en(i_en),
        .o_digitPosition(w_digitPosition)
    );

    wire [3:0] w_digitPosition;

    TriBuff TriBuff(
        .i_x(w_digitPosition),
        .i_en(i_enTriBuff),
        .o_y(o_digitPosition)
    );

    TimeClockCounter timeclkcnt(
        .i_clk(w_clk_1hz),
        .i_reset(i_reset),
        .o_hour(w_hour),
        .o_min(w_min),
        .o_sec(w_sec),
        .o_msec(w_msec)
    );

    DigitDivider digit_div_hourmin(
        .i_a(w_min),
        .i_b(w_hour),
        .o_1a(w_min1),
        .o_10a(w_min10),
        .o_1b(w_hour1),
        .o_10b(w_hour10)
    );

    wire [3:0] w_fndDP;

    Comparator cmp(
        .i_msec(w_msec),
        .o_fndDP(w_fndDP)
    );

    Mux_8x1 mux_8x1_dut0(
        .i_a(w_min1),
        .i_b(w_min10),
        .i_c(w_hour1),
        .i_d(w_hour10),
        .i_select(w_counter),
        .i_a1(11),
        .i_b1(11),
        .i_c1(w_fndDP),
        .i_d1(11),
        .o_y(w_y0)
    );

    DigitDivider digit_div_secmsec(
        .i_a(w_msec),
        .i_b(w_sec),
        .o_1a(w_msec1),
        .o_10a(w_msec10),
        .o_1b(w_sec1),
        .o_10b(w_sec10)
    );


    Mux_8x1 mux_8x1_dut1(
        .i_a(w_msec1),
        .i_b(w_msec10),
        .i_c(w_sec1),
        .i_d(w_sec10),
        .i_select(w_counter),
        .i_a1(11),
        .i_b1(11),
        .i_c1(w_fndDP),
        .i_d1(11),
        .o_y(w_y1)
    );

    Mux_2x1 mux_2x1_0(
        .i_a(w_y1),
        .i_b(w_y0),
        .i_select(i_mode_SW),
        .o_clockvalue(w_clockvalue)
    );

    BCDtoFND_Decoder BCDtoFND(
        .i_clockvalue(w_clockvalue),
        .i_en(i_en),
        .o_fndfont(o_fndfont)
    );
endmodule

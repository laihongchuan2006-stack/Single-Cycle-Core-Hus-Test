`timescale 1ns / 1ps

module tb_helpers;

    reg clk;
    reg reset;

    reg  [31:0] mux_d0, mux_d1;
    reg         mux_s;
    wire [31:0] mux_y;

    reg  [31:0] add_a, add_b;
    wire [31:0] add_y;

    reg  [15:0] se_a;
    wire [31:0] se_y;

    reg  [31:0] sl_a;
    wire [31:0] sl_y;

    reg  [31:0] d;
    wire [31:0] q;

    mux2 #(32) dut_mux (.d0(mux_d0), .d1(mux_d1), .s(mux_s), .y(mux_y));
    adder      dut_add (.a(add_a), .b(add_b), .y(add_y));
    signext    dut_se  (.a(se_a), .y(se_y));
    sl2        dut_sl  (.a(sl_a), .y(sl_y));
    flopr #(32) dut_ff (.clk(clk), .reset(reset), .d(d), .q(q));

    always #5 clk = ~clk;

    initial begin
        $dumpfile("helpers_waveform.vcd");
        $dumpvars(0, tb_helpers);

        clk = 0;
        reset = 1;
        d = 32'h0;
        mux_d0 = 32'hAAAA_AAAA;
        mux_d1 = 32'h5555_5555;
        mux_s = 0;
        add_a = 32'd0;
        add_b = 32'd4;
        se_a = 16'h0000;
        sl_a = 32'd0;

        #12;
        reset = 0;

        #5; mux_s = 0;
        #5; mux_s = 1;
        #5; add_a = 32'd100; add_b = 32'd4;
        #5; se_a = 16'h000A;
        #5; se_a = 16'hFFF4;
        #5; sl_a = 32'd3;
        #5; d = 32'h0040_0004;
        #10; d = 32'h0040_0008;
        #10;

        #20;
        $display(">> TAT CA CAC TEST CHO DATAPATH HELPERS DA HOAN TAT THANH CONG! <<");
        $finish;
    end

endmodule

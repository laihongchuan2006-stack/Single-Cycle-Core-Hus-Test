`timescale 1ns / 1ps

module dmem (
    input  wire        clk,
    input  wire        we,
    input  wire [31:0] a,
    input  wire [31:0] wd,
    output wire [31:0] rd
);
    reg [31:0] RAM [0:63];
    integer i;

    initial begin
        for (i = 0; i < 64; i = i + 1)
            RAM[i] = 32'h00000000;
    end

    assign rd = RAM[a[7:2]]; // Word-aligned read

    always @(posedge clk) begin
        if (we) RAM[a[7:2]] <= wd;
    end
endmodule

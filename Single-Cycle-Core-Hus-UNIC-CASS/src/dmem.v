`timescale 1ns / 1ps

module dmem (
    input  wire        clk,
    input  wire        we,
    input  wire [31:0] a,
    input  wire [31:0] wd,
    output wire [31:0] rd
);
    // 32 words x 32-bit (addresses 0..124, bao gom dia chi 80 va 84)
    // Giam 50% so luong Flip-Flop giup UNIC-CASS Place & Route chay nhanh va khong bi nghen day
    reg [31:0] RAM [0:31];

    assign rd = RAM[a[6:2]]; // Word-aligned asynchronous read

    always @(posedge clk) begin
        if (we)
            RAM[a[6:2]] <= wd;
    end

endmodule

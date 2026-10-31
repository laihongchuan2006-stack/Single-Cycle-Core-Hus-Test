`timescale 1ns / 1ps

module imem (
    input  wire [31:0] a,
    output reg  [31:0] rd
);
    // Hardcoded ROM cho Yosys ASIC Synthesis & Simulation
    always @(*) begin
        case (a[7:2])
            6'd0:  rd = 32'h20020005; // addi $2, $0, 5
            6'd1:  rd = 32'h2003000c; // addi $3, $0, 12
            6'd2:  rd = 32'h2067fff7; // addi $7, $3, -9
            6'd3:  rd = 32'h00e22025; // or   $4, $7, $2
            6'd4:  rd = 32'h00642824; // and  $5, $3, $4
            6'd5:  rd = 32'h00a42820; // add  $5, $5, $4
            6'd6:  rd = 32'h10a7000a; // beq  $5, $7, end
            6'd7:  rd = 32'h0064202a; // slt  $4, $3, $4
            6'd8:  rd = 32'h10800001; // beq  $4, $0, around
            6'd9:  rd = 32'h20050000; // addi $5, $0, 0
            6'd10: rd = 32'h00e2202a; // slt  $4, $7, $2
            6'd11: rd = 32'h00853820; // add  $7, $4, $5
            6'd12: rd = 32'h00e23822; // sub  $7, $7, $2
            6'd13: rd = 32'hac670044; // sw   $7, 68($3)   -> RAM[80] = 7
            6'd14: rd = 32'h8c020050; // lw   $2, 80($0)   -> $2 = 7
            6'd15: rd = 32'h08000011; // j    end
            6'd16: rd = 32'h20020001; // addi $2, $0, 1
            6'd17: rd = 32'hac020054; // sw   $2, 84($0)   -> RAM[84] = 7
            default: rd = 32'h00000000;
        endcase
    end

endmodule

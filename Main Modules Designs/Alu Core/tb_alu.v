`timescale 1ns / 1ps

module tb_alu;

    reg  [1:0]  ALUOp;
    reg  [5:0]  Funct;
    wire [2:0]  ALUControl;
    reg  [31:0] SrcA, SrcB;
    wire [31:0] ALUResult;
    wire        Zero;

    alu_decoder u_dec (
        .ALUOp(ALUOp),
        .Funct(Funct),
        .ALUControl(ALUControl)
    );

    alu u_alu (
        .SrcA(SrcA),
        .SrcB(SrcB),
        .ALUControl(ALUControl),
        .ALUResult(ALUResult),
        .Zero(Zero)
    );

    initial begin
        $dumpfile("alu_waveform.vcd");
        $dumpvars(0, tb_alu);

        $display("--- BAT DAU TESTBENCH ALU & ALU DECODER ---");
        SrcA = 32'd15;
        SrcB = 32'd10;

        // Test ADD via ALUOp = 00
        ALUOp = 2'b00; Funct = 6'bxxxxxx; #10;
        if (ALUResult === 32'd25) $display("[PASS] ALU ADD (lw/sw/addi): 15 + 10 = %0d", ALUResult);

        // Test SUB via ALUOp = 01 (beq)
        ALUOp = 2'b01; SrcA = 32'd20; SrcB = 32'd20; #10;
        if (ALUResult === 32'd0 && Zero === 1'b1) $display("[PASS] ALU SUB & Zero Flag (beq): 20 - 20 = 0, Zero = %b", Zero);

        // Test R-type AND
        ALUOp = 2'b10; Funct = 6'b100100; SrcA = 32'hF0F0_F0F0; SrcB = 32'h0F0F_00FF; #10;
        if (ALUResult === 32'h0000_00F0) $display("[PASS] ALU R-type AND");

        // Test R-type OR
        ALUOp = 2'b10; Funct = 6'b100101; #10;
        if (ALUResult === 32'hFFFF_F0FF) $display("[PASS] ALU R-type OR");

        // Test R-type SLT (Signed comparison: -5 < 3)
        ALUOp = 2'b10; Funct = 6'b101010; SrcA = -32'sd5; SrcB = 32'sd3; #10;
        if (ALUResult === 32'd1) $display("[PASS] ALU R-type SLT (-5 < 3 -> 1)");

        $display("--- HOAN THANH TESTBENCH ALU ---");
        $finish;
    end

endmodule

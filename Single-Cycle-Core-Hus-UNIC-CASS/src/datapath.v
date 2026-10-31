`timescale 1ns / 1ps

module datapath (
    input  wire        clk,
    input  wire        reset,
    input  wire        memtoreg,
    input  wire        pcsrc,
    input  wire        alusrc,
    input  wire        regdst,
    input  wire        regwrite,
    input  wire        jump,
    input  wire [2:0]  alucontrol,
    output wire        zero,
    output wire [31:0] pc,
    input  wire [31:0] instr,
    output wire [31:0] aluresult,
    output wire [31:0] writedata,
    input  wire [31:0] readdata
);

    wire [4:0]  writereg;
    wire [31:0] pcnext, pcnextbr, pcplus4, pcbranch;
    wire [31:0] signimm, signimmsh;
    wire [31:0] srca, srcb;
    wire [31:0] result;
    wire [31:0] pcjump;

    // 1. Logic cap nhat PC
    flopr #(32) pcreg (
        .clk(clk),
        .reset(reset),
        .d(pcnext),
        .q(pc)
    );

    adder pcadd1 (
        .a(pc),
        .b(32'd4),
        .y(pcplus4)
    );

    sl2 immsh (
        .a(signimm),
        .y(signimmsh)
    );

    adder pcadd2 (
        .a(pcplus4),
        .b(signimmsh),
        .y(pcbranch)
    );

    mux2 #(32) pcbrmux (
        .d0(pcplus4),
        .d1(pcbranch),
        .s(pcsrc),
        .y(pcnextbr)
    );

    assign pcjump = {pcplus4[31:28], instr[25:0], 2'b00};

    mux2 #(32) pcmux (
        .d0(pcnextbr),
        .d1(pcjump),
        .s(jump),
        .y(pcnext)
    );

    // 2. Logic Register File
    regfile rf (
        .clk(clk),
        .we3(regwrite),
        .a1(instr[25:21]),
        .a2(instr[20:16]),
        .a3(writereg),
        .wd3(result),
        .rd1(srca),
        .rd2(writedata)
    );

    mux2 #(5) wrmux (
        .d0(instr[20:16]),
        .d1(instr[15:11]),
        .s(regdst),
        .y(writereg)
    );

    mux2 #(32) resmux (
        .d0(aluresult),
        .d1(readdata),
        .s(memtoreg),
        .y(result)
    );

    // 3. Sign Extend
    signext se (
        .a(instr[15:0]),
        .y(signimm)
    );

    // 4. ALU & Input Mux
    mux2 #(32) srcbmux (
        .d0(writedata),
        .d1(signimm),
        .s(alusrc),
        .y(srcb)
    );

    alu alu_inst (
        .SrcA(srca),
        .SrcB(srcb),
        .ALUControl(alucontrol),
        .ALUResult(aluresult),
        .Zero(zero)
    );

endmodule

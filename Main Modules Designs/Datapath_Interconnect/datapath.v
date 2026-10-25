`timescale 1ns / 1ps

module datapath (
    input  wire        clk,
    input  wire        reset,

    // Tin hieu dieu khien tu Control Unit
    input  wire        memtoreg,
    input  wire        pcsrc,
    input  wire        alusrc,
    input  wire        regdst,
    input  wire        regwrite,
    input  wire        jump,
    input  wire [2:0]  alucontrol,

    // Co trang thai tra ve cho Control Unit
    output wire        zero,

    // Giao tiep voi Instruction Memory
    output wire [31:0] pc,
    input  wire [31:0] instr,

    // Giao tiep voi Data Memory
    output wire [31:0] aluresult,
    output wire [31:0] writedata,
    input  wire [31:0] readdata
);

    // 1. Khai bao cac duong day noi bo (Internal Interconnect)
    wire [4:0]  writereg;
    wire [31:0] pcnext, pcnextbr, pcplus4, pcbranch;
    wire [31:0] signimm, signimmsh;
    wire [31:0] srca, srcb;
    wire [31:0] result;
    wire [31:0] pcjump;

    // 2. Logic cap nhat Program Counter (PC Logic)
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

    // 3. Logic Tap thanh ghi (Register File Logic)
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

    // 4. Mach mo rong dau (Sign Extension)
    signext se (
        .a(instr[15:0]),
        .y(signimm)
    );

    // 5. Logic Khoi tinh toan so hoc & logic (ALU Logic)
    mux2 #(32) srcbmux (
        .d0(writedata),
        .d1(signimm),
        .s(alusrc),
        .y(srcb)
    );

    // Khoi ALU (Dong bo ten chan voi Alu Core/alu.v theo Quy chuan Giao dien)
    alu alu_inst (
        .SrcA(srca),
        .SrcB(srcb),
        .ALUControl(alucontrol),
        .ALUResult(aluresult),
        .Zero(zero)
    );

endmodule

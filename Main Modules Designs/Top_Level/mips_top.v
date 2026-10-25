`timescale 1ns / 1ps

module mips_top (
    input  wire        clk,
    input  wire        reset,
    output wire [31:0] writedata,
    output wire [31:0] aluresult,
    output wire        memwrite,
    output wire [31:0] debug_pc,
    output wire [31:0] debug_instr
);

    wire [31:0] pc, instr, readdata;
    wire        memtoreg, alusrc, regdst, regwrite, jump, branch, zero, pcsrc;
    wire [1:0]  aluop;
    wire [2:0]  alucontrol;

    assign debug_pc    = pc;
    assign debug_instr = instr;
    assign pcsrc       = branch & zero;

    // 1. Khoi Main Control (Thanh vien 1)
    main_control u_main_ctrl (
        .op         (instr[31:26]),
        .reg_write  (regwrite),
        .reg_dst    (regdst),
        .alu_src    (alusrc),
        .branch     (branch),
        .mem_write  (memwrite),
        .mem_to_reg (memtoreg),
        .alu_op     (aluop),
        .jump       (jump)
    );

    // 2. Khoi ALU Decoder (Thanh vien 2)
    alu_decoder u_alu_dec (
        .ALUOp      (aluop),
        .Funct      (instr[5:0]),
        .ALUControl (alucontrol)
    );

    // 3. Khoi Datapath Interconnect & ALU (Thanh vien 3 & 4)
    datapath u_datapath (
        .clk        (clk),
        .reset      (reset),
        .memtoreg   (memtoreg),
        .pcsrc      (pcsrc),
        .alusrc     (alusrc),
        .regdst     (regdst),
        .regwrite   (regwrite),
        .jump       (jump),
        .alucontrol (alucontrol),
        .zero       (zero),
        .pc         (pc),
        .instr      (instr),
        .aluresult  (aluresult),
        .writedata  (writedata),
        .readdata   (readdata)
    );

    // 4. Khoi Instruction Memory
    imem u_imem (
        .a  (pc),
        .rd (instr)
    );

    // 5. Khoi Data Memory
    dmem u_dmem (
        .clk (clk),
        .we  (memwrite),
        .a   (aluresult),
        .wd  (writedata),
        .rd  (readdata)
    );

endmodule

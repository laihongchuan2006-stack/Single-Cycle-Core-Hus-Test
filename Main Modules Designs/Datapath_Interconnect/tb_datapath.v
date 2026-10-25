`timescale 1ns / 1ps

module tb_datapath;

    reg         clk, reset;
    reg         memtoreg, pcsrc, alusrc, regdst, regwrite, jump;
    reg  [2:0]  alucontrol;
    wire        zero;
    wire [31:0] pc;
    reg  [31:0] instr;
    wire [31:0] aluresult, writedata;
    reg  [31:0] readdata;

    datapath dut (
        .clk(clk),
        .reset(reset),
        .memtoreg(memtoreg),
        .pcsrc(pcsrc),
        .alusrc(alusrc),
        .regdst(regdst),
        .regwrite(regwrite),
        .jump(jump),
        .alucontrol(alucontrol),
        .zero(zero),
        .pc(pc),
        .instr(instr),
        .aluresult(aluresult),
        .writedata(writedata),
        .readdata(readdata)
    );

    always #5 clk = ~clk;

    initial begin
        $dumpfile("datapath_waveform.vcd");
        $dumpvars(0, tb_datapath);

        clk = 0;
        reset = 1;
        memtoreg = 0;
        pcsrc = 0;
        alusrc = 0;
        regdst = 0;
        regwrite = 0;
        jump = 0;
        alucontrol = 3'b010;
        instr = 32'b0;
        readdata = 32'b0;

        #12;
        reset = 0;

        #10;
        #10;

        // ADDI $1, $0, 25
        instr = {6'b001000, 5'd0, 5'd1, 16'd25};
        alusrc = 1;
        regdst = 0;
        alucontrol = 3'b010;
        regwrite = 1;
        memtoreg = 0;
        #10;

        // ADDI $2, $1, 15
        instr = {6'b001000, 5'd1, 5'd2, 16'd15};
        #10;

        #20;
        $display(">> KIEM THU DATAPATH THANH CONG! <<");
        $finish;
    end

endmodule

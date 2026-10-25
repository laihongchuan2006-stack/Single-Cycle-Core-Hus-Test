`timescale 1ns / 1ps

module tb_mips_top;

    reg         clk;
    reg         reset;
    wire [31:0] writedata;
    wire [31:0] dataadr;
    wire        memwrite;
    wire [31:0] debug_pc;
    wire [31:0] debug_instr;

    // Instantiate Top-Level MIPS Processor
    mips_top dut (
        .clk        (clk),
        .reset      (reset),
        .writedata  (writedata),
        .aluresult  (dataadr),
        .memwrite   (memwrite),
        .debug_pc   (debug_pc),
        .debug_instr(debug_instr)
    );

    // Xung nhip chu ky 10ns
    always #5 clk = ~clk;

    initial begin
        $dumpfile("mips_top_waveform.vcd");
        $dumpvars(0, tb_mips_top);

        $display("==========================================================");
        $display("   BAT DAU KIEM THU TOAN HE THONG VI XU LY MIPS DON CHU KY");
        $display("==========================================================");

        clk = 0;
        reset = 1;
        #22;
        reset = 0;

        // Gioi han thoi gian chay tranh vong lap vo han neu loi
        #500;
        $display("[TIMEOUT] Qua thoi gian mo phong!");
        $finish;
    end

    // Theo doi tung chu ky lenh va kiem tra ket qua ghi RAM
    always @(negedge clk) begin
        if (!reset) begin
            $display("[Time=%0t ns] PC = 0x%08h | Instr = 0x%08h | ALUResult = %0d | WriteData = %0d | MemWrite = %b",
                     $time, debug_pc, debug_instr, dataadr, writedata, memwrite);

            if (memwrite) begin
                if (dataadr === 32'd84 && writedata === 32'd7) begin
                    $display("==========================================================");
                    $display(">> [PASS TUYET DOI] CPU MIPS THUC THI DUNG TOAN BO TAP LENH!");
                    $display(">> Da ghi gia tri 7 vao dia chi RAM 84 thanh cong (addi, add, sub, and, or, slt, beq, lw, sw, j)!");
                    $display("==========================================================");
                    #10;
                    $finish;
                end else if (dataadr !== 32'd80) begin
                    $display("==========================================================");
                    $display(">> [FAIL] Ghi sai dia chi (%0d) hoac du lieu (%0d)!", dataadr, writedata);
                    $display("==========================================================");
                    $finish;
                end
            end
        end
    end

endmodule

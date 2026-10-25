`timescale 1ns / 1ps

module alu_decoder (
    input  wire [1:0] ALUOp,      
    input  wire [5:0] Funct,      
    output reg  [2:0] ALUControl  
);

    always @(*) begin
        casez (ALUOp)
            2'b00: ALUControl = 3'b010;  // ADD (lw, sw, addi)
            2'b?1: ALUControl = 3'b110;  // SUB (beq)
            2'b1?: begin                 // R-type
                case (Funct)
                    6'b100000: ALUControl = 3'b010; // add
                    6'b100010: ALUControl = 3'b110; // sub
                    6'b100100: ALUControl = 3'b000; // and
                    6'b100101: ALUControl = 3'b001; // or
                    6'b101010: ALUControl = 3'b111; // slt
                    default:   ALUControl = 3'b000;
                endcase
            end
            default: ALUControl = 3'b000;
        endcase
    end

endmodule

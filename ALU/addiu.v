`timescale 1ns / 1ps

module addi(unsigned input [31:0] a, input [15:0] imm, unsigned output reg [31:0] out);

always @(*) begin
  out = a + {{16{imm[15]}}, imm}; // Sign-extend the immediate value
end

endmodule
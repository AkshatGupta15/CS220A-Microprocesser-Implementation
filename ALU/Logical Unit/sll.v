`timescale 1ns / 1ps

module sll (output reg [31:0] out, input [31:0] A, input [15:0] sa);

  always @(*) begin
    out = A << {{16{sa[15]}}, sa};
  end

endmodule
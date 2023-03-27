`timescale 1ns / 1ps

module slt(
  input [31:0] a,
  input [15:0] imm,
  output reg result
);
  
  // Compare the two inputs and set the result flag
  always @(*) begin
    if(a < {{16{imm[15]}}, imm}) begin
      result = 1;
    end
    else begin
      result = 0;
    end
  end
  
endmodule

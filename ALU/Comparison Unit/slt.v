`timescale 1ns / 1ps

module slt(
  input [31:0] a,
  input [31:0] b,
  output reg result
);
  
  // Compare the two inputs and set the result flag
  always @(*) begin
    if(a < b) begin
      result = 1;
    end
    else begin
      result = 0;
    end
  end
  
endmodule

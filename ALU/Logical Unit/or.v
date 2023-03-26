`timescale 1ns / 1ps

module or(input [31:0] A, input [31:0] B, output [31:0] out);
	 
always@(*) begin
  out = A | B;
end  

endmodule
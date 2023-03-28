`timescale 1ns / 1ps

module add( signed input [31:0] A, signed input [31:0] B, signed output [31:0] out);
	 
always@(*) begin
  out = A + B;
end  

endmodule

module addi(signed input [31:0] a, input [15:0] imm, signed output reg [31:0] out);

always @(*) begin
  out = a + {{16{imm[15]}}, imm}; // Sign-extend the immediate value
end

endmodule

module addiu(unsigned input [31:0] a, input [15:0] imm, unsigned output reg [31:0] out);

always @(*) begin
  out = a + {{16{imm[15]}}, imm}; // Sign-extend the immediate value
end

endmodule

module addu( unsigned input [31:0] A, unsigned input [31:0] B, unsigned output [31:0] out);
	 
always@(*) begin
  out = A + B;
end  

endmodule

module sub( signed input [31:0] A, signed input [31:0] B, signed output [31:0] diff);
	 
always@(*) begin
  diff = A - B;
end  

endmodule

module subu( unsigned input [31:0] A, unsigned input [31:0] B, unsigned output [31:0] diff);
	 
always@(*) begin
  diff = A - B;
end  

endmodule
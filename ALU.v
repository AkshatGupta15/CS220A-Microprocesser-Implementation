`timescale 1ns / 1ps

module ADD (input signed [31:0] A, input signed [31:0] B, output [31:0] out);  // working

assign out = A + B;

endmodule

module ADDI(input signed [31:0] A, input [15:0] imm,  output [31:0] out);   // working

assign out = A + {{16{imm[15]}}, imm};

endmodule

module ADDIU(input unsigned [31:0] A, input [15:0] imm,  output [31:0] out);  // 

assign out = A + {{16{imm[15]}}, imm};

endmodule

module ADDU(input unsigned [31:0] A, input unsigned [31:0] B, output [31:0] out); // 

assign out = A+B;

endmodule

module SUB(input signed [31:0] A, input signed [31:0] B, output [31:0] diff);  // working

assign diff = A - B;

endmodule

module SUBU(input unsigned [31:0] A, input unsigned [31:0] B, output [31:0] diff);  // 
	  
assign diff = A - B;

endmodule

module AND(input [31:0] A, input [31:0] B, output [31:0] out);   // working
	 
assign out = A&B;

endmodule

module ANDI(input [31:0] A, input [15:0] imm, output [31:0] out);   // working

assign out = A & {{16{imm[15]}}, imm};

endmodule

module OR(input [31:0] A, input [31:0] B, output [31:0] out);    // working
	 
assign out = A | B; 

endmodule

module ORI(input [31:0] A, input [15:0] imm, output [31:0] out);   // working

assign out = A | {{16{imm[15]}}, imm}; 

endmodule

module SLL(input [31:0] A, input [15:0] sa, output [31:0] out);    // working

assign out = A << sa; 

endmodule

module SRL(input [31:0] A, input [15:0] sa, output [31:0] out);    // working

assign out = A >> sa;

endmodule

module SLT(input signed [31:0] A,  input signed [31:0] B, output [31:0] out);  // working

assign out = (A < B) ? 1 : 0;

endmodule

module SLTI(input signed [31:0] A, input signed [15:0] imm, output [31:0] out); // working

assign out = (A < {{16{imm[15]}}, imm})? 1:0;

endmodule
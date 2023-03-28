`timescale 1ns / 1ps

module and(input [31:0] A, input [31:0] B, output [31:0] out);
	 
    always@(*) begin
    out = A & B;
    end  

endmodule

module andi(signed input [31:0] a, input [15:0] imm, signed output reg [31:0] out);

    always @(*) begin
    out = a & {{16{imm[15]}}, imm}; // Sign-extend the immediate value
    end

endmodule

module or(input [31:0] A, input [31:0] B, output [31:0] out);
	 
    always@(*) begin
    out = A | B;
    end  

endmodule

module ori(signed input [31:0] a, input [15:0] imm, signed output reg [31:0] out);

    always @(*) begin
    out = a | {{16{imm[15]}}, imm}; // Sign-extend the immediate value
    end

endmodule

module sll (output reg [31:0] out, input [31:0] A, input [15:0] sa);

  always @(*) begin
    out = A << {{16{sa[15]}}, sa};
  end

endmodule

module srl (output reg [31:0] out, input [31:0] A, input [15:0] sa);

  always @(*) begin
    out = A >> {{16{sa[15]}}, sa};
  end

endmodule
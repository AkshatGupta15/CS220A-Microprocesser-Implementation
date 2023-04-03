`timescale 1ns / 1ps

module ADD (input signed [31:0] A, input signed [31:0] B, output reg [31:0] out);

	 
always@(*) begin
  out = A + B;
end  

endmodule

module ADDI(input signed [31:0] A, input [15:0] imm,  output reg [31:0] out);

always @(*) begin
  out = A + {{16{imm[15]}}, imm}; // Sign-extend the immediate value
end

endmodule

module ADDIU(input unsigned [31:0] A, input [15:0] imm,  output reg [31:0] out);

always @(*) begin
  out = A + {{16{imm[15]}}, imm}; // Sign-extend the immediate value
end

endmodule

module ADDU(input unsigned [31:0] A, input unsigned [31:0] B, output reg [31:0] out);
	 
always@(*) begin
  out = A + B;
end  

endmodule

module SUB(input signed [31:0] A, input signed [31:0] B, output reg [31:0] diff);
	 
always@(*) begin
  diff = A - B;
end  

endmodule

module SUBU(input unsigned [31:0] A, input unsigned [31:0] B, output reg [31:0] diff);
	 
always@(*) begin
  diff = A - B;
end  

endmodule

module AND(input [31:0] A, input [31:0] B, output reg [31:0] out);
	 
    always@(*) begin
    out = A & B;
    end  

endmodule

module ANDI(input [31:0] A, input [15:0] imm, output reg [31:0] out);

    always @(*) begin
    out = A & {{16{imm[15]}}, imm}; // Sign-extend the immediate value
    end

endmodule

module OR(input [31:0] A, input [31:0] B, output reg [31:0] out);
	 
    always@(*) begin
    out = A | B;
    end  

endmodule

module ORI(input [31:0] A, input [15:0] imm, output reg [31:0] out);

    always @(*) begin
    out = A | {{16{imm[15]}}, imm}; // Sign-extend the immediate value
    end

endmodule

module SLL(input [31:0] A, input [15:0] sa, output reg [31:0] out);

  always @(*) begin
    out = A << {{16{sa[15]}}, sa};
  end

endmodule

module SRL(input [31:0] A, input [15:0] sa, output reg [31:0] out);

  always @(*) begin
    out = A >> {{16{sa[15]}}, sa};
  end

endmodule

module SLT(input [31:0] A, input [31:0] B, output reg [31:0] out);

  always @(*) begin

    if(A < B) begin
      out <= 32'b000000_00000_00000_00000_00000_000001;
    end

    else begin
      out <= 32'b000000_00000_00000_00000_00000_000000;
    end 

  end    
endmodule

module SLTI(input [31:0] A, input [15:0] imm, output reg [31:0] out);

  always @(*) begin

    if(A < {{16{imm[15]}}, imm}) begin
      out <= 32'b000000_00000_00000_00000_00000_000001;
    end

    else begin
      out <= 32'b000000_00000_00000_00000_00000_000000;
    end 
     
  end    
endmodule
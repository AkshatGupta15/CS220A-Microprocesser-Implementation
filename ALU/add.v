`timescale 1ns / 1ps
module add( input [31:0] A, input [31:0] B, output [31:0] out);
	 
 wire [31:0] cin;
 half_adder H1(A[0],B[0],out[0],cin[0]);
 
 genvar j;
 generate 
  begin
   for(j=1;j<=31;j=j+1)
    begin
     full_adder F1(A[j],B[j],cin[j-1],out[j],cin[j]);
    end
  end
endgenerate

endmodule

module half_adder(x,y,s,c);
   input x,y;
   output s,c;
   assign s=x^y;
   assign c=x&y;
endmodule // half adder

module full_adder(x,y,c_in,s,c_out);
   input x,y,c_in;
   output s,c_out;
 assign s = (x^y) ^ c_in;
 assign c_out = (y&c_in)| (x&y) | (x&c_in);
endmodule // full_adder
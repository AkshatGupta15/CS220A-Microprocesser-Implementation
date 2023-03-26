`timescale 1ns / 1ps
// `include "half_subtractor.v"
// `include "full_subtractor.v"

// module sub (a,b,diff);
//     signed input [31:0] a,
//     signed input [31:0] b,
//     signed output [31:0] diff,
//     wire [31:0] bor;
//     HalfSubtractor H1(a[0],b[0],diff[0],bor[0])
//     genvar i;
//     generate 
//         begin
//             for(i=1; i<32; i=i+1) 
//             begin
//                 full_subtractor sub (a[i], b[i],bor[i-1], diff[i], bor[i]);
//             end
//         end
//     endgenerate
// endmodule

module sub( signed input [31:0] A, signed input [31:0] B, signed output [31:0] diff);
	 
always@(*) begin
  diff = A - B;
end  

endmodule



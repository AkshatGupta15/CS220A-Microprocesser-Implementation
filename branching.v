`timescale 1ns / 1ps

module BEQ (input clk,input rst, input signed [31:0] r0,input signed [31:0] r1, input signed [15:0] offset,
input [31:0] pc_in, output [31:0] pc_out);

  assign pc_out = (r0==r1) ? (pc_in + {{16{offset[15]}}, offset} + 1) : (pc_in + 1) ;

endmodule

module BGT (input clk,input rst, input signed [31:0] r0,input signed [31:0] r1, input signed [15:0] offset,
input [31:0] pc_in, output [31:0] pc_out);

  assign pc_out = (r0 > r1) ? (pc_in + {{16{offset[15]}}, offset} + 1) : (pc_in + 1) ;

endmodule

module BGTE (input clk,input rst, input signed [31:0] r0,input signed [31:0] r1, input signed [15:0] offset,
input [31:0] pc_in, output [31:0] pc_out);

  assign pc_out = (r0 >= r1) ? (pc_in + {{16{offset[15]}}, offset} + 1) : (pc_in + 1) ;

endmodule

module BLE (input clk,input rst, input signed [31:0] r0,input signed [31:0] r1, input signed [15:0] offset,
input [31:0] pc_in, output [31:0] pc_out);

  assign pc_out = (r0 < r1) ? (pc_in + {{16{offset[15]}}, offset} + 1) : (pc_in + 1) ;

endmodule

module BLEQ (input clk,input rst, input signed [31:0] r0,input signed [31:0] r1, input signed [15:0] offset,
input [31:0] pc_in, output [31:0] pc_out);

  assign pc_out = (r0 <= r1) ? (pc_in + {{16{offset[15]}}, offset} + 1) : (pc_in + 1) ;

endmodule

module BNE (input clk,input rst, input signed [31:0] r0,input signed [31:0] r1, input signed [15:0] offset,
input [31:0] pc_in, output [31:0] pc_out);

  assign pc_out = (r0 != r1) ? (pc_in + {{16{offset[15]}}, offset} + 1) : (pc_in + 1) ;

endmodule

module J (input clk, input [25:0] target_address, input [31:0] pc_in, output [31:0] pc_out);
    
  assign pc_out = {{6{target_address[25]}}, target_address}; 

endmodule

module JAL(input clk, input [25:0] target_address, input [31:0] pc_in, output [31:0] pc_out, output [31:0] jal_ra);

  assign pc_out = {pc_in[31:28], target_address, 2'b00};
  assign jal_ra = pc_in + 1;
     
endmodule

module JR (input clk, input [31:0] r0, output [31:0] pc_out);

  assign pc_out = r0;  

endmodule
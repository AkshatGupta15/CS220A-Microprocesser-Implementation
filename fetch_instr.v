`timescale 1ns / 1ps

// We will use a VEDA memory 

module VEDA (clk, rst, pc, mem, ir_wire);

//   parameter WIDTH = 32;
//   parameter DEPTH = 256;
  
  input clk;
  input rst;
  input [31:0] pc;              // Program Counter
  input [31:0] mem [255:0];     // Instruction memory
  output [31:0] ir_wire;        // Instruction wire

  reg [31:0] ir;

  always @(posedge clk, posedge rst) begin
    if(rst) begin
      ir <= 32'h0;
    end 
    else begin 
      ir <= mem[pc];
    end
  end

  assign ir_wire = ir;

endmodule
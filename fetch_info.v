`timescale 1ns / 1ps

// We will use a VEDA memory each for instructions and data

module VEDA (clk, mode, addr, din, we, dout);

//   parameter WIDTH = 32;
//   parameter DEPTH = 128;
  
  input clk;
  input mode;
  input [4:0] addr;
  input [31:0] din;
  input we;
  output reg [31:0] dout;

  reg [31:0][127:0] mem;

  always @(posedge clk) begin
    if(we) begin
      if (mode == 0) begin // scribble mode
        mem[addr] <= din;
        dout <= din;
      end 
      else begin // interpret mode
      dout <= mem[addr];
      end
    end
    
  end

endmodule
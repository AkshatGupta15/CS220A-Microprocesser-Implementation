`timescale 1ns / 1ps

module beq (clk, rst, r0, r1, offset, pc_in, pc_out);

  input clk, rst;
  input [31:0] r0, r1;
  input [15:0] offset;
  input [31:0] pc_in;
  output reg [31:0] pc_out;

  always @(posedge clk or posedge rst) begin
    if (rst) begin
      pc_out <= 0;
    end
    else if (r0 == r1) begin
      pc_out <= pc_in + 4 + offset;
    end
    else begin
      pc_out <= pc_in + 4;
    end
  end

endmodule

module bgt (clk, rst, r0, r1, offset, pc_in, pc_out);

  input clk, rst;
  input [31:0] r0, r1;
  input [15:0] offset;
  input [31:0] pc_in;
  output reg [31:0] pc_out;

  always @(posedge clk or posedge rst) begin
    if (rst) begin
      pc_out <= 0;
    end
    else if (r0 > r1) begin
      pc_out <= pc_in + 4 + offset;
    end
    else begin
      pc_out <= pc_in + 4;
    end
  end

endmodule

module bgte (clk, rst, r0, r1, offset, pc_in, pc_out);

  input clk, rst;
  input [31:0] r0, r1;
  input [15:0] offset;
  input [31:0] pc_in;
  output reg [31:0] pc_out;

  always @(posedge clk or posedge rst) begin
    if (rst) begin
      pc_out <= 0;
    end
    else if (r0 >= r1) begin
      pc_out <= pc_in + 4 + offset;
    end
    else begin
      pc_out <= pc_in + 4;
    end
  end

endmodule

module ble (clk, rst, r0, r1, offset, pc_in, pc_out);

  input clk, rst;
  input [31:0] r0, r1;
  input [15:0] offset;
  input [31:0] pc_in;
  output reg [31:0] pc_out;

  always @(posedge clk or posedge rst) begin
    if (rst) begin
      pc_out <= 0;
    end
    else if (r0 < r1) begin
      pc_out <= pc_in + 4 + offset;
    end
    else begin
      pc_out <= pc_in + 4;
    end
  end

endmodule

module bleq (clk, rst, r0, r1, offset, pc_in, pc_out);

  input clk, rst;
  input [31:0] r0, r1;
  input [15:0] offset;
  input [31:0] pc_in;
  output reg [31:0] pc_out;

  always @(posedge clk or posedge rst) begin
    if (rst) begin
      pc_out <= 0;
    end
    else if (r0 <= r1) begin
      pc_out <= pc_in + 4 + offset;
    end
    else begin
      pc_out <= pc_in + 4;
    end
  end

endmodule

module bne (clk, rst, r0, r1, offset, pc_in, pc_out);

  input clk, rst;
  input [31:0] r0, r1;
  input [15:0] offset;
  input [31:0] pc_in;
  output reg [31:0] pc_out;

  always @(posedge clk or posedge rst) begin
    if (rst) begin
      pc_out <= 0;
    end
    else if (r0 != r1) begin
      pc_out <= pc_in + 4 + offset;
    end
    else begin
      pc_out <= pc_in + 4;
    end
  end

endmodule
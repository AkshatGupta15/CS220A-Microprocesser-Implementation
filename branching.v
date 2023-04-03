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
      pc_out <= pc_in + offset + 4;
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

module j (
    input [25:0] target_address,
    input [31:0] pc_in,
    output reg [31:0] pc_out,
    output reg jump_taken
);

    always @(*) begin
        pc_out = {pc_in[31:28], target_address, 2'b00}; // set jump target address
        jump_taken = 1'b1; // set jump taken signal
    end

endmodule

// The 'j' instruction is an unconditional jump that transfers
// control to the instruction at the target address. The jump address 
// is calculated by concatenating the upper 4 bits of the current program counter 
// with the 26-bit jump address left-shifted by 2 bits. 


module jal(
    input [25:0] target_address,
    input [31:0] pc_in,
    output reg [31:0] pc_out,
    output reg jump_taken,
    output reg [31:0] jal_ra
);

    always @(*) begin
        pc_out = {pc_in[31:28], target_address, 2'b00}; // set jump target address
        jump_taken = 1'b1; // set jump taken signal
        jal_ra = pc_in + 4;
    end

    
endmodule

module jr (
    input [31:0] r0,
    output reg [31:0] pc_out,
    output reg jump_taken
);

    always @(*) begin
        pc_out = r0; // set jump target address to value in r0 register
        jump_taken = 1'b1; // set jump taken signal
    end

endmodule
`include "ALU.v"
`include "branching.v"

`timescale 1ns/1ps

module testbench();

  // Inputs
  reg [31:0] pc_in;

  // Outputs
  wire [31:0] result;
  wire [31:0] pc_out;

  reg [31:0] test_mem [0:31];
  reg [15:0] imm;
  reg clk, rst;

  // Instantiate submodules
  ADD add_inst(.A(test_mem[10]), .B(test_mem[11]), .out(result));
  // SUB sub_inst(.A(test_mem[10]), .B(test_mem[11]), .diff(result));
  beq beq_inst(.clk(clk), .rst(rst), .r0(test_mem[11]), .r1(test_mem[12]), .offset(imm) , .pc_in(pc_in), .pc_out(pc_out));

  // Clock
  
  always #10 clk = ~clk;

  initial begin
    rst <= 0;
    clk <= 1;
    test_mem[10] <= 32'b111111_11111_11111_11111_11111_110110; //-10
    test_mem[11] <= 32'b000000_00000_00000_00000_00000_001011; //11
    test_mem[12] <= 32'b000000_00000_00000_00000_00000_001011; //11
    pc_in <= 32'b000000_00000_00000_00000_00000_000001;
    imm <= 16'b00000_00000_000001; //1

   // Test "beq" instruction
    #5;
    if (pc_out !== 32'b000000_00000_00000_00000_00000_000110) $error("Branching operation failed!\n");
    else $display("Branching operation successfull!");
    $display("r0 = %b, r1 = %b",test_mem[11],test_mem[12]);
    $display("offset = %b, pc_in = %b",imm,pc_in);
    $display("pc_out = %b",pc_out);
    $display("rst = %b\n",rst);



    // Test "add" instruction
    #5;
    if (result !== 32'b000000_00000_00000_00000_00000_000001) $error("ALU operation failed!\n");
    else $display("ALU operation successfull!\n");

 
    #5
    // imm <= 16'b00000_00000_000010; //2
    if (pc_out !== 32'b000000_00000_00000_00000_00000_000110) $error("Branching operation failed!");
    else $display("Branching operation successfull!");
    $display("r0 = %b, r1 = %b",test_mem[11],test_mem[12]);
    $display("offset = %b, pc_in = %b",imm,pc_in);
    $display("pc_out = %b\n",pc_out);

    $finish;
  end

endmodule

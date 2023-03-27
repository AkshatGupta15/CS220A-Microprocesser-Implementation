`timescale 1ns / 1ps

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

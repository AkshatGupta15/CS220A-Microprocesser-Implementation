`timescale 1ns / 1ps

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
    end

    assign jal_ra = pc_in + 4;
    
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
`timescale 1ns / 1ps

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

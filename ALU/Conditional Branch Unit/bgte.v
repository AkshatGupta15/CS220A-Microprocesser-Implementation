`timescale 1ns / 1ps
`include "../Comparison Unit/slt.v"

module bgte (
    input [31:0] rs,
    input [31:0] rt,
    input [31:0] target,
    input [31:0] pc,
    output reg [31:0] npc,
    input clk,
    input reset
);

    reg [31:0] offset;

    // Compute the branch offset
    assign offset = { {16{rs[31]}}, rs[31:0]} - { {16{rt[31]}}, rt[31:0]};

    // Compare rs and rt using the slt module
    wire equal;
    wire less;
    slt slt_inst(.a(rs), .b(rt), .slt(less), .eq(equal));

    always @(posedge clk, posedge reset) begin
        if (reset) begin
            npc <= 0;
        end else begin
            if (less || equal) begin
                // Branch to target address
                npc <= pc + 4 + (offset << 2);
            end else begin
                // Continue to the next instruction
                npc <= pc + 4;
            end
        end
    end

endmodule

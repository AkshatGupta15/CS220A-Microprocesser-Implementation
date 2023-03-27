`timescale 1ns / 1ps
`include "../Comparison Unit/slt.v"


module bgte (
    input [31:0] rs,
    input [31:0] rt,
    input [31:0] offset,
    input [31:0] pc,
    output reg [31:0] npc,
    input clk,
    input reset
);

    // Compute the comparison and branch condition
    wire greater;
    wire equal;
    slt slt_inst(.a(rt), .b(rs), .slt(greater), .eq(equal));
    wire branch;
    assign branch = greater || equal;

    // Compute the branch target address
    wire [31:0] target;
    assign target = pc + 4 + (offset << 2);

    // Update the next program counter value
    always @(posedge clk, posedge reset) begin
        if (reset) begin
            npc <= 0;
        end else begin
            if (branch) begin
                npc <= target;
            end else begin
                npc <= pc + 4;
            end
        end
    end

endmodule

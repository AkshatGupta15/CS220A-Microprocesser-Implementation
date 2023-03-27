`timescale 1ns / 1ps
`include "../Comparison Unit/slt.v"


module bgt (
    input [31:0] rs,
    input [31:0] rt,
    input [31:0] offset,
    input [31:0] pc,
    output reg [31:0] npc,
    input clk,
    input reset
);

    // Compute the comparison and branch condition
    wire slt_out;
    wire branch;
    slt slt_inst(.a(rt), .b(rs), .result(slt_out));
    
    always @(*) begin
        if(slt_out == 0) begin
            branch = 0;
        end
        else begin
            branch = 1;
        end
    end

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

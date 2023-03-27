`timescale 1ns / 1ps
// `include "../Comparison Unit/slt.v"

// module bleq (
//     input [31:0] rs,
//     input [31:0] rt,
//     input [31:0] offset,
//     input [31:0] pc,
//     output reg [31:0] npc,
//     input clk,
//     input reset
// );

//     // Compute the comparison and branch condition
//     wire equal;
//     wire less;
//     slt slt_inst(.a(rt), .b(rs), .slt(less), .eq(equal));
//     wire branch;
//     assign branch = equal;

//     // Compute the branch target address
//     wire [31:0] target;
//     assign target = pc + 4 + (offset << 2);

//     // Update the next program counter value
//     always @(posedge clk, posedge reset) begin
//         if (reset) begin
//             npc <= 0;
//         end else begin
//             if (branch) begin
//                 npc <= target;
//             end else begin
//                 npc <= pc + 4;
//             end
//         end
//     end

// endmodule

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
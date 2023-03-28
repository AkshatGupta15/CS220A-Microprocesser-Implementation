`timescale 1ns / 1ps

module lw(input [31:0] r0, input [31:0] r1, input [15:0] offset, input clk, input [31:0] data_mem [255:0])

    always@(posedge clk) begin
        r0 <= data_mem[r1 + {{16{offset[15]}}, offset}]
    end

endmodule

module sw(input [31:0] r0, input [31:0] r1, input [15:0] offset, input clk, input [31:0] data_mem [255:0])

    always@(posedge clk) begin
        data_mem[r1 + {{16{offset[15]}}, offset}] <= r0;
    end

endmodule
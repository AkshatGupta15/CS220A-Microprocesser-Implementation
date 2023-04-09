`timescale 1ns / 1ps

module VEDA_memory(clk, rst, addr, mode, write_en ,write_data, out_wire);

    input clk, rst;
    input write_en;
    input mode;
    input [31:0] write_data;
    input [31:0] addr;
    output signed [31:0] out_wire;

    reg [31:0] veda [0:255];
    reg [31:0] out;
    integer i;
    initial begin : data_initialize
        for(i = 0; i < 256; i = i+1) begin
            veda[i] <= 32'b0;
        end
    end

    always @(posedge clk) begin
        if(mode==0 && write_en==1) begin
            veda[addr] = write_data;
            out = veda[addr];
        end
        else if(mode==1) begin
            out <= veda[addr];
        end
    end

    assign out_wire = out;

endmodule
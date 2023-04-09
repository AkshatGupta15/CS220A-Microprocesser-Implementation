module VEDA_instruction(clk, rst, addr, mode, write_en, write_data, out_wire);

    input clk;                                    // clock signal
    input rst;                                    // reset signal
    input [31:0] addr;                            // input address or PC
    input write_en;                               // write enable signal
    input [31:0] write_data;                      // instruction to be written
    input mode;                                   // mode - either 1 or 0 (fetch or write)

    output signed [31:0] out_wire;                 // data/instruction to be outputted or IR

    reg [31:0] veda[0:255];     
    reg [31:0] out;                  // memory to be used for either data or instruction storage (256 rows of 32 bit values)
    integer i;

    always@(posedge rst) begin
        veda[0] <= 32'b000000_10010_10011_10001_00000_000000;                  // add $t0, $t1, $t2
        veda[1] <= 32'b001110_10010_10011_0000000000000010;                    // beq $t1, $t2, 2
        veda[2] <= 32'b000000_10010_10011_10001_00000_000000;                  // add $t0, $t1, $t2
        veda[3] <= 32'b000001_10010_10011_10001_00000_000000;                  // sub $t0, $t1, $t2
        veda[4] <= 32'b000000_10010_10011_10001_00000_000000;                  // add $t0, $t1, $t2

        // veda[0] <= 32'b011000_10010_10001_0000000000001010;                 // addi $t0, $t1, 10
        // veda[1] <= 32'b001110_10010_10011_0000000000001010;                 //  beq $t1, $t2, 10
        // veda[1] <= 32'b010110_00000000000000000000000100;                   //  jal 4
        // veda[2] <= 32'b001001_10010_10001_0000000000001010;                 // ori $t0, $t1, 2
        // veda[1] <= 32'b010101_10010_00000_00000_00000_000000;                  // jr $t1
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

`include "CSE_BUBBLE.v"

module simulator();

    reg clk, rst;
    // reg [31:0] data_input [0:255];
    wire [31:0] d_out;
    wire [31:0] d_reg;
    wire [31:0] d_th;
    wire [31:0] d_jump;
    wire[31:0] instruction;

    cse_bubble module_call(.clk(clk), .rst(rst), .d_out(d_out), .instruction(instruction), .d_reg(d_reg), .d_th(d_th));

    initial begin  
        #10
        clk <= 1'b1; 
        forever #10 clk <= ~clk;
    end

    initial begin
        rst <= 0;
        #1
        rst <= 1;
    end

    initial begin
        $monitor("clk = %d,      instruction = %b,       first_output = %d,      PC = %d", clk, instruction, d_out, d_reg);
        // $monitor("instruction = %b", instruction);
        // #30

        // $display("Machine code of first instruction =  %b",instruction);
        // $display("First Output is %d\n", d_out);


        // #15

        // $display("Machine code of second instruction = %b",instruction);
        // $display("Second Output is %b\n", d_reg);


        // #15

        // $display("Machine code of third instruction = %b",instruction);    
        // $display("Third Output is %d\n", d_th);
        

        #150
        $finish;
    end

endmodule
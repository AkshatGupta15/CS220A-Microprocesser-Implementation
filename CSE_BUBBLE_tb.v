`include "CSE_BUBBLE.v"

module simulator();

    reg clk, rst;
    cse_bubble module_call(.clk(clk), .rst(rst));

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
        $display("\nSorted Array is: ");
        #5000
        $finish;
    end

endmodule
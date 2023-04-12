`include "CSE_BUBBLE.v"

module simulator();

    reg clk, rst;
    wire [31:0] s0,s1,s2,s3,t0,t1,t2,t3,t4,t5,pc_test;
    wire[31:0] instruction;

    cse_bubble module_call(.clk(clk), .rst(rst), .instruction(instruction), .s0(s0), .s1(s1), .s2(s2), .s3(s3), .t0(t0), .t1(t1), .t2(t2), .t3(t3), .t4(t4), .t5(t5), .pc_test(pc_test));

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
        // $monitor("clk = %d,t0 = %d,t1 = %d,t2 = %d,t3 = %d,t4 = %d,t5 = %d,s0 = %d,s1 = %d,s2 = %d,PC = %d", clk,t0,t1,t2,t3,t4,t5,s0,s1,s2,pc_test); 
        $display("\nSorted Array is: ");
        #5000
        $finish;
    end

endmodule
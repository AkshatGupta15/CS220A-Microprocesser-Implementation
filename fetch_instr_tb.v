`include "fetch_info.v"
module simulator();
    
    // Instantiation of the UUT (Unit Under Test)
    reg [31:0] a,b,c;
    wire [31:0] out;
    reg clk,reset,mode,write;

    // Change as per the program to be tested
    veda2 uut(clk,a,out,reset,mode,b,c,write);

    initial begin  
        #10
        clk <= 1'b0; 
        forever #5 clk <= ~clk;
    end

    initial begin  
        reset <= 1'b0;
        #1
        reset <= 1'b1;
        #1
        reset <= 1'b0;
    end
    
    initial begin;
        $dumpfile("test1.vcd");
        $dumpvars;
        #10

        a <= 134; b <= 13; c <= 10; mode <= 0; write <= 1;
        #10
        $display("clock is %d, mode is %d, input value is %d, output value is %d",clk,mode,a,out);
        
        a <= 144; b <= 10; c <= 3; mode <= 1; write <= 1;
        #10
        $display("clock is %d, mode is %d, input value is %d, output value is %d",clk,mode,a,out);
        
        a <= 170; b <= 11; c <= 10; mode <= 0; write <= 1;
        #10
        $display("clock is %d, mode is %d, input value is %d, output value is %d",clk,mode,a,out);
        
        a <= 200; b <= 10; c <= 3; mode <= 0; write <= 1;
        #10
        $display("clock is %d, mode is %d, input value is %d, output value is %d",clk,mode,a,out);
        
        a <= 210; b <= 13; c <= 10; mode <= 0; write <= 1;
        #10
        $display("clock is %d, mode is %d, input value is %d, output value is %d",clk,mode,a,out);
        
        a <= 201; b <= 13; c <= 10; mode <= 0; write <= 1;
        #10
        $display("clock is %d, mode is %d, input value is %d, output value is %d",clk,mode,a,out);
        
        #2000 $finish;
    end
endmodule
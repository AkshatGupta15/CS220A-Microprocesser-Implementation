`include "fetch_data.v"
module simulator();
    
    // Instantiation of the UUT (Unit Under Test)
    reg [31:0] data_addr,write_data;
    wire [31:0] out;
    reg clk,rst,mode,write_en;

    // Change as per the program to be tested
    VEDA_data uut(clk,rst,data_addr,mode,write_en,write_data,out);

    initial begin  
        #10
        clk <= 1'b0; 
        forever #5 clk <= ~clk;
    end

    initial begin  
        rst <= 1'b0;
        #1
        rst <= 1'b1;
        #1
        rst <= 1'b0;
    end
    
    initial begin;
        #10

        data_addr <= 0; mode <= 1; write_en <= 1; write_data <= 4;
        #10
        $display("clock is %d, mode is %d, input value is %d, output value is %d",clk,mode,write_data,out);
        
        data_addr <= 5; mode <= 1; write_en <= 1; write_data <= 3;
        #10
        $display("clock is %d, mode is %d, input value is %d, output value is %d",clk,mode,write_data,out);
        
        data_addr <= 1; mode <= 0; write_en <= 1; write_data <= 34;
        #10
        $display("clock is %d, mode is %d, input value is %d, output value is %d",clk,mode,write_data,out);
        
        data_addr <= 1; mode <= 1; write_en <= 1; write_data <= 50;
        #10
        $display("clock is %d, mode is %d, input value is %d, output value is %d",clk,mode,write_data,out);
    
        
        #2000 $finish;
    end
endmodule
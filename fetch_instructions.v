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

    // always @(posedge rst) begin
    //     // veda[0] <= 32'b000000_10010_10011_10001_00000_000000;                  // add $t0, $t1, $t2
    //     // veda[1] <= 32'b000001_10010_10011_10001_00000_000000;                  // sub $t0, $t1, $t2
    //     // veda[2] <= 32'b000000_10010_10011_10001_00000_000000;                  // add $t0, $t1, $t2
    //     // veda[3] <= 32'b000001_10010_10011_10001_00000_000000;                  // sub $t0, $t1, $t2
    //     // veda[4] <= 32'b000000_10010_10011_10001_00000_000000;                  // add $t0, $t1, $t2

    //     // veda[0] <= 32'b001100_00110_10010_0000000000000000;                       // lw $t1, 0($zero)
    //     // // veda[1] <= 32'b011010_00000000000000000000000000;                         // nop instruction   
    //     // // veda[1] <= 32'b000000_10011_10011_10001_00000_000000;                  // add $t0, $t2, $t2
    //     // veda[1] <= 32'b000000_10010_10010_10001_00000_000000;                     // add $t0, $t1, $t1
    //     // veda[2] <= 32'b001101_00110_10001_0000000000000000;                       // sw $t0, 0($zero)
    //     // veda[0] <= 32'b011001_00000000000000000000000000;                            // syscall 

    // end

    always @(posedge rst) begin
        veda[0] <= 32'b000000_00110_00110_11001_00000_000000;   //  la $s0, array   (add $s0, $zero, $zero) [0]
        veda[1] <= 32'b001100_00110_11010_0000000000000110;     //  lw $s1, size    (lw $s1, 6($zero)) [1]
        veda[2] <= 32'b000100_11010_11011_1111111111111111;     //  addi $s2, $s1, -1 [2]
        veda[3] <= 32'b000000_00110_00110_10001_00000_000000;   //  li $t0, 0 (add $t0, $zero, $zero) [3]
        veda[4] <= 32'b000000_00110_00110_10010_00000_000000;   //  li $t1, 0 (add $t1, $zero, $zero) [4]
        veda[5] <= 32'b000000_00110_00110_10111_00000_000000;   //  li $t6, 0 (add $t6, $zero, $zero) [5]
        veda[6] <= 32'b001010_10010_10011_0000000000000000;     // sll $t2, $t1, 0 [6]
        veda[7] <= 32'b000000_10011_11001_10011_00000_000000;   // add $t2, $s0, $t2 [7]
        veda[8] <= 32'b001100_10011_10100_0000000000000000;     // lw $t3, 0($t2) [8]
        veda[9] <= 32'b001100_10011_10101_0000000000000001;     // lw $t4, 1($t2) [9]
        veda[10] <= 32'b010111_10100_10101_10110_00000_000000;  // slt $t5, $t3, $t4 [10]
        veda[11] <= 32'b001111_00110_10110_0000000000000010;    // bne $t5, $zero, 2 (address of Increase is 14) [11]
        veda[12] <= 32'b001101_10011_10101_0000000000000000;    // sw $t4, 0($t2) [12]   
        veda[13] <= 32'b001101_10011_10100_0000000000000001;    // sw $t3, 1($t2) [13]    
        veda[14] <= 32'b000100_10010_10010_0000000000000001;    // addi $t1, $t1, 1 [14]
        veda[15] <= 32'b000001_11011_10001_11100_00000_000000;  // sub $s3, $s2, $t0 [15]
        veda[16] <= 32'b001111_10010_11100_1111111111110101;    // bne $t1, $s3, -11 (address of Loop is 6) [16] # check if issue with sign extension 
        veda[17] <= 32'b000100_10001_10001_0000000000000001;    // addi $t0, $t0, 1 [17]  
        veda[18] <= 32'b000000_00110_00110_10010_00000_000000;  // li $t1, 0 (add $t1, $zero, $zero) [18]
        veda[19] <= 32'b001111_10001_11011_1111111111110010;    // bne $t0, $s2, -14 (address of Loop is 6) [19]
        veda[20] <= 32'b001110_10111_11010_0000000000001010;    // beq $t6, $s1, 10  (address of Exit is 31) [20]
        veda[21] <= 32'b001100_11001_11000_0000000000000000;    // lw $t7, 0($s0) [21]
        veda[22] <= 32'b000100_00110_01000_0000000000000001;    // li $v0, 1 (addi $v0, $zero, 1) [22]
        veda[23] <= 32'b000000_00110_11000_01010_00000_000000;  // move $a0, $t7 (add $a0, $zero, $t7) [23]
        veda[24] <= 32'b011001_00000000000000000000000000;      // syscall [24]
        veda[25] <= 32'b000100_00110_01010_0000000000100000;    // li $a0, 32 (addi $a0, $zero, 32) [25]
        veda[26] <= 32'b000100_00110_01000_0000000000001011;    // li $v0, 11 (addi $v0, $zero, 11) [26]
        veda[27] <= 32'b011001_00000000000000000000000000;      // syscall [27]
        veda[28] <= 32'b000100_11001_11001_0000000000000001;    // addi $s0, $s0, 1 [28]
        veda[29] <= 32'b000100_10111_10111_0000000000000001;    // addi $t6, $t6, 1 [29]
        veda[30] <= 32'b010100_00000000000000000000010100;      // j 20 (address of Print) [30]
        veda[31] <= 32'b000100_00110_01000_0000000000001010;    // li $v0, 10 (addi $v0, $zero, 10) [31]
        veda[32] <= 32'b011001_00000000000000000000000000;      // syscall [32]
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

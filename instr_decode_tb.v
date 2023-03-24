`include "instr_decode.v"
module simulator();
    
    reg [5:0] opcode;
    wire execute_add, execute_sub, execute_subu, execute_addu, execute_addi, execute_addiu, execute_and, execute_or;

    instruction_decode uut(opcode,execute_add, execute_sub, execute_subu, execute_addu, 
    execute_addi, execute_addiu,execute_and, execute_or, execute_andi, execute_ori);

    initial begin
        // test addition operation
        opcode = 6'b000000;

        #10;
        $display("add: %d sub: %d subu: %d addu: %d addi: %d addiu: %d and: %d or: %d andi: %d ori: %d",execute_add,execute_sub,execute_subu,execute_addu,
        execute_addi,execute_addiu,execute_and,execute_or,execute_andi, execute_ori);

        // test subtraction operation
        opcode = 6'b000001;

        #10;
        $display("add: %d sub: %d subu: %d addu: %d addi: %d addiu: %d and: %d or: %d andi: %d ori: %d",execute_add,execute_sub,execute_subu,execute_addu,
        execute_addi,execute_addiu,execute_and,execute_or,execute_andi, execute_ori);

        // test addi
        opcode = 6'b000100;

        #10;
        $display("add: %d sub: %d subu: %d addu: %d addi: %d addiu: %d and: %d or: %d andi: %d ori: %d",execute_add,execute_sub,execute_subu,execute_addu,
        execute_addi,execute_addiu,execute_and,execute_or,execute_andi, execute_ori);

        $finish;
    end

endmodule    
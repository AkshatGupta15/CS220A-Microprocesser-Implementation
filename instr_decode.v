module instruction_decode(instr, opcode, rs, rd, rt, shamt, funct, address_i, address_j, imm);

    input[31:0] instr;
    output reg[5:0] opcode, funct;
    output reg[4:0] rs, rt, rd, shamt; 
    output reg[25:0] address_j;
    output reg[15:0] address_i, imm;

    assign opcode = instr[31:26];       // the opcode is the first six bits of the instruction

    always @(*) begin
        // opcodes for J-type instructions (j, jal)
        if(opcode == 6'010100 or opcode == 6'b010110) begin      
            address_j <= instr[25:0];
        end
        // opcodes for I-type instructions (addi, addiu, andi, ori, lw, sw, slti)
        else if(opcode == 6'b000100 or opcode == 6'b000101 or opcode == 6'b001000 or opcode == 6'b001001 or opcode == 6'b001100 or opcode == 6'b001101 or opcode == 6'b011000) begin
            rs <= instr[25:21];
            rt <= instr[20:16];
            address_i <= instr[15:0];
            imm <= instr[15:0];
        end
        // opcodes for R-type instructions
        else begin
            rs <= instr[25:21];
            rt <= instr[20:16];
            rd <= instr[15:11];
            shamt <= instr[10:6];
            funct <= instr[5:0];
        end
    end
    
endmodule
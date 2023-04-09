module instruction_decode(clk, instr, opcode, rs, rd, rt, shamt, funct, address_i, address_j, imm);

    input clk;
    input[31:0] instr;
    output [5:0] opcode, funct;
    output [4:0] rs, rt, rd, shamt; 
    output [25:0] address_j;
    output [15:0] address_i, imm;

    reg [5:0] functw;
    reg [4:0] rsw, rtw, rdw, shamtw; 
    reg [25:0] address_jw;
    reg [15:0] address_iw, immw;

    assign opcode = instr[31:26];
    assign funct = functw;
    assign rs = rsw;
    assign rt = rtw;
    assign rd = rdw;
    assign shamt = shamtw;
    assign address_j = address_jw;
    assign address_i = address_iw;
    assign imm = immw;  

    always @(*) begin
        // opcodes for J-type instructions (j, jal)
        if(opcode == 6'b010100 || opcode == 6'b010110) begin      
            address_jw <= instr[25:0];
        end
        // opcodes for I-type instructions (addi, addiu, andi, ori, lw, sw, slti, sll, srl, beq, bne, bgt, bgte, ble, bleq)
        else if((opcode == 6'b000100) || (opcode == 6'b000101) || (opcode >= 6'b001000 && opcode <= 6'b010011) || (opcode == 6'b011000)) begin
            rsw <= instr[25:21];
            rtw <= instr[20:16];
            address_iw <= instr[15:0];
            immw <= instr[15:0];
        end
        // opcodes for R-type instructions
        else begin
            rsw <= instr[25:21];
            rtw <= instr[20:16];
            rdw <= instr[15:11];
            shamtw <= instr[10:6];
            functw <= instr[5:0];
        end
    end
    
endmodule
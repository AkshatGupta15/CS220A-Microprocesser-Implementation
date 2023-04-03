`include "fetch_instr.v"
`include "instr_decode.v"
`include "ALU.v"
`include "branching.v"

module cse_bubble(clk,rst,instr,data);

    input clk,rst;
    input [31:0] instr_input [0:255];
    input [31:0] data_input [0:255];

    reg [31:0] processor [0:31];
    // processor memory which stores all the 32 registers
    // Registers 0-5 : System controlled registers PC, EPC, Cause, BadVAddr, Status, IR
    // Registers 6-31 : User controlled registers r0, at, v0-v1, a0-a3, gp, sp, ra, t0-t6, s0-s7
    // Register 0 - PC - Program Counter (Denotes the next instruction to be fetched)
    // Register 1 - EPC -
    // Register 2 - Cause -
    // Register 3 - BadVAddr -
    // Register 4 - Status -
    // Register 5 - IR - It will Store the Current Instruction which is being executed
    // Register 6 - r0 - This register will be hardwired to 0 at all times
    // Register 7 - at - This register will be used by the Assembler time to time to implement Pseudo Instructions
    // Register (8-9) - (v0-v1) - This will be used for system calls and system instructions by the user
    // Register (10-13) - (a0-a3) - Will be used to provide arguments for function or system calls by the user
    // Register 14 - gp - Global Pointer - Will be pointing to the start of the global area, can be used to point the starting address of heap in data memory
    // Register 15 - sp - Stack Pointer - Will denote the starting location of stack memory in data memory
    // Register 16 - ra - Return Address - Will Store the address of the instruction where we have to return after function exits
    // Register (17-23) - (t0-t6) - Temprorary Registers - Will be used to store values just required temprorarily
    // Register (24-31) - (s0-s7) - Stored Registers - Will be used to store values required over multiple functions or modules

    wire [31:0] instr [0:255];  // this will be the VEDA memory that stores the instructions
    wire [31:0] data [0:255];   // this will be the VEDA memory that stores the data

    // Initializing interface memory
    genvar i;

    generate
        for(i=0; i < 256; i = i+1) begin
            assign instr[i] = instr_input[i];
            assign data[i] = data_input[i];
        end    
    endgenerate

    // INITIALIZATION OF SYSTEM CONTROLLED REGISTERS INSIDE THE PROCESSOR
    // reset will be activated for a very small time during the starting of the execution. That will be used by the processor
    // to intiate all the registers in it.
    // It will also be used by other modules instantiated in PROCESSOR for resetting there induvidual memory

    always @(posedge rst) begin
        processor[0] <= 0;          // Set PC as 0 (start of the program)
        processor[5] <= 0;          // Clear the IR Register
        processor[6] <= 0;          // Register r0 always hardwired to 0
        processor[7] <= 0;          // Register at set to 0
        process[16] <= 0;           // Register ra set to 0

        integer i;
        for(i=8;i<=13;i=i+1) begin 
            processor[i] <= 0;      // Clear all return and argument registers in processor
        end 

        processor[14] <= 0;         // Global Pointer initialized at the top of the Data Memory
        processor[15] <= 255;       // Stack Pointer initialized at the end of the Data Memory
        
        for(i=17;i<=31;i=i+1) begin 
            processor[i] <= 0;      // Clear all temp and save registers in processor
        end 
    end

    // INSTRUCTION FETCH PHASE (MODULE WILL BE CALLED WHICH WILL LOAD THE NEXT INSTRUCTION IN IR REGISTER)
    // processor[5] is the IR register which stores the current instruction being executed
    // processor[0] is the PC register whcih stores the next instruction to be executed

    VEDA fetch(clk,rst, processor[0], instr, processor[5]);

    // INSTRUCTION DECODE PHASE (READ THE IR REGISTER AND SEND THE CONTROL TO THAT PARTICULAR INSTRUCTION DATA PATH)

    wire [5:0] opcode, funct;
    wire [4:0] rs, rt, rd, shamt;
    wire [25:0] address_j;
    wire [15:0] address_i, imm;

    instruction_decode DCODE(processor[5],opcode, rs, rd, rt, shamt, funct, address_i, address_j, imm);

    // FINITE STATE MACHINE FOR THE CONTROL SIGNALS TO EXECUTE THE PROCESSOR

    reg [5:0] STATE;
    
    // Defining the states
    parameter execute_ADD = 6'b000000, execute_SUB = 6'b000001, execute_SUBU = 6'b000010, execute_ADDU = 6'b000011,
              execute_ADDI = 6'b000100, execute_ADDIU = 6'b000101, execute_AND = 6'b000110, execute_OR = 6'b000111,
              execute_ANDI = 6'b001000, execute_ORI = 6'b001001, execute_SLL = 6'b001010,  execute_SRL = 6'b001011,
              execute_LW = 6'b001100,    execute_SW = 6'b001101, execute_BEQ = 6'b001110,  execute_BNE = 6'b001111,
              execute_BGT = 6'b010000, execute_BGTE = 6'b010001, execute_BLE = 6'b010010, execute_BLEQ = 6'b010011,
              execute_J = 6'b010100, execute_JR = 6'b010101, execute_JAL = 6'b010110, execute_SLT = 6'b010111, execute_SLTI = 6'b011000;

    wire[31:0] temp_output, temp_output_1;
    wire jump_signal;

    always @(posedge clk) begin 
        case(STATE)

        // Following are states for ALU instructions

            execute_ADD: begin
                ADD add_inst(.A(processor[rs]), .B(processor[rt]), .out(temp_output));
                processor[rd] <= temp_output;
                processor[0] <= processor[0] + 4;                                           //incrementing the program counter
            end
            execute_SUB: begin
                SUB sub_inst(.A(processor[rs]), .B(processor[rt]), .diff(temp_output));
                processor[rd] <= temp_output;
                processor[0] <= processor[0] + 4;   
            end
            execute_SUBU: begin
                SUBU subu_inst(.A(processor[rs]), .B(processor[rt]), .diff(temp_output));
                processor[rd] <= temp_output;
                processor[0] <= processor[0] + 4;   
            end
            execute_ADDU: begin
                ADDU addu_inst(.A(processor[rs]), .B(processor[rt]), .out(temp_output));
                processor[rd] <= temp_output;
                processor[0] <= processor[0] + 4;   
            end
            execute_ADDI: begin
                ADDI addi_inst(.A(processor[rs]), .imm(imm), .out(temp_output));
                processor[rt] <= temp_output;
                processor[0] <= processor[0] + 4;   
            end
            execute_ADDIU: begin
                ADDIU addiu_inst(.A(processor[rs]), .imm(imm), .out(temp_output));
                processor[rt] <= temp_output;
                processor[0] <= processor[0] + 4;   
            end  
            execute_AND: begin
                AND and_inst(.A(processor[rs]), .B(processor[rt]), .out(temp_output));
                processor[rd] <= temp_output;
                processor[0] <= processor[0] + 4;   
            end    
            execute_OR: begin
                OR or_inst(.A(processor[rs]), .B(processor[rt]), .out(temp_output));
                processor[rd] <= temp_output;
                processor[0] <= processor[0] + 4;   
            end  
            execute_ANDI: begin
                ANDI andi_inst(.A(processor[rs]), .imm(imm), .out(temp_output));
                processor[rt] <= temp_output;
                processor[0] <= processor[0] + 4;   
            end
            execute_ORI: begin
                ORI ori_inst(.A(processor[rs]), .imm(imm), .out(temp_output));
                processor[rt] <= temp_output;
                processor[0] <= processor[0] + 4;   
            end
            execute_SLL: begin
                SLL sll_inst(.A(processor[rs]), .sa(imm), .out(temp_output));
                processor[rt] <= temp_output;
                processor[0] <= processor[0] + 4;   
            end
            execute_SRL: begin
                SRL srl_inst(.A(processor[rs]), .sa(imm), .out(temp_output));
                processor[rt] <= temp_output;
                processor[0] <= processor[0] + 4;   
            end
            execute_SLT: begin
                SLT slt_inst(.A(processor[rs]), .B(processor[rt]), .out(temp_output));
                processor[rd] <= temp_output;
                processor[0] <= processor[0] + 4;   
            end
            execute_SLTI: begin
                SLTI slti_inst(.A(processor[rs]), .imm(imm), .out(temp_output));
                processor[rt] <= temp_output;
                processor[0] <= processor[0] + 4;   
            end

        // Following are states for data transfer instructions

            execute_LW: begin
                processor[rt] <= data[ processor[rs] + {{16{address_i[15]}}, address_i} ];
                processor[0] <= processor[0] + 4;   
            end
            execute_SW: begin
                data[ processor[rs] + {{16{address_i[15]}}, address_i} ] <= processor[rt];
                processor[0] <= processor[0] + 4;   
            end

        // Following are states for branching instructions

            execute_BEQ: begin
                BEQ beq_inst(.clk(clk), .rst(rst), .r0(processor[rs]), .r1(processor[rt]), .offset(address_i), .pc_in(processor[5]), .pc_out(temp_output));
                processor[0] <= temp_output;
            end
            execute_BNE: begin
                BNE bne_inst(.clk(clk), .rst(rst), .r0(processor[rs]), .r1(processor[rt]), .offset(address_i), .pc_in(processor[5]), .pc_out(temp_output));
                processor[0] <= temp_output;
            end
            execute_BGT: begin
                BGT bgt_inst(.clk(clk), .rst(rst), .r0(processor[rs]), .r1(processor[rt]), .offset(address_i), .pc_in(processor[5]), .pc_out(temp_output));
                processor[0] <= temp_output;
            end
            execute_BGTE: begin
                BGTE bgte_inst(.clk(clk), .rst(rst), .r0(processor[rs]), .r1(processor[rt]), .offset(address_i), .pc_in(processor[5]), .pc_out(temp_output));
                processor[0] <= temp_output;
            end
            execute_BLE: begin
                BLE ble_inst(.clk(clk), .rst(rst), .r0(processor[rs]), .r1(processor[rt]), .offset(address_i), .pc_in(processor[5]), .pc_out(temp_output));
                processor[0] <= temp_output;
            end
            execute_BLEQ: begin
                BLEQ bleq_inst(.clk(clk), .rst(rst), .r0(processor[rs]), .r1(processor[rt]), .offset(address_i), .pc_in(processor[5]), .pc_out(temp_output));
                processor[0] <= temp_output;
            end
            execute_J: begin
                J j_inst(.target_address(address_j), .pc_in(processor[5]), .pc_out(temp_output), .jump_taken(jump_signal));
                processor[0] <= temp_output;
            end
            execute_JAL: begin
                JAL jal_inst(.target_address(address_j), .pc_in(processor[5]), .pc_out(temp_output), .jump_taken(jump_signal), .jal_ra(temp_output_1));
                processor[0] <= temp_output;
                processor[16] <= temp_output_1;     // storing $ra (return address)
            end
            execute_JR: begin
                JR jr_inst(.r0(processor[rs]), .pc_out(temp_output), .jump_taken(jump_signal));
                processor[0] <= temp_output;
            end
        endcase
    end   


endmodule
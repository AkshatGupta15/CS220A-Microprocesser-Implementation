`include "fetch_instructions.v"
`include "fetch_memory.v"
`include "instr_decode.v"
`include "ALU.v"
`include "branching.v"
// `include "VEDA.v"

// module top_module(clk,rst,instr_input,data_input);

// endmodule


module cse_bubble(clk,rst,d_out,instruction,d_reg,d_th);

    input clk,rst;
    output [31:0] d_out;
    output [31:0] d_reg;
    output [31:0] d_th;
    // output [31:0] d_jump;
    output [31:0] instruction;
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

     reg [31:0] data [0:255];   // this will be the VEDA memory that stores the data

    // INITIALIZATION OF SYSTEM CONTROLLED REGISTERS INSIDE THE PROCESSOR

    // reset will be activated for a very small time during the starting of the execution. That will be used by the processor
    // to intiate all the registers in it.
    // It will also be used by other modules instantiated in PROCESSOR for resetting there induvidual memory
    integer i;

    always @(posedge rst) begin 
        processor[0] <= 0;          // Set PC as 0 (start of the program)
        processor[5] <= 0;          // Clear the IR Register
        processor[6] <= 0;          // Register r0 always hardwired to 0
        processor[7] <= 0;          // Register at set to 0
        processor[16] <= 0;           // Register ra set to 0

        for(i=8;i<=13;i=i+1) begin 
            processor[i] <= 0;      // Clear all return and argument registers in processor
        end 

        processor[14] <= 0;         // Global Pointer initialized at the top of the Data Memory
        processor[15] <= 255;       // Stack Pointer initialized at the end of the Data Memory
        
        for(i=17;i<=31;i=i+1) begin 
            processor[i] <= 0;      // Clear all temp and save registers in processor
        end 

        processor[18] <= 32'b000000_00000_00000_00000_00000_000011;     // only for testing, hardcoded to 3
        //processor[19] <= 32'b000000_00000_00000_00000_00000_000011; 
        processor[19] <= 32'b000000_00000_00000_00000_00000_000011;     // only for testing, hardcoded to 3
                            //  111111_11111_11111_11111_11111_111101;

    end

    // DATA MEMORY INITIALIZATION

    always @(posedge rst) begin 
        for(i = 0; i < 32; i=i+1) begin
            data[i] <= 0;
        end    
        // data[10] <= 2;
    end


    // INSTRUCTION FETCH PHASE (MODULE WILL BE CALLED WHICH WILL LOAD THE NEXT INSTRUCTION IN IR REGISTER)
    // processor[5] is the IR register which stores the current instruction being executed
    // processor[0] is the PC register whcih stores the next instruction to be executed
    wire [31:0] instr_output;
    VEDA_instruction fetch(clk,rst, processor[0], 1'b1, 1'b0, 32'b0, instr_output);
    
    assign instruction = instr_output;

    

    // INSTRUCTION DECODE PHASE (READ THE IR REGISTER AND SEND THE CONTROL TO THAT PARTICULAR INSTRUCTION DATA PATH)

    wire [5:0] opcode, funct;
    wire [4:0] rs, rt, rd, shamt;
    wire [25:0] address_j;
    wire [15:0] address_i, imm;

    instruction_decode DCODE(clk, instr_output,opcode, rs, rd, rt, shamt, funct, address_i, address_j, imm);



    // FINITE STATE MACHINE FOR THE CONTROL SIGNALS TO EXECUTE THE PROCESSOR
    
    // Defining the states
    parameter execute_ADD = 6'b000000, execute_SUB = 6'b000001, execute_SUBU = 6'b000010, execute_ADDU = 6'b000011,
              execute_ADDI = 6'b000100, execute_ADDIU = 6'b000101, execute_AND = 6'b000110, execute_OR = 6'b000111,
              execute_ANDI = 6'b001000, execute_ORI = 6'b001001, execute_SLL = 6'b001010,  execute_SRL = 6'b001011,
              execute_LW = 6'b001100,    execute_SW = 6'b001101, execute_BEQ = 6'b001110,  execute_BNE = 6'b001111,
              execute_BGT = 6'b010000, execute_BGTE = 6'b010001, execute_BLE = 6'b010010, execute_BLEQ = 6'b010011,
              execute_J = 6'b010100, execute_JR = 6'b010101, execute_JAL = 6'b010110, execute_SLT = 6'b010111, execute_SLTI = 6'b011000;

    wire [31:0] temp_output[0:31];

    ADD add_inst(.A(processor[rs]), .B(processor[rt]), .out(temp_output[0]));
    SUB sub_inst(.A(processor[rs]), .B(processor[rt]), .diff(temp_output[1]));
    SUBU subu_inst(.A(processor[rs]), .B(processor[rt]), .diff(temp_output[2]));
    ADDU addu_inst(.A(processor[rs]), .B(processor[rt]), .out(temp_output[3]));
    ADDI addi_inst(.A(processor[rs]), .imm(imm), .out(temp_output[4]));
    ADDIU addiu_inst(.A(processor[rs]), .imm(imm), .out(temp_output[5]));
    AND and_inst(.A(processor[rs]), .B(processor[rt]), .out(temp_output[6]));
    OR or_inst(.A(processor[rs]), .B(processor[rt]), .out(temp_output[7]));
    ANDI andi_inst(.A(processor[rs]), .imm(imm), .out(temp_output[8]));
    ORI ori_inst( .A(processor[rs]), .imm(imm), .out(temp_output[9]));
    SLL sll_inst(.A(processor[rs]), .sa(imm), .out(temp_output[10]));
    SRL srl_inst(.A(processor[rs]), .sa(imm), .out(temp_output[11]));
    SLT slt_inst( .A(processor[rs]), .B(processor[rt]), .out(temp_output[12]));
    SLTI slti_inst( .A(processor[rs]), .imm(imm), .out(temp_output[13]));
    BEQ beq_inst(.clk(clk), .rst(rst), .r0(processor[rs]), .r1(processor[rt]), .offset(address_i), .pc_in(processor[0]), .pc_out(temp_output[14]));
    BNE bne_inst(.clk(clk), .rst(rst), .r0(processor[rs]), .r1(processor[rt]), .offset(address_i), .pc_in(processor[0]), .pc_out(temp_output[15]));
    BGT bgt_inst(.clk(clk), .rst(rst), .r0(processor[rs]), .r1(processor[rt]), .offset(address_i), .pc_in(processor[0]), .pc_out(temp_output[16]));
    BGTE bgte_inst(.clk(clk), .rst(rst), .r0(processor[rs]), .r1(processor[rt]), .offset(address_i), .pc_in(processor[0]), .pc_out(temp_output[17]));
    BLE ble_inst(.clk(clk), .rst(rst), .r0(processor[rs]), .r1(processor[rt]), .offset(address_i), .pc_in(processor[0]), .pc_out(temp_output[18]));
    BLEQ bleq_inst(.clk(clk), .rst(rst), .r0(processor[rs]), .r1(processor[rt]), .offset(address_i), .pc_in(processor[0]), .pc_out(temp_output[19]));
    J j_inst(.clk(clk), .target_address(address_j), .pc_in(processor[0]), .pc_out(temp_output[20]));
    JAL jal_inst(.clk(clk), .target_address(address_j), .pc_in(processor[0]), .pc_out(temp_output[22]), .jal_ra(temp_output[24]));
    JR jr_inst(.clk(clk), .r0(processor[rs]), .pc_out(temp_output[25]));

    // VEDA_memory fetch1(.clk(clk), .rst(rst), .)


    
    always @(posedge clk) begin 
        case(opcode)

        // Following are states for ALU instructions

            execute_ADD: begin
                // $display("Inside add case");
                // $display("Value of rs %b ",rs);
                // $display("Value of rt %b",rt);
                // $display("processor[rs] %b", processor[rs]);
                // $display("processor[rt] %b", processor[rt]);
                processor[rd] <= temp_output[0];
                processor[0] <= processor[0] + 1;  //incrementing the program counter
            end
            execute_SUB: begin
                processor[rd] <= temp_output[1];
                processor[0] <= processor[0] + 1;  
            end
            execute_SUBU: begin
                processor[rd] <= temp_output[2];
                processor[0] <= processor[0] + 1;  
            end
            execute_ADDU: begin
                processor[rd] <= temp_output[3];
                processor[0] <= processor[0] + 1; 
            end
            execute_ADDI: begin
                processor[rt] <= temp_output[4];
                processor[0] <= processor[0] + 1;  
            end
            execute_ADDIU: begin
                processor[rt] <= temp_output[5];
                processor[0] <= processor[0] + 1;  
            end  
            execute_AND: begin
                processor[rd] <= temp_output[6];
                processor[0] <= processor[0] + 1; 
            end    
            execute_OR: begin
                processor[rd] <= temp_output[7];
                processor[0] <= processor[0] + 1; 
            end  
            execute_ANDI: begin
                processor[rt] <= temp_output[8];
                processor[0] <= processor[0] + 1; 
            end
            execute_ORI: begin
                processor[rt] <= temp_output[9];
                processor[0] <= processor[0] + 1;   
            end
            execute_SLL: begin
                processor[rt] <= temp_output[10];
                processor[0] <= processor[0] + 1;   
            end
            execute_SRL: begin
                processor[rt] <= temp_output[11];
                processor[0] <= processor[0] + 1;   
            end
            execute_SLT: begin
                processor[rd] <= temp_output[12];
                processor[0] <= processor[0] + 1;   
            end
            execute_SLTI: begin
                processor[rt] <= temp_output[13];
                processor[0] <= processor[0] + 1;   
            end

        // // Following are states for data transfer instructions

            execute_LW: begin
                $display("%b",data[ processor[rs] + {{16{address_i[15]}}, address_i} ]);
                processor[rt] <= data[ processor[rs] + {{16{address_i[15]}}, address_i} ];
                processor[0] <= processor[0] + 1;  
            end
            execute_SW: begin
                data[ processor[rs] + {{16{address_i[15]}}, address_i} ] <= processor[rt];
                processor[0] <= processor[0] + 1;  
            end

        // // Following are states for branching instructions

            execute_BEQ: begin
                processor[0] <= temp_output[14];
            end
            execute_BNE: begin
                processor[0] <= temp_output[15];
            end
            execute_BGT: begin
                processor[0] <= temp_output[16];
            end
            execute_BGTE: begin
                processor[0] <= temp_output[17];
            end
            execute_BLE: begin
                processor[0] <= temp_output[18];
            end
            execute_BLEQ: begin
                processor[0] <= temp_output[19];
            end
            execute_J: begin
                processor[0] <= temp_output[20];
            end
            execute_JAL: begin
                processor[0] <= temp_output[22];
                processor[16] <= temp_output[24];     // storing $ra (return address)
            end
            execute_JR: begin
                processor[0] <= temp_output[26];
            end

            // Default case

            default: begin
                processor[0] <= processor[0] + 1;
            end

        endcase
    end   

    assign d_out = processor[rd];
    assign d_reg = processor[0];
    // assign d_reg = temp_output[14];
    // assign d_th = temp_output[9];
    // assign d_jump = temp_output[12];

endmodule

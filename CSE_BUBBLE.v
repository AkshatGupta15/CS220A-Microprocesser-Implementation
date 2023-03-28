`include "fetch_instr.v"
`include "instr_decode.v"

module cse_bubble(clk,rst,instr,data);

    input clk,rst;
    input [31:0] instr_input [255:0];
    input [31:0] data_input [255:0];

    reg [31:0] processor [31:0];
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

    wire [31:0] instr [255:0];  // this will be the VEDA memory that stores the instructions
    wire [31:0] data [255:0];   // this will be the VEDA memory that stores the data

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

    always @(posedge reset) begin
        processor[0] <= 0;          // Set PC as 0 (start of the program)
        processor[5] <= 0;          // Clear the IR Register
        processor[6] <= 0;          // Register r0 always hardwired to 0
        processor[7] <= 0;          // Register at set to 0
        process[16] <= 0;           // Register ra set to 0

        integer i;
        for(i=8;i<=13;i=i+1) begin 
            processor[i] <= 0;      // Clear all return and argument registers in processor
        end 

        processor[14] <= 0;           // Global Pointer initialized at the top of the Data Memory
        processor[15] <= 255;         // Stack Pointer initialized at the end of the Data Memory
        
        for(i=17;i<=31;i=i+1) begin 
            processor[i] <= 0;        // Clear all temp and save registers in processor
        end 
    end

    // INSTRUCTION FETCH PHASE (MODULE WILL BE CALLED WHICH WILL LOAD THE NEXT INSTRUCTION IN IR REGISTER)
    VEDA fetch(clk,rst, processor[0], instr, processor[5])





endmodule
module instruction_decode(
  input [5:0] opcode,
  output reg execute_add,
  output reg execute_sub,
  output reg execute_subu,
  output reg execute_addu,
  output reg execute_addi,
  output reg execute_addiu,
  output reg execute_and,
  output reg execute_or,
  output reg execute_andi,
  output reg execute_ori
);

  always @(*)
  begin
    case(opcode)
      6'b000000: // opcode for addition
        begin
          execute_add = 1;
          execute_sub = 0;
          execute_subu = 0;
          execute_addu = 0;
          execute_addi = 0;
          execute_addiu = 0;
          execute_and = 0;
          execute_or = 0;
          execute_andi = 0;
          execute_ori = 0;
        end
      
      6'b000001: // opcode for subtraction
        begin
          execute_add = 0;
          execute_sub = 1;
          execute_subu = 0;
          execute_addu = 0;
          execute_addi = 0;
          execute_addiu = 0;
          execute_and = 0;
          execute_or = 0;
          execute_andi= 0;
          execute_ori = 0;
        end
      
      6'b000010: // opcode for subu
        begin
          execute_add = 0;
          execute_sub = 0;
          execute_subu = 1;
          execute_addu = 0;
          execute_addi = 0;
          execute_addiu = 0;
          execute_and = 0;
          execute_or = 0;
          execute_andi = 0;
          execute_ori = 0;
        end
      
      6'b000011: // opcode for addu
        begin
          execute_add = 0;
          execute_sub = 0;
          execute_subu = 0;
          execute_addu = 1;
          execute_addi = 0;
          execute_addiu = 0;
          execute_and = 0;
          execute_or = 0; 
          execute_andi = 0;
          execute_ori = 0;
        end

      6'b000100: // opcode for addi 
        begin
          execute_add = 0;
          execute_sub = 0;
          execute_subu = 0;
          execute_addu = 0;
          execute_addi = 1;
          execute_addiu = 0;
          execute_and = 0;
          execute_or = 0;
          execute_andi = 0;
          execute_ori = 0;
        end  

      6'b000101:  // opcode for addiu
        begin
          execute_add = 0;
          execute_sub = 0;
          execute_subu = 0;
          execute_addu = 0;
          execute_addi = 0;
          execute_addiu = 1;
          execute_and = 0;
          execute_or = 0;
          execute_andi = 0;
          execute_ori = 0;
        end  

       6'b000110:  // opcode for and
        begin
          execute_add = 0;
          execute_sub = 0;
          execute_subu = 0;
          execute_addu = 0;
          execute_addi = 0;
          execute_addiu = 0;
          execute_and = 1;
          execute_or = 0;
          execute_andi = 0;
          execute_ori = 0;
        end   

       6'b000111:  // opcode for or
        begin
          execute_add = 0;
          execute_sub = 0;
          execute_subu = 0;
          execute_addu = 0;
          execute_addi = 0;
          execute_addiu = 0;
          execute_and = 0;
          execute_or = 1;
          execute_andi = 0;
          execute_ori = 0;
        end  

       6'b001000:  // opcode for andi
        begin
          execute_add = 0;
          execute_sub = 0;
          execute_subu = 0;
          execute_addu = 0;
          execute_addi = 0;
          execute_addiu = 0;
          execute_and = 0;
          execute_or = 0;
          execute_andi = 1;
          execute_ori = 0;
        end      

       6'b001001:  // opcode for ori
        begin
          execute_add = 0;
          execute_sub = 0;
          execute_subu = 0;
          execute_addu = 0;
          execute_addi = 0;
          execute_addiu = 0;
          execute_and = 0;
          execute_or = 0;
          execute_andi = 0;
          execute_ori = 1;
        end     

      default:
        begin
          execute_add = 0;
          execute_sub = 0;
          execute_subu = 0;
          execute_addu = 0;
          execute_addi = 0;
          execute_addiu = 0;
          execute_and = 0;
          execute_or = 0;
          execute_andi = 0;
          execute_ori = 0;
        end

    endcase
  end


endmodule        
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
  output reg execute_ori,
  output reg execute_sll,
  output reg execute_srl,
  output reg execute_lw,
  output reg execute_sw,
  output reg execute_beq,
  output reg execute_bne,
  output reg execute_bgt,
  output reg execute_bgte,
  output reg execute_ble,
  output reg execute_bleq,
  output reg execute_j,
  output reg execute_jr,
  output reg execute_jal,
  output reg execute_slt,
  output reg execute_slti
);

  always @(*)
  begin
    case(opcode)
      6'b000000: // opcode for add
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
          execute_sll = 0;
          execute_srl = 0;
          execute_lw = 0;
          execute_sw = 0;
          execute_beq = 0;
          execute_bne = 0;
          execute_bgt = 0;
          execute_bgte = 0;
          execute_ble = 0;
          execute_bleq = 0;
          execute_j = 0;
          execute_jr = 0;
          execute_jal = 0;
          execute_slt = 0;
          execute_slti = 0;
        end
      
      6'b000001: // opcode for sub
        begin
          execute_add = 0;
          execute_sub = 1;
          execute_subu = 0;
          execute_addu = 0;
          execute_addi = 0;
          execute_addiu = 0;
          execute_and = 0;
          execute_or = 0;
          execute_andi = 0;
          execute_ori = 0;
          execute_sll = 0;
          execute_srl = 0;
          execute_lw = 0;
          execute_sw = 0;
          execute_beq = 0;
          execute_bne = 0;
          execute_bgt = 0;
          execute_bgte = 0;
          execute_ble = 0;
          execute_bleq = 0;
          execute_j = 0;
          execute_jr = 0;
          execute_jal = 0;
          execute_slt = 0;
          execute_slti = 0;
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
          execute_sll = 0;
          execute_srl = 0;
          execute_lw = 0;
          execute_sw = 0;
          execute_beq = 0;
          execute_bne = 0;
          execute_bgt = 0;
          execute_bgte = 0;
          execute_ble = 0;
          execute_bleq = 0;
          execute_j = 0;
          execute_jr = 0;
          execute_jal = 0;
          execute_slt = 0;
          execute_slti = 0;
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
          execute_sll = 0;
          execute_srl = 0;
          execute_lw = 0;
          execute_sw = 0;
          execute_beq = 0;
          execute_bne = 0;
          execute_bgt = 0;
          execute_bgte = 0;
          execute_ble = 0;
          execute_bleq = 0;
          execute_j = 0;
          execute_jr = 0;
          execute_jal = 0;
          execute_slt = 0;
          execute_slti = 0;
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
          execute_sll = 0;
          execute_srl = 0;
          execute_lw = 0;
          execute_sw = 0;
          execute_beq = 0;
          execute_bne = 0;
          execute_bgt = 0;
          execute_bgte = 0;
          execute_ble = 0;
          execute_bleq = 0;
          execute_j = 0;
          execute_jr = 0;
          execute_jal = 0;
          execute_slt = 0;
          execute_slti = 0;
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
          execute_sll = 0;
          execute_srl = 0;
          execute_lw = 0;
          execute_sw = 0;
          execute_beq = 0;
          execute_bne = 0;
          execute_bgt = 0;
          execute_bgte = 0;
          execute_ble = 0;
          execute_bleq = 0;
          execute_j = 0;
          execute_jr = 0;
          execute_jal = 0;
          execute_slt = 0;
          execute_slti = 0;
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
          execute_sll = 0;
          execute_srl = 0;
          execute_lw = 0;
          execute_sw = 0;
          execute_beq = 0;
          execute_bne = 0;
          execute_bgt = 0;
          execute_bgte = 0;
          execute_ble = 0;
          execute_bleq = 0;
          execute_j = 0;
          execute_jr = 0;
          execute_jal = 0;
          execute_slt = 0;
          execute_slti = 0;
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
          execute_sll = 0;
          execute_srl = 0;
          execute_lw = 0;
          execute_sw = 0;
          execute_beq = 0;
          execute_bne = 0;
          execute_bgt = 0;
          execute_bgte = 0;
          execute_ble = 0;
          execute_bleq = 0;
          execute_j = 0;
          execute_jr = 0;
          execute_jal = 0;
          execute_slt = 0;
          execute_slti = 0;
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
          execute_sll = 0;
          execute_srl = 0;
          execute_lw = 0;
          execute_sw = 0;
          execute_beq = 0;
          execute_bne = 0;
          execute_bgt = 0;
          execute_bgte = 0;
          execute_ble = 0;
          execute_bleq = 0;
          execute_j = 0;
          execute_jr = 0;
          execute_jal = 0;
          execute_slt = 0;
          execute_slti = 0;
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
          execute_sll = 0;
          execute_srl = 0;
          execute_lw = 0;
          execute_sw = 0;
          execute_beq = 0;
          execute_bne = 0;
          execute_bgt = 0;
          execute_bgte = 0;
          execute_ble = 0;
          execute_bleq = 0;
          execute_j = 0;
          execute_jr = 0;
          execute_jal = 0;
          execute_slt = 0;
          execute_slti = 0;
        end   

      6'b001010:    // opcode for sll
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
          execute_sll = 1;
          execute_srl = 0;
          execute_lw = 0;
          execute_sw = 0;
          execute_beq = 0;
          execute_bne = 0;
          execute_bgt = 0;
          execute_bgte = 0;
          execute_ble = 0;
          execute_bleq = 0;
          execute_j = 0;
          execute_jr = 0;
          execute_jal = 0;
          execute_slt = 0;
          execute_slti = 0;
      end   

      6'b001011:      // opcode for srl
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
          execute_sll = 0;
          execute_srl = 1;
          execute_lw = 0;
          execute_sw = 0;
          execute_beq = 0;
          execute_bne = 0;
          execute_bgt = 0;
          execute_bgte = 0;
          execute_ble = 0;
          execute_bleq = 0;
          execute_j = 0;
          execute_jr = 0;
          execute_jal = 0;
          execute_slt = 0;
          execute_slti = 0;
      end 

      6'b001100:      // opcode for lw
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
          execute_sll = 0;
          execute_srl = 0;
          execute_lw = 1;
          execute_sw = 0;
          execute_beq = 0;
          execute_bne = 0;
          execute_bgt = 0;
          execute_bgte = 0;
          execute_ble = 0;
          execute_bleq = 0;
          execute_j = 0;
          execute_jr = 0;
          execute_jal = 0;
          execute_slt = 0;
          execute_slti = 0;
      end

      6'b001101:      // opcode for sw
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
          execute_sll = 0;
          execute_srl = 0;
          execute_lw = 0;
          execute_sw = 1;
          execute_beq = 0;
          execute_bne = 0;
          execute_bgt = 0;
          execute_bgte = 0;
          execute_ble = 0;
          execute_bleq = 0;
          execute_j = 0;
          execute_jr = 0;
          execute_jal = 0;
          execute_slt = 0;
          execute_slti = 0;
      end 

      6'b001110:      // opcode for beq
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
          execute_sll = 0;
          execute_srl = 0;
          execute_lw = 0;
          execute_sw = 0;
          execute_beq = 1;
          execute_bne = 0;
          execute_bgt = 0;
          execute_bgte = 0;
          execute_ble = 0;
          execute_bleq = 0;
          execute_j = 0;
          execute_jr = 0;
          execute_jal = 0;
          execute_slt = 0;
          execute_slti = 0;
      end

      6'b001111:      // opcode for bne
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
          execute_sll = 0;
          execute_srl = 0;
          execute_lw = 0;
          execute_sw = 0;
          execute_beq = 0;
          execute_bne = 1;
          execute_bgt = 0;
          execute_bgte = 0;
          execute_ble = 0;
          execute_bleq = 0;
          execute_j = 0;
          execute_jr = 0;
          execute_jal = 0;
          execute_slt = 0;
          execute_slti = 0;
      end

      6'b010000:      // opcode for bgt
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
          execute_sll = 0;
          execute_srl = 0;
          execute_lw = 0;
          execute_sw = 0;
          execute_beq = 0;
          execute_bne = 0;
          execute_bgt = 1;
          execute_bgte = 0;
          execute_ble = 0;
          execute_bleq = 0;
          execute_j = 0;
          execute_jr = 0;
          execute_jal = 0;
          execute_slt = 0;
          execute_slti = 0;
      end

      6'b010001:      // opcode for bgte
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
          execute_sll = 0;
          execute_srl = 0;
          execute_lw = 0;
          execute_sw = 0;
          execute_beq = 0;
          execute_bne = 0;
          execute_bgt = 0;
          execute_bgte = 1;
          execute_ble = 0;
          execute_bleq = 0;
          execute_j = 0;
          execute_jr = 0;
          execute_jal = 0;
          execute_slt = 0;
          execute_slti = 0;
      end

      6'b010010:      // opcode for ble
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
          execute_sll = 0;
          execute_srl = 0;
          execute_lw = 0;
          execute_sw = 0;
          execute_beq = 0;
          execute_bne = 0;
          execute_bgt = 0;
          execute_bgte = 0;
          execute_ble = 1;
          execute_bleq = 0;
          execute_j = 0;
          execute_jr = 0;
          execute_jal = 0;
          execute_slt = 0;
          execute_slti = 0;
      end

      6'b010011:      // opcode for bleq
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
          execute_sll = 0;
          execute_srl = 0;
          execute_lw = 0;
          execute_sw = 0;
          execute_beq = 0;
          execute_bne = 0;
          execute_bgt = 0;
          execute_bgte = 0;
          execute_ble = 0;
          execute_bleq = 1;
          execute_j = 0;
          execute_jr = 0;
          execute_jal = 0;
          execute_slt = 0;
          execute_slti = 0;
      end

      6'b010100:      // opcode for j
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
          execute_sll = 0;
          execute_srl = 0;
          execute_lw = 0;
          execute_sw = 0;
          execute_beq = 0;
          execute_bne = 0;
          execute_bgt = 0;
          execute_bgte = 0;
          execute_ble = 0;
          execute_bleq = 0;
          execute_j = 1;
          execute_jr = 0;
          execute_jal = 0;
          execute_slt = 0;
          execute_slti = 0;
      end

      6'b010101:      // opcode for jr
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
          execute_sll = 0;
          execute_srl = 0;
          execute_lw = 0;
          execute_sw = 0;
          execute_beq = 0;
          execute_bne = 0;
          execute_bgt = 0;
          execute_bgte = 0;
          execute_ble = 0;
          execute_bleq = 0;
          execute_j = 0;
          execute_jr = 1;
          execute_jal = 0;
          execute_slt = 0;
          execute_slti = 0;
      end

      6'b010110:      // opcode for jal
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
          execute_sll = 0;
          execute_srl = 0;
          execute_lw = 0;
          execute_sw = 0;
          execute_beq = 0;
          execute_bne = 0;
          execute_bgt = 0;
          execute_bgte = 0;
          execute_ble = 0;
          execute_bleq = 0;
          execute_j = 0;
          execute_jr = 0;
          execute_jal = 1;
          execute_slt = 0;
          execute_slti = 0;
      end

      6'b010111:      // opcode for slt
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
          execute_sll = 0;
          execute_srl = 0;
          execute_lw = 0;
          execute_sw = 0;
          execute_beq = 0;
          execute_bne = 0;
          execute_bgt = 0;
          execute_bgte = 0;
          execute_ble = 0;
          execute_bleq = 0;
          execute_j = 0;
          execute_jr = 0;
          execute_jal = 0;
          execute_slt = 1;
          execute_slti = 0;
      end

      6'b011000:      // opcode for slti
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
          execute_sll = 0;
          execute_srl = 0;
          execute_lw = 0;
          execute_sw = 0;
          execute_beq = 0;
          execute_bne = 0;
          execute_bgt = 0;
          execute_bgte = 0;
          execute_ble = 0;
          execute_bleq = 0;
          execute_j = 0;
          execute_jr = 0;
          execute_jal = 0;
          execute_slt = 0;
          execute_slti = 1;
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
          execute_sll = 0;
          execute_srl = 0;
          execute_lw = 0;
          execute_sw = 0;
          execute_beq = 0;
          execute_bne = 0;
          execute_bgt = 0;
          execute_bgte = 0;
          execute_ble = 0;
          execute_bleq = 0;
          execute_j = 0;
          execute_jr = 0;
          execute_jal = 0;
          execute_slt = 0;
          execute_slti = 0;
        end

    endcase
  end


endmodule        
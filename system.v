module sys_execute(input [5:0] opcode, input [31:0] regv, input [31:0] rega);

    always @(opcode) begin

        // if syscall was not called
        if(opcode != 6'b011001) begin
        end

        // to display int with space
        else if(regv == 32'b000000_00000_00000_00000_00000_000001) begin
            $display("%d ", rega);
        end

        // to display whitespace
        else if(regv == 32'b000000_00000_00000_00000_00000_001011) begin
            $display(" ");
        end

        // to exit program
        else if(regv == 32'b000000_00000_00000_00000_00000_001010 ) begin
            #500
            $finish;
        end

    end

endmodule
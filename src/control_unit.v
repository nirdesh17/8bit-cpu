module control_unit (
    input [2:0] operation,    // Operation code from instruction decoder
    output reg alu_src,       // ALU source selection
    output reg reg_write,     // Register write enable
    output reg mem_read,      // Memory read enable (if you have memory)
    output reg mem_write,     // Memory write enable (if you have memory)
    output reg [2:0] alu_op   // ALU operation code
);

    always @(*) begin
        // Default values
        alu_src = 0;
        reg_write = 0;
        mem_read = 0;
        mem_write = 0;
        alu_op = 4'b000;

        case (operation)
            4'b0000: begin // ADD
                alu_src = 1;
                reg_write = 1;
                alu_op = 3'b000;
            end
            4'b0001: begin // SUB
                alu_src = 1;
                reg_write = 1;
                alu_op = 3'b001;
            end
            4'b0010: begin // MUL
                alu_src = 1;
                reg_write = 1;
                alu_op = 3'b010;
            end
            4'b0011: begin // DIV
                alu_src = 1;
                reg_write = 1;
                alu_op = 3'b011;
            end
            4'b0100: begin // AND
                alu_src = 1;
                reg_write = 1;
                alu_op = 3'b100;
            end
            4'b0101: begin // OR
                alu_src = 1;
                reg_write = 1;
                alu_op = 3'b101;
            end
            4'b0110: begin // XOR
                alu_src = 1;
                reg_write = 1;
                alu_op = 3'b110;
            end
            default: begin
                // Default case
                alu_src = 0;
                reg_write = 0;
                alu_op = 3'b000;
            end
        endcase
    end
endmodule

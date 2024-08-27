module instruction_decoder (
    input [7:0] instruction,       // 8-bit instruction input
    input clk,
    output reg [2:0] read_reg1,    // 3-bit read register 1
    output reg [2:0] read_reg2,    // 3-bit read register 2
    output reg [2:0] write_reg,    // 3-bit write register
    output reg [7:0] write_data,   // 8-bit data to write
    output reg [2:0] operation,    // 4-bit operation code for ALU
    output reg write_enable,       // Write enable signal for registers
    output reg reg_write           // Register write signal
);

    // Opcode definitions
    parameter ADD = 4'b0001;
    parameter SUB = 4'b0010;
    parameter MUL = 4'b0011;
    parameter DIV = 4'b0100;
    parameter AND = 4'b0101;
    parameter OR  = 4'b0110;
    parameter XOR = 4'b0111;

    always @(*) begin
        // Default values
        operation = 4'b000;
        write_enable = 0;
        reg_write = 0;
        write_data = 8'b00000000;
        read_reg1 = 3'b000;
        read_reg2 = 3'b000;
        write_reg = 3'b000;

        case (instruction[7:4]) // Assuming the upper 4 bits are the opcode
            ADD: begin
                operation = 3'b000; // ALU operation code for addition
            end

            SUB: begin
                operation = 3'b001; // ALU operation code for subtraction
            end

            MUL: begin
                operation = 3'b010; // ALU operation code for multiplication
            end

            DIV: begin
                operation = 3'b011; // ALU operation code for division
            end

            AND: begin
                operation = 3'b100; // ALU operation code for bitwise AND
            end

            OR: begin
                operation = 3'b101; // ALU operation code for bitwise OR
            end

            XOR: begin
                operation = 3'b110; // ALU operation code for bitwise XOR
            end

            default: begin
                // Default behavior or NOP
                operation = 4'b0000;
                write_enable = 0;
                reg_write = 0;
            end
        endcase

        // Register read and write operations
        read_reg1 = instruction[2:0]; // Update the bit positions as necessary
        read_reg2 = instruction[5:3]; // Example for different fields
        write_reg = instruction[3:1]; // Write register from bits 3 to 1
        write_enable = 1;             // Enable writing to the register
        reg_write = 1;                // Set the register write signal
    end

endmodule

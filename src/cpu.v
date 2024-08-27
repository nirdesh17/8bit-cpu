// module cpu (
//     input wire clk,            // Clock signal
//     input wire reset,          // Reset signal
//     input wire [12:0] instr,   // Input instruction (extended to 16 bits for immediate)
//     output wire [7:0] result   // Final output result
// );
//     // Internal signals
//     wire [7:0] reg_data1, reg_data2; // Register data outputs
//     reg [7:0] operand1, operand2;    // Operands for ALU
//     wire [7:0] alu_result;           // ALU result
//     reg write_enable;                // Register write enable
//     reg [2:0] alu_op;                // ALU operation code
//     reg [2:0] dest_reg;              // Destination register address
//     reg [7:0] reg_write_data;        // Data to write to register
//     reg immediate_mode;              // Flag for immediate mode

//     // Decode instruction
//     always @(*) begin
//         alu_op = instr[11:9];       // Opcode (3 bits)
//         immediate_mode = instr[12];  // Immediate mode flag (1 bit)
        
//         if (immediate_mode) begin
//             operand1 = reg_data1;    // Operand 1 from register
//             operand2 = instr[7:0];   // Operand 2 is immediate value (8 bits)
//         end else begin
//             operand1 = reg_data1;    // Operand 1 from register
//             operand2 = reg_data2;    // Operand 2 from register
//         end

//         dest_reg = instr[2:0];       // Destination register (3 bits)
//         write_enable = 1'b1;         // Always enable write to destination register
//     end

//     // Instantiate register file
//     register reg_file (
//         .clk(clk),
//         .write_enable(write_enable),
//         .read_reg1(instr[11:9]),  // Operand 1 register
//         .read_reg2(instr[8:6]),   // Operand 2 register (if not immediate)
//         .write_data(reg_write_data),
//         .read_data1(reg_data1),
//         .read_data2(reg_data2)
//     );

//     // Instantiate ALU
//     alu alu_inst (
//         .operand1(operand1),
//         .operand2(operand2),
//         .operation(alu_op),
//         .enable(1'b1),            // Always enabled
//         .result(alu_result)
//     );

//     // Write ALU result back to register file
//     always @(posedge clk or posedge reset) begin
//         if (reset) begin
//             reg_write_data <= 8'b00000000;
//         end else begin
//             reg_write_data <= alu_result; // Write the result back to the register
//         end
//     end

//     // Output the result of the ALU
//     assign result = alu_result;

// endmodule



module cpu (
    input wire clk,            // Clock signal
    input wire reset,          // Reset signal
    input wire [12:0] instr,   // Input instruction (13 bits)
    output wire [7:0] result   // Final output result
);
    // Internal signals
    wire [7:0] reg_data1, reg_data2; // Register data outputs
    reg [7:0] operand1, operand2;    // Operands for ALU
    wire [7:0] alu_result;           // ALU result
    reg write_enable;                // Register write enable
    reg [2:0] alu_op;                // ALU operation code
    reg [2:0] dest_reg;              // Destination register address
    reg [7:0] reg_write_data;        // Data to write to register
    reg immediate_mode;              // Flag for immediate mode

    // Decode instruction
    always @(*) begin
        immediate_mode = instr[12];  // Immediate mode flag (1 bit)
        
        if (immediate_mode) begin
            // Immediate mode
            operand1 = 8'b00000000;   // No second operand in immediate mode
            operand2 = instr[7:0];    // Immediate value (8 bits)
            dest_reg = instr[11:9];   // Register to store immediate value
            write_enable = 1'b1;      // Enable write to destination register
            alu_op = 3'b000;          // No ALU operation needed in immediate mode
        end else begin
            // Register-based mode
            operand1 = reg_data1;    // Operand 1 from register
            operand2 = reg_data2;    // Operand 2 from register
            dest_reg = instr[5:3];   // Destination register
            alu_op = instr[2:0];     // ALU operation code
            write_enable = 1'b1;     // Enable write to destination register
        end
    end

    // Instantiate register file
    register reg_file (
        .clk(clk),
        .write_enable(write_enable),
        .read_reg1(instr[11:9]),  // Operand 1 register or destination register (if immediate)
        .read_reg2(instr[8:6]),   // Operand 2 register (if not immediate)
        .write_data(reg_write_data),
        .read_data1(reg_data1),
        .read_data2(reg_data2)
    );

    // Instantiate ALU
    alu alu_inst (
        .operand1(operand1),
        .operand2(operand2),
        .operation(alu_op),
        .enable(1'b1),            // Always enabled
        .result(alu_result)
    );

    // Write ALU result back to register file
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            reg_write_data <= 8'b00000000;
        end else begin
            if (!immediate_mode) begin
                reg_write_data <= alu_result; // Write the result back to the register
            end
        end
    end

    // Assign the result of the ALU to the output
    assign result = (immediate_mode) ? reg_data1 : alu_result;

endmodule

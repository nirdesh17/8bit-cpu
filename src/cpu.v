module cpu (
    input wire clk,              // Clock signal
    input wire reset,            // Reset signal
    input wire [12:0] instr,     // Input instruction (13 bits)
    output reg [7:0] result      // Final output result
);
    wire [7:0] operand1, operand2;   // Operands for ALU
    wire [7:0] alu_result;          // ALU result
    reg [2:0] alu_op;               // ALU operation code
    reg [2:0] dest_reg;             // Destination register address
    reg [7:0] reg_write_data;       // Data to write to register
    reg [1:0] cycle;                // Cycle counter
    wire [7:0] reg_data1, reg_data2; // Data from registers
    reg write_enable;               // Register write enable

    // Program Counter
    wire [7:0] pc;                  // Program counter output
    reg pc_enable;                  // Program counter enable

    program_counter pc_inst (
        .clk(clk),
        .reset(reset),
        .enable(pc_enable),
        .pc(pc)
    );

    // Instantiate the register file
    register reg_file (
        .clk(clk),
        .write_enable(write_enable),
        .read_reg1(instr[11:9]),    // Read register 1 (based on instruction)
        .read_reg2(instr[8:6]),     // Read register 2 (based on instruction)
        .write_data(reg_write_data),
        .read_data1(reg_data1),
        .read_data2(reg_data2)
    );

    // ALU instantiation
    alu alu_inst (
        .operand1(operand1),
        .operand2(operand2),
        .operation(alu_op),
        .enable(1'b1),              // Always enabled
        .result(alu_result)
    );

    assign operand1 = reg_data1;  

    assign operand2 = reg_data2;
    // Control Logic for 4-Cycle Operation
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            cycle <= 2'b00;         // Start at cycle 0
            pc_enable <= 1'b1;      // Enable program counter
        end else begin
            case (cycle)
                2'b00: begin
                    // Cycle 1: Fetch first instruction and store in register
                    dest_reg <= instr[11:9];   // Destination register for first instruction
                    reg_write_data <= instr[7:0]; // First instruction value
                    write_enable <= 1'b1;      // Enable writing to the register
                    cycle <= 2'b01;            // Move to next cycle
                end
                2'b01: begin
                    // Cycle 2: Fetch second instruction and store in another register
                    dest_reg <= instr[11:9];    // Destination register for second instruction
                    reg_write_data <= instr[7:0]; // Second instruction value
                    write_enable <= 1'b1;      // Enable writing to the register
                    cycle <= 2'b10;            // Move to next cycle
                end
                2'b10: begin
                    dest_reg <= instr[5:3];
                    alu_op <= instr[2:0];  
                    cycle <= 2'b11;            // Move to next cycle
                end
                2'b11: begin
                    // Cycle 4: Store ALU result in destination register
                    dest_reg <= instr[5:3];    // Destination register for ALU result
                    reg_write_data <= alu_result; // Write the ALU result
                    write_enable <= 1'b1;      // Enable writing to the register
                    result <= alu_result;      // Output the result
                    cycle <= 2'b00;            // Reset cycle for the next instruction
                end
            endcase
        end
    end
endmodule

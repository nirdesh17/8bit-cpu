module cpu (
    input wire clk,
    input wire reset,
    output wire [7:0] result,   // To observe the result
    output wire carry_out        // To observe the carry out
);

    // Wires for connections between components
    
    wire [7:0] pc_value;
    wire [7:0] instruction;
    wire [7:0] reg_data1, reg_data2;
    wire [7:0] alu_result;
    wire alu_carry_out;
    wire [2:0] read_reg1, read_reg2, write_reg;
    wire [7:0] write_data;
    wire [2:0] alu_op;
    wire reg_write, write_enable, alu_src;
    wire mem_read, mem_write;
    wire load_pc, increment_pc;

    // Instantiate the Program Counter
    program_counter pc (
        .clk(clk),
        .reset(reset),
        .new_addr(write_data),  // Assume write_data contains the new address
        .load(load_pc),
        .increment(increment_pc),
        .pc(pc_value)
    );

    // Instantiate the Memory Module
    memory mem (
        .clk(clk),
        .we(mem_write),         // Memory write enable
        .addr(pc_value),        // Address is the PC value for instruction fetch
        .data_in(alu_result),   // Data to write (if any)
        .data_out(instruction)  // Output data from memory (instruction fetch)
    );

    // Instantiate the Instruction Decoder
    instruction_decoder decoder (
        .instruction(instruction),
        .clk(clk),
        .read_reg1(read_reg1),
        .read_reg2(read_reg2),
        .write_reg(write_reg),
        .write_data(write_data),
        .operation(alu_op),
        .write_enable(write_enable),
        .reg_write(reg_write)
    );

    // Instantiate the Register File
    register reg_file (
        .clk(clk),
        .write_enable(write_enable),
        .read_reg1(read_reg1),
        .read_reg2(read_reg2),
        .write_reg(write_reg),
        .write_data(write_data),
        .read_data1(reg_data1),
        .read_data2(reg_data2)
    );

    // Instantiate the ALU
    alu arithmetic_logic_unit (
        .operand1(reg_data1),
        .operand2(reg_data2),
        .operation(alu_op),
        .result(alu_result),
        .carry_out(alu_carry_out)
    );

    // Instantiate the Control Unit
    control_unit ctrl_unit (
        .operation(alu_op),
        .alu_src(alu_src),
        .reg_write(reg_write),
        .mem_read(mem_read),
        .mem_write(mem_write),
        .alu_op(alu_op)
    );

    // Connect outputs
    assign result = alu_result;
    assign carry_out = alu_carry_out;

    // PC Control Signals
    assign load_pc = reg_write;     // Example condition
    assign increment_pc = 1'b1;     // Example condition (increment always for simplicity)

endmodule

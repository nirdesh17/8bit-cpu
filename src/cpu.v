module cpu (
    input wire clk,              // Clock signal
    input wire reset,            // Reset signal
    input wire [15:0] instr,     // Input instruction (16 bits)
    output reg [7:0] result      // Final output result
);
    wire [7:0] operand1;         // Operand1 for ALU
    reg [7:0] operand2;          // Operand2 for ALU
    wire [7:0] alu_result;       // ALU result (from alu module)
    reg [2:0] alu_op;            // ALU operation code
    reg [3:0] dest_reg;          // Destination register address
    reg [7:0] reg_write_data;    // Data to write to register
    reg [7:0] addr;              // Memory address
    reg write_enable;            // Register write enable
    wire [7:0] data_out;        // Data output from memory

    
    memory mem_inst (
        .clk(clk),
        .write_enable(write_enable),
        .addr(addr),
        .data_in(reg_write_data),
        .data_out(data_out)
    );

    // Register file instantiation
    register reg_file (
        .clk(clk),
        .write_enable(write_enable),
        .read_reg1(dest_reg),    // Read register 1 (based on instruction)
        .write_data(reg_write_data),
        .read_data1(operand1)
    );

    // ALU instantiation
    alu alu_inst (
        .operand1(operand1),
        .operand2(operand2),
        .operation(alu_op),
        .enable(1'b1),            // Always enabled
        .result(alu_result)
    );

    // Always block for combinational logic
    always @(*) begin
        alu_op = instr[14:12];   // Extract ALU operation from instruction
        
    end

    // Sequential logic
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            result <= 8'b0;
            write_enable <= 0;
        end else begin
            case (alu_op)
                3'b000: begin // Immediate load to Register
                    write_enable <= 1;
                    dest_reg <= instr[11:8]; 
                    reg_write_data <= instr[7:0];
                end

                3'b001: begin // Register to memory
                    write_enable <= 1;
                    addr <= instr[7:0];
                    dest_reg <= instr[11:8];
                    reg_write_data <= operand1;
                end

                3'b010: begin // Memory read operation
                    write_enable <= 0;         // Ensure memory is in read mode
                    addr <= instr[7:0];        // Set the address
                    result <= data_out;  
                    dest_reg <= instr[11:8];
                    reg_write_data <=data_out;    // Store the memory output
                end

                3'b011: begin // ALU + operation
                    write_enable <= 1;
                    dest_reg <= instr[11:8]; 
                    operand2 <=instr[7:0];
                    result <= alu_result;
                    operand2 = instr[7:0];   // Operand2 comes from the immediate value
                    reg_write_data <=alu_result;
                end

                default: begin
                    write_enable <= 0;
                end
            endcase
        end
    end
endmodule

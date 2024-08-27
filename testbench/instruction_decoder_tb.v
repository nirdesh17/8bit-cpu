module instruction_decoder_tb;

    // Testbench signals
    reg [7:0] instruction;   // 8-bit instruction input
    reg clk;                 // Clock signal
    wire [2:0] read_reg1;    // 3-bit read register 1
    wire [2:0] read_reg2;    // 3-bit read register 2
    wire [2:0] write_reg;    // 3-bit write register
    wire [7:0] write_data;   // 8-bit data to write
    wire [3:0] operation;    // 4-bit operation code for ALU
    wire write_enable;       // Write enable signal for registers
    wire reg_write;          // Register write signal

    // Instantiate the instruction decoder
    instruction_decoder uut (
        .instruction(instruction),
        .clk(clk),
        .read_reg1(read_reg1),
        .read_reg2(read_reg2),
        .write_reg(write_reg),
        .write_data(write_data),
        .operation(operation),
        .write_enable(write_enable),
        .reg_write(reg_write)
    );

    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk;  // 10ns clock period
    end

    // Test cases
    initial begin
        // Initialize signals
        instruction = 8'b00000000;
        
        // Test ADD instruction (opcode 0001)
        instruction = 8'b00010000; // Opcode ADD (0001), read_reg1 = 000, read_reg2 = 000, write_reg = 000
        #10;
        check_results(3'b000, 3'b000, 3'b000, 8'b00000000, 4'b0000, 1, 1);

        // Test SUB instruction (opcode 0010)
        instruction = 8'b00100001; // Opcode SUB (0010), read_reg1 = 000, read_reg2 = 001, write_reg = 000
        #10;
        check_results(3'b000, 3'b001, 3'b000, 8'b00000000, 4'b0001, 1, 1);

        $finish;
    end

    // Check results
    task check_results(
        input [2:0] expected_read_reg1,
        input [2:0] expected_read_reg2,
        input [2:0] expected_write_reg,
        input [7:0] expected_write_data,
        input [3:0] expected_operation,
        input expected_write_enable,
        input expected_reg_write
    );
        begin
            if (read_reg1 !== expected_read_reg1 ||
                read_reg2 !== expected_read_reg2 ||
                write_reg !== expected_write_reg ||
                write_data !== expected_write_data ||
                operation !== expected_operation ||
                write_enable !== expected_write_enable ||
                reg_write !== expected_reg_write) begin
                $display("Test failed! Expected: read_reg1=%b, read_reg2=%b, write_reg=%b, write_data=%b, operation=%b, write_enable=%b, reg_write=%b",
                         expected_read_reg1, expected_read_reg2, expected_write_reg, expected_write_data, expected_operation, expected_write_enable, expected_reg_write);
                $stop;
            end
            else begin
                $display("Test passed! read_reg1=%b, read_reg2=%b, write_reg=%b, write_data=%b, operation=%b, write_enable=%b, reg_write=%b",
                         read_reg1, read_reg2, write_reg, write_data, operation, write_enable, reg_write);
            end
        end
    endtask

endmodule

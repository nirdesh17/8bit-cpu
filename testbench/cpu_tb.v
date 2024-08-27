module cpu_tb;

    // Testbench signals
    reg clk;
    reg reset;
    reg [7:0] instruction_memory [255:0]; // Memory to hold instructions
    reg [2:0] reg_write_addr;  // Register to write
    reg [7:0] reg_write_data;  // Data to write into the register
    reg reg_write_enable;      // Enable write signal for registers

    wire [7:0] result;
    wire carry_out;
    wire [7:0] read_data1;     // Monitor read data 1
    wire [7:0] read_data2;     // Monitor read data 2

    // Instantiate the CPU
    cpu uut (
        .clk(clk),
        .reset(reset),
        .result(result),
        .carry_out(carry_out)
    );

    // Instantiate Register File
    register reg_file (
        .clk(clk),
        .write_enable(reg_write_enable),
        .read_reg1(uut.reg_file.read_reg1), // Assuming these are accessible
        .read_reg2(uut.reg_file.read_reg2), // Assuming these are accessible
        .write_reg(reg_write_addr),
        .write_data(reg_write_data),
        .read_data1(read_data1),
        .read_data2(read_data2)
    );

    // Clock generation
    always begin
        #5 clk = ~clk; // 10ns clock period (100MHz)
    end

    // Testbench initialization and test cases
    initial begin
        // Initialize signals
        clk = 0;
        reset = 1;
        reg_write_enable = 0;
        reg_write_addr = 3'b000;
        reg_write_data = 8'b00000000;

        #10 reset = 0; // Release reset after 10ns

        // Initialize memory with instructions
        instruction_memory[0] = 8'b0001_0010; // Example instruction: ADD R1, R2
        instruction_memory[1] = 8'b0001_0101; // Example instruction: SUB R3, R4

        // Initialize registers
        reg_write_enable = 1;
        reg_write_addr = 3'b001; // Register R1
        reg_write_data = 8'b00001101; // 13
        #10;

        reg_write_addr = 3'b010; // Register R2
        reg_write_data = 8'b00000011; // 3
        #10;

        reg_write_addr = 3'b011; // Register R3
        reg_write_data = 8'b00001010; // 10
        #10;

        reg_write_addr = 3'b100; // Register R4
        reg_write_data = 8'b00000100; // 4
        #10;

        reg_write_enable = 0; // Disable further register writes

        // Apply test cases
        #20; // Wait for some cycles
        $display("Test Case 1: Addition");
        $monitor("Time = %0t, Result = %b, Carry Out = %b", $time, result, carry_out);

        #20; // Wait for more cycles
        $display("Test Case 2: Subtraction");
        $monitor("Time = %0t, Result = %b, Carry Out = %b", $time, result, carry_out);

        // Display register contents
        $monitor("Register Read 1: %b, Register Read 2: %b", read_data1, read_data2);

        // Finish simulation
        #100 $finish;
    end

endmodule

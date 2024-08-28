module tb_cpu;

    // Testbench signals
    reg clk;
    reg reset;
    reg [12:0] instr;
    wire [7:0] result;

    initial begin
        $dumpfile("cpu.vcd");
        $dumpvars();
    end

    // Instantiate the CPU
    cpu uut (
        .clk(clk),
        .reset(reset),
        .instr(instr),
        .result(result)
    );

    // Clock generation
    always #5 clk = ~clk;

    // Test procedure
    initial begin
        // Initialize signals
        clk = 0;
        reset = 0;
        instr = 13'b0;

        // Apply reset
        reset = 1;
        #15;
        reset = 0;
        // Cycle 1: Test Immediate Load Instruction (first operand)
        instr = 13'b1_011_0_00000100; // Immediate mode, load value 1 into register 3
        #10;  // Wait for two clock cycles to simulate two phases (fetch and execute)

        // Cycle 2: Test Immediate Load Instruction (second operand)
        instr = 13'b1_010_0_00000011; // Immediate mode, load value 3 into register 2
        #10;  // Wait for two clock cycles to simulate two phases (fetch and execute)

        // Cycle 3: Perform ALU Operation (ADD)
        instr = 13'b0_011_010_001_010; // Register mode, perform ADD between R2 and R3, store result in R1
        #20;  // Wait for two clock cycles to simulate ALU operation and storing result

        // Print output
        $display("Result: %b", result);


        // End simulation
        $stop;
    end

endmodule

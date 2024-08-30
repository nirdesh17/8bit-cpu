module tb_cpu;

    // Testbench signals
    reg clk;
    reg reset;
    reg [15:0] instr;
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
        instr = 16'b0;

        // Apply reset
        reset = 1;
        #5;
        reset = 0;
        #5;
        
        // Cycle 1: Immediate Load to Register
        instr = 16'b0000_0000_00000100; // Load value 4 into register 0
        #20;
        instr = 16'b0001_0000_00000010; // write to memory at address 2
        #20;
        instr = 16'b0010_0001_00000010; // read from memory at address 2
        #20;
        instr = 16'b0011_0001_00000111; // add 7 with register 1
        #20;
        $display("Result: %b", result);

        // $display("Result: %b", result);

        // End simulation
        $stop;
    end

endmodule

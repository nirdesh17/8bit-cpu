// module cpu_tb;
//     reg clk;
//     reg reset;
//     reg [15:0] instr;
//     wire [7:0] result;

//     // Instantiate the CPU
//     cpu cpu_inst (
//         .clk(clk),
//         .reset(reset),
//         .instr(instr),
//         .result(result)
//     );

//      initial begin
//         // $readmemh("memory.hex", ram_inst.memory, 0, 255);/
//         $dumpfile("cpu.vcd");
//         $dumpvars();
//     end
//     initial begin
//         clk = 0;
//         reset = 1;
//         // instr = 12'b000_010_010_000; // Example instruction: ADD R1, R2, R3
//         instr = 16'b000_1_001_000_00001010; // ADD R1, R1 + 10
//         #10 reset = 0;
        
//         // #10 reset = 0;
//         // #10 instr = 16'b0010000100110100; // Example instruction: SUB R1, R2, R4
//         // #10 instr = 16'b0100000100110101; // Example instruction: AND R1, R2, R5
//         // #10 instr = 16'b0110000100110110; // Example instruction: OR R1, R2, R6
//         // #10 instr = 16'b1000000100110111; // Example instruction: XOR R1, R2, R7
//         // #10 instr = 16'b1010000100111000; // Example instruction: MUL R1, R2, R8
//         // #10 instr = 16'b1100000100111001; // Example instruction: DIV R1, R2, R9
//         #10 $finish;
//     end

//     always #5 clk = ~clk; // Generate clock signal
//     initial begin
//         $monitor("At time %t, Instruction: %b, Result: %d", $time, instr, result);
//     end

// endmodule



module tb_cpu;

    // Testbench signals
    reg clk;
    reg reset;
    reg [12:0] instr;
    wire [7:0] result;

    initial begin
        // $readmemh("memory.hex", ram_inst.memory, 0, 255);/
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
        #10;
        reset = 0;
        #10;

        // Test Immediate Load Instruction
        instr = 13'b1_011_000000001; // Immediate mode, load value 1 into register 3
        #10;
        instr = 13'b1_010_000000011; 
        #10
        instr = 13'b0_011_010_001_000; // Register mode, perform operation defined by opcode between R1 and R2, store result in R3
        #10;
        // Observe result (expected result depends on the ALU operation defined by the opcode)

        // Print output
        $display("Result: %b", result);

        // End simulation
        $stop;
    end

endmodule

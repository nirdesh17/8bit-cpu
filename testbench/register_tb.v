module register_tb;

    // Testbench signals
    reg clk;
    reg write_enable;
    reg [2:0] read_reg1, read_reg2;
    reg [7:0] write_data;
    wire [7:0] read_data1, read_data2;

    // Instantiate the Register File
    initial begin
        // $readmemh("memory.hex", ram_inst.memory, 0, 255);/
        $dumpfile("register.vcd");
        $dumpvars();
    end
    register uut (
        .clk(clk),
        .write_enable(write_enable),
        .read_reg1(read_reg1),
        .read_reg2(read_reg2),
        .write_data(write_data),
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
        write_enable = 0;
        read_reg1 = 3'b000;
        read_reg2 = 3'b001;
        write_data = 8'b00000000;

        // Wait for global reset
        #10;

        // Write data to register 1
        write_data = 8'b10101010; // Example data
        write_enable = 1;
        read_reg1 = 3'b001; // Register to write
        #10;

        // Disable write
        write_enable = 0;

        // Check read from register 1
        read_reg1 = 3'b001; // Register to read
        read_reg2 = 3'b000; // Read another register to check data
        #10;

        // Display results
        $display("Read Data from Register 1: %b", read_data1);
        $display("Read Data from Register 2: %b", read_data2);

        // Change the write address and write new data
        write_data = 8'b11110000; // New data
        write_enable = 1;
        read_reg1 = 3'b010; // New register to write
        #10;

        // Disable write
        write_enable = 0;

        // Check read from new register
        read_reg1 = 3'b010; // Register to read
        read_reg2 = 3'b001; // Check data of the previous register
        #10;

        // Display results
        $display("Read Data from Register 1 (After Update): %b", read_data1);
        $display("Read Data from Register 2 (After Update): %b", read_data2);

        // Finish simulation
        #20 $finish;
    end

endmodule

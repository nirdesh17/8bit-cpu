module register_tb;
    reg clk;
    reg write_enable;
    reg [2:0] read_reg1, read_reg2, write_reg; // 3-bit address for register
    reg [7:0] write_data; // 8-bit data input
    wire [7:0] read_data1, read_data2; // 8-bit data output

    // instantiate the register module
    register register_inst (
        .clk(clk),
        .write_enable(write_enable),
        .read_reg1(read_reg1),
        .read_reg2(read_reg2),
        .write_reg(write_reg),
        .write_data(write_data),
        .read_data1(read_data1),
        .read_data2(read_data2)
    );

    // generate a clock signal
    always #5 clk = ~clk; // Generate a clock signal with a period of 10 time units

    // initialize the inputs
    initial begin
        clk = 0;
        write_enable = 0;
        read_reg1 = 0;
        read_reg2 = 0;
        write_reg = 0;
        write_data = 0;

        // Test case 1
        #10 write_enable = 1; write_reg = 3'b000; write_data = 8'b0000_1101;
        #10 write_enable = 0; read_reg1 = 3'b000; 

        // Test case 2
        #10 write_enable = 1; write_reg = 3'b001; write_data = 8'b0000_0011;
        #10 write_enable = 0; read_reg2 = 3'b001;

        // Test case 3
        #10 write_enable = 1; write_reg = 3'b010; write_data = 8'b0000_1101;
        #10 write_enable = 0; read_reg1 = 3'b010; read_reg2 = 3'b010;

        // Test Case 4: Ensure read data is independent of write data when write_enable is low
        #10 write_enable = 0; write_data = 8'b0000_0000; read_reg1 = 3'b001; read_reg2 = 3'b010;

        #10 $stop; // Stop the simulation
    end

    // monitor the inputs and outputs
    initial begin
        $monitor("clk=%b write_enable=%b read_reg1=%b read_reg2=%b write_reg=%b write_data=%b read_data1=%b read_data2=%b", 
                  clk, write_enable, read_reg1, read_reg2, write_reg, write_data, read_data1, read_data2);
    end
endmodule

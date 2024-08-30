module register (
    input clk,
    input write_enable,
    input [3:0] read_reg1,
    // input [2:0] read_reg2,
    input [7:0] write_data,
    output reg [7:0] read_data1
    // output reg [7:0] read_data2
);
    // Register file: 8 registers of 8 bits each
    reg [7:0] reg_file [7:0];
    initial begin
        reg_file[0] = 8'h00; // Example initial values
        reg_file[1] = 8'h00;
        reg_file[2] = 8'h00;
        reg_file[3] = 8'h00;
        reg_file[4] = 8'h00;
        reg_file[5] = 8'h00;
        reg_file[6] = 8'h00;
        reg_file[7] = 8'h00;
    end

    always @(posedge clk) begin
        // Write operation
        // if (write_enable) begin
            reg_file[read_reg1] <= write_data;
        // end
    end

    always @(*) begin
        // Read operations (combinational logic)
        read_data1 = reg_file[read_reg1];
        // read_data2 = reg_file[read_reg2];
    end
endmodule

module register (
    input clk,
    input write_enable,
    input [2:0] read_reg1,
    input [2:0] read_reg2,
    input [2:0] write_reg,
    input [7:0] write_data,
    output reg [7:0] read_data1,
    output reg [7:0] read_data2
);
    // Register file
    reg [7:0] reg_file [7:0];

    always @(posedge clk) begin
        if (write_enable)
            reg_file[write_reg] <= write_data;
        read_data1 <= reg_file[read_reg1];
        read_data2 <= reg_file[read_reg2];
    end
endmodule

module register (
    input wire clk,
    input wire write_enable,
    input wire [2:0] read_reg1,read_reg2,write_reg, //3bit address for register
    input wire [7:0] write_data, // 8bit data input
    output wire [7:0] read_data1,read_data2// 8bit data output
);
    // 8 registers of 8 bits each
    reg [7:0] registers [7:0];

    // read data from the registers
    assign read_data1 = registers[read_reg1];
    assign read_data2 = registers[read_reg2];

    // write data to the registers
    always @(posedge clk) begin
        if (write_enable) begin
            registers[write_reg] <= write_data;
        end
    end
    
endmodule
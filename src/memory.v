module memory (
    input wire clk,
    input wire we,            // Write enable
    input wire [7:0] addr,    // Address for read/write
    input wire [7:0] data_in, // Data to write
    output reg [7:0] data_out // Data to read
);
    // Define the memory as an array of 256 8-bit registers
    reg [7:0] mem [255:0];

    always @(posedge clk) begin
        data_out <= mem[addr];
    end

endmodule

module memory (
    input wire clk,
    input wire write_enable,  // Write enable
    input wire [7:0] addr,    // Address for read/write
    input wire [7:0] data_in, // Data to write
    output reg [7:0] data_out // Data to read
);
    // Define the memory as an array of 256 8-bit registers
    reg [7:0] mem [255:0];
        integer i;
        initial begin
            for (i = 0; i < 256; i = i + 1) begin
                mem[i] = 8'b00000000; // Initialize with zero
            end
        end

    initial begin
        data_out = 8'b00000000; // Default value
    end 

    always @(*) begin
         // Default value
        if (write_enable) begin
            // Write operation
            mem[addr] <= data_in;
        end else begin
            // Read operation
            data_out <= mem[addr];
        end
    end

endmodule

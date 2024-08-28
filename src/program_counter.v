module program_counter (
    input wire clk,              // Clock signal
    input wire reset,            // Reset signal
    input enable,
    output reg [7:0] pc          // Current program counter value
);

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            pc <= 8'b00000000;    // Reset the PC to 0
        end else if (enable) begin
            pc <= pc + 1;         // Increment the PC
        end
    end
endmodule

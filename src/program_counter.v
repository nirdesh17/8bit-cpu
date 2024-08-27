module program_counter (
    input wire clk,              // Clock signal
    input wire reset,            // Reset signal
    input wire [7:0] new_addr,   // New address to load (e.g., for branch instructions)
    input wire load,             // Load new address signal
    input wire increment,        // Increment address signal
    output reg [7:0] pc          // Current program counter value
);

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            pc <= 8'b0000_0000; // Reset the PC to 0
        end
        else if (load) begin
            pc <= new_addr;     // Load new address into PC
        end
        else if (increment) begin
            pc <= pc + 1;       // Increment the PC
        end
    end

endmodule

module program_counter (
    input wire clk,              // Clock signal
    input wire reset,            // Reset signal
    input enable,
    output reg [7:0] pc          // Current program counter value
);

    initial begin
        pc = 8'b00000000; // Initial value of the program counter
    end
   
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            pc <= pc+1; // Reset the PC to 0
        end
    end
    always @(posedge reset) begin
        pc<=0;
    end

endmodule

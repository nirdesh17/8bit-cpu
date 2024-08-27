module alu (
    input [7:0] operand1,
    input [7:0] operand2,
    input [2:0] operation,
    input enable,
    output reg [7:0] result
);
    initial begin
        result = 8'b00000000;
    end
    
    always @(*) begin
        if (enable) begin
            case (operation)
                // Arithmetic 
                3'b000: result <= operand1 + operand2;
                3'b001: result <= operand1 - operand2;
                3'b010: result <= operand1 * operand2;
                3'b011: result <= operand1 / operand2;

                // Logical
                3'b100: result <= operand1 & operand2;
                3'b101: result <= operand1 | operand2;
                3'b110: result <= operand1 ^ operand2;

                default: result <= 8'b00000000; // Ensure default is 0
            endcase
        end
    end  
endmodule

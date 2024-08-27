module alu (
    input [7:0] operand1,
    input [7:0] operand2,
    input [2:0] operation,
    output [7:0] result,
    output carry_out
);
    reg [7:0] ALU_Result;
    wire [8:0] extended_result;
    assign result=ALU_Result;
    assign extended_result={1'b0,operand1}+{1'b0,operand2};
    assign carry_out=extended_result[8];

    always @(*) begin
        case (operation)
            // Arithmetic 
            3'b000: ALU_Result=operand1+operand2;
            3'b001: ALU_Result=operand1-operand2;
            3'b010: ALU_Result=operand1*operand2;
            3'b011: ALU_Result=operand1/operand2;

            // Logical
            3'b100: ALU_Result=operand1&operand2;
            3'b101: ALU_Result=operand1|operand2;
            3'b110: ALU_Result=operand1^operand2;

            default: ALU_Result = 8'b00000000;
        endcase
    end  
endmodule

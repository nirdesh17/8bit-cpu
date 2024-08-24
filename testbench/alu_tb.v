module alu_tb;
    reg [7:0] operand1;
    reg [7:0] operand2;
    reg [3:0] operation;
    wire [7:0] result;
    wire carry_out;

    // instantiate the alu module
    alu alu_inst (
        .operand1(operand1),
        .operand2(operand2),
        .operation(operation),
        .result(result),
        .carry_out(carry_out)
    );
    
    // initialize the inputs
    initial begin
        operand1 = 8'b0000_1101;
        operand2 = 8'b0000_0011;
        operation = 3'b000;
        #10 operation = 3'b001;
        #10 operation = 3'b010;
        #10 operation = 3'b011;
        #10 operation = 3'b100;
        #10 operation = 3'b101;
        #10 operation = 3'b110;
       
        #10 $finish;
    end

    initial begin
        $monitor("operand1=%b operand2=%b operation=%b result=%b carry_out=%b", operand1, operand2, operation, result, carry_out);
    end   
    
endmodule
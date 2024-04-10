module Control(
    //output
    output reg RegWrite,
    output reg[1:0]ALUOp,
    output reg MemWrite,
    output reg MemRead,
    //input
    input [5:0]OpCode
);

always@(OpCode)begin
    case(OpCode)
        6'b000000: begin
            RegWrite <= 1;
            ALUOp <= 2'b10;
        end
        default:begin
            RegWrite <= 0;
            ALUOp <= 2'b11;
        end
    endcase
end
endmodule
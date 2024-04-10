`define R_format            6'b000000
`define Add_imm_unsigned    6'b001100
`define Sub_imm_unsigned    6'b001101
`define Store_word          6'b010000
`define Load_word           6'b010001
`define Branch_on_equal     6'b010011
`define Jump                6'b011100
module Control(
    //output
    output reg RegWrite,
    output reg[1:0]ALUOp,
    output reg RegDst,
    output reg ALUSrc,
    output reg MemWrite,
    output reg MemRead,
    output reg MemtoReg,
    output reg Branch,
    output reg Jump,
    //input
    input [5:0]OpCode
);

always@(OpCode)begin
    case(OpCode)
        `R_format: begin
            RegWrite <= 1;
            MemWrite <= 0;
            MemRead <= 0;
            ALUSrc <= 0;
            RegDst <= 1;
            MemtoReg <= 0;
            Jump <= 0;
            Branch <= 0;
            ALUOp <= 2'b10;
        end
        `Add_imm_unsigned: begin
            RegWrite <= 1;
            MemWrite <= 0;
            MemRead <= 0;
            RegDst <= 0;
            ALUSrc <= 1;
            MemtoReg <= 0;
            Jump <= 0;
            Branch <= 0;
            ALUOp <= 2'b00;
        end
        `Sub_imm_unsigned: begin
            RegWrite <= 1;
            MemWrite <= 0;
            MemRead <= 0;
            RegDst <= 0;
            ALUSrc <= 1;
            MemtoReg <= 0;
            ALUOp <= 2'b01;
        end
        `Store_word: begin
            RegWrite <= 0;
            MemWrite <= 1;
            MemRead <= 0;
            ALUSrc <= 1;
            Jump <= 0;
            Branch <= 0;
            ALUOp <= 2'b00;
        end
        `Load_word: begin
            RegWrite <= 1;
            MemWrite <= 0;
            MemRead <= 1;
            RegDst <= 0;
            ALUSrc <= 1;
            Jump <= 0;
            Branch <= 0;
            MemtoReg <= 1;
            ALUOp <= 2'b00;
        end
        `Jump:begin
            Jump <= 1;
            Branch <= 0;
            RegWrite <= 0;
            MemWrite <= 0;
            MemRead <= 0;
            ALUOp <= 2'b01;
        end
        `Branch_on_equal:begin
            ALUSrc <= 0;
            Branch <= 1;
            Jump <= 0;
            RegWrite <= 0;
            MemWrite <= 0;
            MemRead <= 0;
            ALUOp <= 2'b01;
        end
        default:begin
            RegWrite <= 0;
            Jump <= 0;
            Branch <= 0;
            RegWrite <= 0;
            MemWrite <= 0;
            MemRead <= 0;
            ALUOp <= 2'b11;
        end
    endcase
end
endmodule
`define Addu	6'b001001
`define Subu	6'b001010
`define Nor		6'b010011
`define Sltu	6'b101010

module ALU_Control(
    output reg[5:0] funct,

    input [1:0] ALUOp,
    input [5:0] funct_ctrl
);
always@(ALUOp, funct_ctrl)begin
    case(ALUOp)
        2'b10:begin
            case(funct_ctrl)
                6'b001011: funct <= `Addu;
                6'b001101: funct <= `Subu;
                6'b100111: funct <= `Nor;
                6'b101010: funct <= `Sltu;
                default: funct <= 6'b0;
            endcase
        end
        2'b00:begin
            funct <= `Addu;
        end
        2'b01:begin
            funct <= `Subu;
        end
    endcase
end
endmodule
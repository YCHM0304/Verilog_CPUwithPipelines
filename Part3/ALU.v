`define Addu	6'b001001
`define Subu	6'b001010
`define Nor		6'b010011
`define Or
`define Sltu	6'b101010

module ALU(
	input [31:0] Src1,
	input [31:0] Src2,
	input [4:0] shamt,
	input [5:0] funct,

	output reg [31:0] Result,
	output zero
);
assign zero = (Result)? 0: 1;
	always @(Src1, Src2, shamt, funct)begin
		case(funct)
			`Addu:	Result <= Src1 + Src2;
			`Subu:	Result <= Src1 - Src2;
			`Nor:	Result <= ~(Src1 | Src2);
			`Sltu:begin
				if(Src1 < Src2) Result <= 1;
				else Result <= 0;
			end
			default: Result = Result;
		endcase
	end
endmodule
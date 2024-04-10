module Adder(
    output [31:0]Output_Addr,
    input [31:0]Src1,
    input [31:0]Src2
);
assign Output_Addr = Src1 + Src2;
endmodule
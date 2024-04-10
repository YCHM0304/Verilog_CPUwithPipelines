module Shift(
    //output
    output [31:0]out,
    //input
    input [31:0]in
);
assign out = in << 2;
endmodule
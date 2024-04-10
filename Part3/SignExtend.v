module SignExtend(
    //output
    output [31:0]out,
    //input
    input [15:0]in
);
assign out = (in[15])? {16'hFFFF, in}: {16'h0000, in};
endmodule
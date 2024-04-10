module Bits8_Mux(
    //output
    output [7:0]Mux_out,
    //input
    input [7:0]Mux_in_0,
    input [7:0]Mux_in_1,
    input sel
);

assign Mux_out = (sel)? Mux_in_1: Mux_in_0;
endmodule
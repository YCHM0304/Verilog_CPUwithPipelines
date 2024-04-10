module Bits5_Mux(
    //output
    output [4:0]Mux_out,
    //input
    input [4:0]Mux_in_0,
    input [4:0]Mux_in_1,
    input sel
);

assign Mux_out = (sel)? Mux_in_1: Mux_in_0;
endmodule
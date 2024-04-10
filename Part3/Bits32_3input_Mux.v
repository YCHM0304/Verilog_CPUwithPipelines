module Bits32_3input_Mux(
    //output
    output [31:0]Mux_out,
    //input
    input [31:0]Mux_in_0,
    input [31:0]Mux_in_1,
    input [31:0]Mux_in_2,
    input [1:0]sel
);

assign Mux_out = (sel == 2'b00)? Mux_in_0: (sel == 2'b01)? Mux_in_1: (sel == 2'b10)? Mux_in_2: Mux_out;
endmodule

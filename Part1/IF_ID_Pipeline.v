module IF_ID_Pipeline(
    output reg[31:0] out,
    input [31:0] Instr,
    input clk
);
always@(posedge clk)begin
    out <= Instr;
end
endmodule
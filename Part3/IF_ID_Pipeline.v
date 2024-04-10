module IF_ID_Pipeline(
    //output
    output reg[31:0] out,
    //input
    input [31:0] Instr,
    input IF_ID_Write,
    input clk
);
always@(posedge clk)begin
    if(IF_ID_Write)begin
        out <= Instr;
    end
end
endmodule
module MEM_WB_Pipeline(
    //output
    output reg[31:0] MEM_WB_ALU_Result,
    output reg[4:0] IF_ID_RdAddr_out,
    output reg WB_out,
    //input
    input [31:0] EX_MEM_ALU_Result,
    input [4:0] EX_MEM_RdAddr,
    input WB,
    input clk
);
always@(posedge clk)begin
    MEM_WB_ALU_Result <= EX_MEM_ALU_Result;
    IF_ID_RdAddr_out <= EX_MEM_RdAddr;
    WB_out <= WB;
end
endmodule
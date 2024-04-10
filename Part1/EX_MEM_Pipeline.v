module EX_MEM_Pipeline(
    //output
    output reg[31:0] EX_MEM_ALU_Result,
    output reg[4:0] EX_MEM_RdAddr,
    output reg [1:0] EX_MEM_M,
    output reg EX_MEM_WB,
    //input
    input [31:0] ALU_Result,
    input [4:0] ID_EX_RdAddr,
    input [1:0] M,
    input WB,
    input clk
);
always@(posedge clk)begin
    EX_MEM_ALU_Result <= ALU_Result;
    EX_MEM_RdAddr <= ID_EX_RdAddr;
    EX_MEM_WB <= WB;
    EX_MEM_M <= M;
end
endmodule
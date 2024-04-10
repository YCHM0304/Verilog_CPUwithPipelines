module EX_MEM_Pipeline(
    //output
    output reg[31:0] EX_MEM_ALU_Result,
    output reg[31:0] EX_MEM_RtData,
    output reg[4:0] EX_MEM_Addr,
    output reg [1:0] EX_MEM_M,
    output reg [1:0]EX_MEM_WB,
    //input
    input [31:0] ALU_Result,
    input [31:0] Rt_Data,
    input [4:0] IF_ID_Addr,
    input [1:0] M,
    input [1:0]WB,
    input clk
);
always@(posedge clk)begin
    EX_MEM_ALU_Result <= ALU_Result;
    EX_MEM_Addr <= IF_ID_Addr;
    EX_MEM_RtData <= Rt_Data;
    EX_MEM_WB <= WB;
    EX_MEM_M <= M;
end
endmodule
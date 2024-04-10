module ID_EX_Pipeline(
    //output
    output reg[31:0] ID_EX_RsData,
    output reg[31:0] ID_EX_RtData,
    output reg[4:0] ID_EX_RdAddr,
    output reg[15:0] ID_EX_imm,
    output reg [1:0] ID_EX_M,
    output reg [1:0] ID_EX_EX,
    output reg ID_EX_WB,
    //input
    input [31:0] RsData,
    input [31:0] RtData,
    input [4:0] IF_ID_RdAddr,
    input [15:0] imm,
    input [1:0] M,
    input [1:0] EX,
    input WB,
    input clk
);


always@(posedge clk)begin
    ID_EX_RsData <= RsData;
    ID_EX_RtData <= RtData;
    ID_EX_RdAddr <= IF_ID_RdAddr;
    ID_EX_imm <= imm;
    ID_EX_WB <= WB;
    ID_EX_M <= M;
    ID_EX_EX <= EX;
end
endmodule
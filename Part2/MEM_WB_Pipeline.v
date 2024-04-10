module MEM_WB_Pipeline(
    //output
    output reg[31:0] MEM_WB_ALU_Result,
    output reg[31:0] MemReadData_out,
    output reg[4:0] IF_ID_Addr_out,
    output reg [1:0]WB_out,
    //input
    input [31:0] ALU_Result,
    input [31:0] MemReadData,
    input [4:0] EX_MEM_Addr,
    input [1:0]WB,
    input clk
);
always@(posedge clk)begin
    MEM_WB_ALU_Result <= ALU_Result;
    MemReadData_out <= MemReadData;
    IF_ID_Addr_out <= EX_MEM_Addr;
    WB_out <= WB;
end
endmodule
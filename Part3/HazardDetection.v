module HazardDetection(
    //output
    output reg IF_ID_Write = 1'b1,
    output reg Stall_Sel = 1'b1,
    output reg PCWrite = 1'b1,
    //input
    input [4:0] ID_EX_RtAddr,
    input [4:0] IF_ID_RsAddr,
    input [4:0] IF_ID_RtAddr,
    input ID_EX_MemRead
);
    always@(*)begin
        if (ID_EX_MemRead && ((ID_EX_RtAddr == IF_ID_RsAddr) || (ID_EX_RtAddr == IF_ID_RtAddr)))begin
            {IF_ID_Write, Stall_Sel, PCWrite} = 3'd0;
        end
        else {IF_ID_Write, Stall_Sel, PCWrite} = 3'b111;
    end
endmodule
module Forwarding(
    //output
    output reg[1:0] ForwardA = 2'b00,
    output reg[1:0] ForwardB = 2'b00,
    //input
    input [4:0] ID_EX_RtAddr,
    input [4:0] ID_EX_RsAddr,
    input [4:0] EX_MEM_RdAddr,
    input [4:0] MEM_WB_RdAddr,
    input EX_MEM_RegWrite,
    input MEM_WB_RegWrite
);
    always@(*)begin
        if (EX_MEM_RegWrite
            && EX_MEM_RdAddr != 0
            && EX_MEM_RdAddr == ID_EX_RsAddr)
        begin
            ForwardA <= 2'b10;
        end
        else if (MEM_WB_RegWrite
            && MEM_WB_RdAddr != 0
            // && EX_MEM_RdAddr != ID_EX_RsAddr
            && MEM_WB_RdAddr == ID_EX_RsAddr)
        begin
            ForwardA <= 2'b01;
        end
        else ForwardA = 2'b00;
        if (EX_MEM_RegWrite
            && EX_MEM_RdAddr != 0
            && EX_MEM_RdAddr == ID_EX_RtAddr)
        begin
            ForwardB <= 2'b10;
        end
        else if (MEM_WB_RegWrite
            && MEM_WB_RdAddr != 0
            // && EX_MEM_RdAddr != ID_EX_RtAddr
            && MEM_WB_RdAddr == ID_EX_RtAddr)
        begin
            ForwardB <= 2'b01;
        end
        else ForwardB = 2'b00;
    end
endmodule
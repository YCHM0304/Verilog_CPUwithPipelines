/*
 *	Template for Project 3 Part 2
 *	Copyright (C) 2021  Lee Kai Xuan or any person belong ESSLab.
 *	All Right Reserved.
 *
 *	This program is free software: you can redistribute it and/or modify
 *	it under the terms of the GNU General Public License as published by
 *	the Free Software Foundation, either version 3 of the License, or
 *	(at your option) any later version.
 *
 *	This program is distributed in the hope that it will be useful,
 *	but WITHOUT ANY WARRANTY; without even the implied warranty of
 *	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *	GNU General Public License for more details.
 *
 *	You should have received a copy of the GNU General Public License
 *	along with this program.  If not, see <https://www.gnu.org/licenses/>.
 *
 *	This file is for people who have taken the cource (1092 Computer
 *	Organizarion) to use.
 *	We (ESSLab) are not responsible for any illegal use.
 *
 */

/*
 * Declaration of top entry for this project.
 * CAUTION: DONT MODIFY THE NAME AND I/O DECLARATION.
 */
module I_PipelineCPU(
	// Outputs
	output	wire	[31:0]	Output_Addr,
	// Inputs
	input	wire	[31:0]	Input_Addr,
	input	wire		clk
);
wire [31:0] Instruction;
wire [31:0] Rs_Data;
wire [31:0] Rt_Data;
wire [31:0] Rd_Data;
wire [5:0] funct;
wire [31:0] ALU_Result;
wire [31:0] SignExtend_out;
wire [31:0] Bits32_Mux_out;
wire [4:0] IF_ID_Addr;
//	Control
wire [1:0] WB;
wire [1:0] M;
wire [3:0] EX;
//	DM
wire [31:0] MemReadData;
// 	IF/ID
wire [31:0] Instruction_out;
//	ID/EX
wire [1:0]ID_EX_WB;
wire RegDst;
wire ALUSrc;
wire [1:0] ALUOp;
wire [1:0] ID_EX_M;
wire [31:0] ID_EX_RsData;
wire [31:0] ID_EX_RtData;
wire [31:0] ID_EX_SignExtend;
wire [4:0] ID_EX_RdAddr;
wire [4:0] ID_EX_RtAddr;
//	EX/MEM
wire [1:0]EX_MEM_WB;
wire [31:0] EX_MEM_ALU_Result;
wire [31:0] EX_MEM_RtData;
wire [4:0] EX_MEM_Addr;
wire MemRead;
wire MemWrite;
//	MEM/WB
wire RegWrite;
wire MemtoReg;
wire [31:0] MEM_WB_ALU_Result;
wire [31:0] MemReadData_out;
wire [4:0] Rd_Addr;
	/*
	 * Declaration of Instruction Memory.
	 * CAUTION: DONT MODIFY THE NAME.
	 */
	IM Instr_Memory(
		// Outputs
		.Instruction(Instruction),
		// Inputs
		.Instr_Addr(Input_Addr)
	);

	/*
	 * Declaration of Register File.
	 * CAUTION: DONT MODIFY THE NAME.
	 */
	RF Register_File(
	// Outputs
	.Rs_Data(Rs_Data),
	.Rt_Data(Rt_Data),
	// Inputs
	.Rd_Data(Rd_Data),
	.Rs_Addr(Instruction_out[25:21]),
	.Rt_Addr(Instruction_out[20:16]),
	.Rd_Addr(Rd_Addr),
	.RegWrite(RegWrite),
	.clk(clk)
	);

	/*
	 * Declaration of Data Memory.
	 * CAUTION: DONT MODIFY THE NAME.
	 */
	DM Data_Memory(
	// Outputs
	.MemReadData(MemReadData),
	// Inputs
	.MemAddr(EX_MEM_ALU_Result),
	.MemWriteData(EX_MEM_RtData),
	.MemWrite(MemWrite),
	.MemRead(MemRead),
	.clk(clk)
	);

	Control Controller(
		//output
    	.RegWrite(WB[1]),
    	.ALUOp(EX[2:1]),
    	.RegDst(EX[0]),
    	.ALUSrc(EX[3]),
    	.MemWrite(M[0]),
    	.MemRead(M[1]),
    	.MemtoReg(WB[0]),
    	//input
    	.OpCode(Instruction_out[31:26])
	);

	ALU_Control ALU_Controller(
		//Outputs
		.funct(funct),
		//Inputs
		.funct_ctrl(ID_EX_SignExtend[5:0]),
		.ALUOp(ALUOp)
	);

	ALU Arithmetic(
		// Outputs
		.Result(ALU_Result),
		// Inputs
		.Src1(ID_EX_RsData),
		.Src2(Bits32_Mux_out),
		.shamt(ID_EX_SignExtend[10:6]),
		.funct(funct)
	);

	Adder Addr_Adder(
		//Outputs
		.Output_Addr(Output_Addr),
		//Inputs
		.Src1(Input_Addr),
		.Src2(32'd4)
	);

	SignExtend SignExtension(
		//Outputs
		.out(SignExtend_out),
		//Inputs
		.in(Instruction_out[15:0])
	);

	Bits5_Mux Bits5_Mux(
		//output
    	.Mux_out(IF_ID_Addr),
    	//input
    	.Mux_in_0(ID_EX_RtAddr),
    	.Mux_in_1(ID_EX_RdAddr),
    	.sel(RegDst)
	);

	Bits32_Mux Bits32_Mux_ALU(
		//output
    	.Mux_out(Bits32_Mux_out),
    	//input
    	.Mux_in_0(ID_EX_RtData),
    	.Mux_in_1(ID_EX_SignExtend),
    	.sel(ALUSrc)
	);

	Bits32_Mux Bits32_Mux_Mem(
		//output
    	.Mux_out(Rd_Data),
    	//input
    	.Mux_in_0(MEM_WB_ALU_Result),
    	.Mux_in_1(MemReadData_out),
    	.sel(MemtoReg)
	);

	IF_ID_Pipeline IF_ID_Pipeline(
		//output
    	.out(Instruction_out),
		//input
    	.Instr(Instruction),
    	.clk(clk)
	);

	ID_EX_Pipeline ID_EX_Pipeline(
		//output
		.ID_EX_RsData(ID_EX_RsData),
		.ID_EX_RtData(ID_EX_RtData),
		.ID_EX_RdAddr(ID_EX_RdAddr),
		.ID_EX_RtAddr(ID_EX_RtAddr),
		.ID_EX_SignExtend(ID_EX_SignExtend),
		.ID_EX_WB(ID_EX_WB),
		.ID_EX_M(ID_EX_M),
		.ID_EX_EX({ALUSrc, ALUOp, RegDst}),
		//input
		.RsData(Rs_Data),
		.RtData(Rt_Data),
		.IF_ID_RdAddr(Instruction_out[15:11]),
		.IF_ID_RtAddr(Instruction_out[20:16]),
		.SignExtend(SignExtend_out),
		.WB(WB),
		.M(M),
		.EX(EX),
		.clk(clk)
	);

	EX_MEM_Pipeline EX_MEM_Pipeline(
		//output
		.EX_MEM_ALU_Result(EX_MEM_ALU_Result),
		.EX_MEM_Addr(EX_MEM_Addr),
		.EX_MEM_M({MemRead, MemWrite}),
		.EX_MEM_RtData(EX_MEM_RtData),
		.EX_MEM_WB(EX_MEM_WB),
		//input
		.ALU_Result(ALU_Result),
		.IF_ID_Addr(IF_ID_Addr),
		.Rt_Data(ID_EX_RtData),
		.M(ID_EX_M),
		.WB(ID_EX_WB),
		.clk(clk)
	);

	MEM_WB_Pipeline MEM_WB_Pipeline(
		//output
		.MEM_WB_ALU_Result(MEM_WB_ALU_Result),
		.IF_ID_Addr_out(Rd_Addr),
		.MemReadData_out(MemReadData_out),
		.WB_out({RegWrite, MemtoReg}),
		//input
		.ALU_Result(EX_MEM_ALU_Result),
		.MemReadData(MemReadData),
		.EX_MEM_Addr(EX_MEM_Addr),
		.WB(EX_MEM_WB),
		.clk(clk)
	);
endmodule
/*
 *	Template for Project 3 Part 1
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
module R_PipelineCPU(
	// Outputs
	output	wire	[31:0]	Output_Addr,
	// Inputs
	input	wire	[31:0]	Input_Addr,
	input	wire		clk
);
wire [31:0] Instruction;
wire [31:0] Rs_Data;
wire [31:0] Rt_Data;
wire [5:0] funct;
wire [31:0] ALU_Result;
//	Control
wire WB;
wire [1:0] M;
wire [1:0] EX;
// 	IF/ID
wire [31:0] Instruction_out;
wire [4:0] IF_ID_RdAddr;
//	ID/EX
wire ID_EX_WB;
wire [1:0] ALUOp;
wire [1:0] ID_EX_M;
wire [31:0] ID_EX_RsData;
wire [31:0] ID_EX_RtData;
wire [15:0] ID_EX_imm;
wire [4:0] ID_EX_RdAddr;
//	EX/MEM
wire EX_MEM_WB;
wire [31:0] EX_MEM_ALU_Result;
wire [4:0] EX_MEM_RdAddr;
//	MEM/WB
wire RegWrite;
wire [31:0] Rd_Data;
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

	ALU Arithmetic(
		// Outputs
		.Result(ALU_Result),
		// Inputs
		.Src1(ID_EX_RsData),
		.Src2(ID_EX_RtData),
		.shamt(ID_EX_imm[10:6]),
		.funct(funct)
	);

	Control Controller(
		// Outputs
		.ALUOp(EX),
		.RegWrite(WB),
		.MemRead(M[1]),
		.MemWrite(M[0]),
		// Inputs
		.OpCode(Instruction_out[31:26])
	);

	ALU_Control ALU_Controller(
		//Outputs
		.funct(funct),
		//Inputs
		.funct_ctrl(ID_EX_imm[5:0]),
		.ALUOp(ALUOp)
	);

	Adder Addr_Adder(
		//Outputs
		.Output_Addr(Output_Addr),
		//Inputs
		.Src1(Input_Addr),
		.Src2(32'd4)
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
		.ID_EX_imm(ID_EX_imm),
		.ID_EX_WB(ID_EX_WB),
		.ID_EX_M(ID_EX_M),
		.ID_EX_EX(ALUOp),
		//input
		.RsData(Rs_Data),
		.RtData(Rt_Data),
		.IF_ID_RdAddr(Instruction_out[15:11]),
		.imm(Instruction_out[15:0]),
		.WB(WB),
		.M(M),
		.EX(EX),
		.clk(clk)
	);

	EX_MEM_Pipeline EX_MEM_Pipeline(
		//output
		.EX_MEM_ALU_Result(EX_MEM_ALU_Result),
		.EX_MEM_RdAddr(EX_MEM_RdAddr),
		.EX_MEM_M(),
		.EX_MEM_WB(EX_MEM_WB),
		//input
		.ALU_Result(ALU_Result),
		.ID_EX_RdAddr(ID_EX_RdAddr),
		.M(ID_EX_M),
		.WB(ID_EX_WB),
		.clk(clk)
	);

	MEM_WB_Pipeline MEM_WB_Pipeline(
		//output
		.MEM_WB_ALU_Result(Rd_Data),
		.IF_ID_RdAddr_out(Rd_Addr),
		.WB_out(RegWrite),
		//input
		.EX_MEM_ALU_Result(EX_MEM_ALU_Result),
		.EX_MEM_RdAddr(EX_MEM_RdAddr),
		.WB(EX_MEM_WB),
		.clk(clk)
	);
endmodule

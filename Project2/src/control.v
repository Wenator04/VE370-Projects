`ifndef MODULE_CONTROL
`define MODULE_CONTROL
`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/07/08 21:54:33
// Design Name: 
// Module Name: control
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module control(opCode, regDst, jump, beq, bne, memRead, memReg, ALUOp, memWrite, ALUSrc, regWrite);
	input[5:0] opCode;
	output regDst;
	output jump;
	output beq;
	output bne;
	output memRead; 
	output memReg;
	output memWrite; 
	output ALUSrc;
	output regWrite;
	output[1:0] ALUOp;

	assign regDst = (opCode == 6'b000000) ? 1:0;
	assign jump = (opCode == 6'b000010) ? 1:0;
	assign beq = (opCode == 6'b000100) ? 1:0;
	assign bne = (opCode == 6'b000101) ? 1:0;
	assign memRead = (opCode == 6'b100011) ? 1:0;
	assign memReg = (opCode == 6'b100011) ? 1:0;
	assign memWrite = (opCode == 6'b101011) ? 1:0;
	assign ALUSrc = (opCode == 6'b100011 || opCode == 6'b101011 || opCode == 6'b000010 || opCode == 6'b001000 || opCode == 6'b001100) ? 1:0;
	assign regWrite = (opCode == 6'b000000 || opCode == 6'b100011 || opCode == 6'b001000 || opCode == 6'b001100) ? 1:0;
	assign ALUOp[1] = (opCode == 6'b000000 || opCode == 6'b001100) ? 1:0;
	assign ALUOp[0] = (opCode == 6'b000100 || opCode == 6'b000101 || opCode == 6'b000010 || opCode == 6'b001100) ? 1:0;
	
	
endmodule
`endif
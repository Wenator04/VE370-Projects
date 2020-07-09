`ifndef MODULE_SINGLECYCLE
`define MODULE_SINGLECYCLE
`timescale 1ns / 1ps

`include "ALU.v"
`include "ALUControl.v"
`include "control.v"
`include "instructionMemory.v"
`include "mux5.v"
`include "mux32.v"
`include "registerFile.v"
`include "dataMemory.v"
`include "signExtend.v"
`include "PC.v"

//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/07/09 13:28:01
// Design Name: 
// Module Name: singleCycle
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

module singleCycle (clk);
    input clk;

    wire[31:0] PCInput;
    wire[31:0] PCOutput;
    wire[31:0] PCPlus4;
    wire[31:0] instruction;
    wire[31:0] jumpAddress;
    wire[31:0] branchAddress;
    wire[31:0] addedAddress;

    wire branch;
    wire PCHold;
    wire regDst;
    wire jump;
    wire beq;
    wire bne;
    wire memRead;
    wire memReg;
    wire memWrite;
    wire ALUSrc;
    wire regWrite;

    wire[1:0] ALUOp;

    wire[4:0] writeReg;

    wire[31:0] writeData;
    wire[31:0] regReadData1;
    wire[31:0] regReadData2;

    wire[31:0] extended;
    wire[31:0] ALUsecond;
    wire[31:0] ALUResult;

    wire[3:0] ALUControlSignal;
    wire ALUZero;

    wire[31:0] memReadData;

    assign PCHold = 1'b0;
    assign PCPlus4 = PCOutput + 4;
    assign addedAddress = PCPlus4 + (extended << 2);
    assign jumpAddress = {PCPlus4[31:28], instruction[25:0], 2'b0};
    assign branch = (beq & ALUZero) | (bne & ~ALUZero);
    assign branchAddress = (branch == 1'b0) ? PCPlus4 : addedAddress;
    assign PCInput = (jump == 1'b0) ? branchAddress : jumpAddress;

    PC pc(PCInput, PCOutput, PCHold, clk);
    
    instructionMemory insMem(.address(PCOutput), .instruction(instruction));
    
    control ctrl(.opCode(instruction[31:26]), .regDst(regDst), .jump(jump), .beq(beq), .bne(bne), .memRead(memRead), .memReg(memReg), .ALUOp(ALUOp), .memWrite(memWrite), .ALUSrc(ALUSrc), .regWrite(regWrite));
    
    signExtend signExt(.short(instruction[15:0]), .extended(extended));
    
    ALUControl ALUCtrl(.func(instruction[5:0]), .opCode(ALUOp),.control(ALUControlSignal));
    
    mux5 muxReg(.inputA(instruction[20:16]), .inputB(instruction[15:11]), .control(regDst), .out(writeReg));
    
    registerFile RF(.clk(clk), .regWrite(regWrite), .readReg1(instruction[25:21]), .readReg2(instruction[20:16]), .writeReg(writeReg), .readData1(regReadData1), .readData2(regReadData2), .writeData(writeData));
    
    mux32 muxALU(.inputA(regReadData2), .inputB(extended), .control(ALUSrc), .out(ALUsecond));
    
    ALU alu(.first(regReadData1), .second(ALUsecond), .control(ALUControlSignal), .zero(ALUZero), .result(ALUResult));
    
    dataMemory mem(.clk(clk), .address(ALUResult), .dataWrite(regReadData2), .dataRead(memReadData), .writeMem(memWrite), .readMem(memRead));
    
    mux32 muxWB(.inputA(ALUResult), .inputB(memReadData), .control(memReg), .out(writeData));

endmodule // single_cycle

`endif // MODULE_SINGLE_CYCLE

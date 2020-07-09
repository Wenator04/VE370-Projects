`ifndef MODULE_PIPELINED
`define MODULE_PIPELINED
`timescale 1ns / 1ps

`include "ALU.v"
`include "ALUControl.v"
`include "control.v"
`include "instructionMemory.v"
`include "mux5.v"
`include "registerFile.v"
`include "dataMemory.v"
`include "signExtend.v"
`include "PC.v"
`include "IFID.v"
`include "IDEX.v"
`include "EXMEM.v"
`include "MEMWB.v"
`include "forward.v"
`include "hazardDetection.v"
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/07/09 15:21:52
// Design Name: 
// Module Name: pipelined
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


module pipelined(clk, regInput, PCOutput, regOutput);
    input clk;
    input[4:0] regInput;
    output[31:0] PCOutput,
                 regOutput;


    wire flushIFID,
          flushIDEX,
          stall;

    // IF stage
    wire[31:0] PCInputIF,
                PCOutputIF,
                PCPlus4IF,
                instructionIF,
                branchResultIF;

    // ID stage
    wire[31:0] PCPlus4ID,
                PCPlusResultID,
                instructionID,
                regReadData1ID,
                regReadData2ID,
                regReadData1NewID,
                regReadData2NewID,
                signExtendID,
                jumpAddressID;
    wire[4:0] registerRsID,
               registerRtID,
               registerRdID;
    wire[1:0] ALUOpID;
    wire regDstID,
          jumpID,
          beqID,
          bneID,
          memReadID,
          memRegID,
          memWriteID,
          ALUSrcID,
          regWriteID,
          branchID,
          regReadDataEqID;

    // EX stage
    wire[31:0] regReadData1EX,
                regReadData2EX,
                signExtendEX,
                ALUInAEX,
                ALUInTempBEX,
                ALUInBEX,
                ALUResultEX;
    wire[4:0] registerRsEX,
               registerRtEX,
               registerRdEX,
              registerEX;
    wire[3:0] ALUControlEX;
    wire[1:0] ALUOpEX;
    wire regDstEX,
          memReadEX,
          memRegEX,
          memWriteEX,
          ALUSrcEX,
          regWriteEX,
          ALUZeroEX;

    // MEM stage
    wire[31:0] ALUResultMEM,
                regReadData2MEM,
                memReadDataMEM;
    wire[4:0] registerMEM;
    wire memReadMEM,
          memRegMEM,
          memWriteMEM,
          regWriteMEM;
    // WB stage
    wire[31:0] ALUResultWB,
                memReadDataWB,
                regWriteDataWB;
    wire[4:0] registerWB;
    wire memRegWB,
         regWriteWB;

    // Data Hazard
    wire[1:0] forwardA,
               forwardB;
    wire forwardC,
          forwardD;

    // IF stage
    PC pc(.PCInput(PCInputIF), .PCOutput(PCOutputIF), .PCHold(stall), .clk(clk));
    instructionMemory insMem(.address(PCOutputIF), .instruction(instructionIF));
    assign PCPlus4IF = PCOutputIF + 4;

    // IF/ID
    IFID ifid (
        .clk(clk), .stall(stall), .flush(flushIFID),
        .PCPlus4IF(PCPlus4IF), .PCPlus4ID(PCPlus4ID),
        .instructionIF(instructionIF), .instructionID(instructionID)
    );

    // ID stage
    assign registerRsID = instructionID[25:21];
    assign registerRtID = instructionID[20:16];
    assign registerRdID = instructionID[15:11];
    control ctrl (
        .opCode(instructionID[31:26]),
        .regDst(regDstID),
        .jump(jumpID),
        .beq(beqID),
        .bne(bneID),
        .memRead(memReadID),
        .memReg(memRegID),
        .memWrite(memWriteID),
        .ALUSrc(ALUSrcID),
        .regWrite(regWriteID),
        .ALUOp(ALUOpID));
    registerFile RF (
        .clk(clk),
        .regWrite(regWriteWB),
        .readReg1(registerRsID),
        .readReg2(registerRtID),
        .readRegExtra(regInput),
        .writeReg(registerWB),
        .readData1(regReadData1ID),
        .readData2(regReadData2ID),
        .readDataExtra(regOutput),
        .writeData(regWriteDataWB)
    );
    signExtend signExt(.short(instructionID[15:0]), .extended(signExtendID));
    assign PCPlusResultID = PCPlus4ID + (signExtendID << 2);
    assign regReadData1NewID = (forwardC) ? ALUResultMEM : regReadData1ID;
    assign regReadData2NewID = (forwardD) ? ALUResultMEM : regReadData2ID;
    assign regReadDataEqID = (regReadData1NewID == regReadData2NewID);
    assign branchID = (beqID && regReadDataEqID) || (bneID && !regReadDataEqID);
    assign branchResultIF = (!branchID) ? PCPlus4IF : PCPlusResultID;
    assign jumpAddressID = {PCPlus4ID[31:28], instructionID[25:0], 2'b0};
    assign PCInputIF = (!jumpID) ? branchResultIF : jumpAddressID;
    assign flushIFID = branchID;

    // ID/EX
    IDEX idex (
        .clk(clk), .flush(flushIDEX),
        .regReadData1ID(regReadData1ID), .regReadData1EX(regReadData1EX),
        .regReadData2ID(regReadData2ID), .regReadData2EX(regReadData2EX),
        .signExtendID(signExtendID), .signExtendEX(signExtendEX),
        .registerRsID(registerRsID), .registerRsEX(registerRsEX),
        .registerRtID(registerRtID), .registerRtEX(registerRtEX),
        .registerRdID(registerRdID), .registerRdEX(registerRdEX),
        .ALUOpID(ALUOpID), .ALUOpEX(ALUOpEX),
        .regDstID(regDstID), .regDstEX(regDstEX),
        .memReadID(memReadID), .memReadEX(memReadEX),
        .memRegID(memRegID), .memRegEX(memRegEX),
        .memWriteID(memWriteID), .memWriteEX(memWriteEX),
        .ALUSrcID(ALUSrcID), .ALUSrcEX(ALUSrcEX),
        .regWriteID(regWriteID), .regWriteEX(regWriteEX)
    );

    ALUControl ALUCtrl (
        .func(signExtendEX[5:0]),
        .opCode(ALUOpEX),
        .control(ALUControlEX)
    );
    assign ALUInAEX = (forwardA == 2'b00) ? regReadData1EX :
        ((forwardA == 2'b01) ? regWriteDataWB : ALUResultMEM);
    assign ALUInTempBEX = (forwardB == 2'b00) ? regReadData2EX :
        ((forwardB == 2'b01) ? regWriteDataWB : ALUResultMEM);
    assign ALUInBEX = (!ALUSrcEX) ? ALUInTempBEX : signExtendEX;
    ALU alu(
        .first(ALUInAEX),
        .second(ALUInBEX),
        .control(ALUControlEX),
        .zero(ALUZeroEX),
        .result(ALUResultEX)
    );
    assign registerEX = (!regDstEX) ? registerRtEX : registerRdEX;

    EXMEM exmem (
        .clk(clk),
        .ALUResultEX(ALUResultEX), .ALUResultMEM(ALUResultMEM),
        .regReadData2EX(ALUInTempBEX), .regReadData2MEM(regReadData2MEM),
        .registerEX(registerEX), .registerMEM(registerMEM),
        .memReadEX(memReadEX), .memReadMEM(memReadMEM),
        .memRegEX(memRegEX), .memRegMEM(memRegMEM),
        .memWriteEX(memWriteEX), .memWriteMEM(memWriteMEM),
        .regWriteEX(regWriteEX), .regWriteMEM(regWriteMEM)
    );

    dataMemory mem(
        .clk(clk),
        .address(ALUResultMEM),
        .dataWrite(regReadData2MEM),
        .dataRead(memReadDataMEM),
        .writeMem(memWriteMEM),
        .readMem(memReadMEM)
    );

    MEMWB memwb (
        .clk(clk),
        .memReadDataMEM(memReadDataMEM), .memReadDataWB(memReadDataWB),
        .ALUResultMEM(ALUResultMEM), .ALUResultWB(ALUResultWB),
        .registerMEM(registerMEM), .registerWB(registerWB),
        .memRegMEM(memRegMEM), .memRegWB(memRegWB),
        .regWriteMEM(regWriteMEM), .regWriteWB(regWriteWB)
    );

    assign regWriteDataWB = (!memRegWB) ? ALUResultWB : memReadDataWB;

    forward Forward (
        .registerRsID(registerRsID),
        .registerRtID(registerRtID),
        .registerRsEX(registerRsEX),
        .registerRtEX(registerRtEX),
        .registerRdMEM(registerMEM),
        .registerRdWB(registerWB),
        .regWriteMEM(regWriteMEM),
        .regWriteWB(regWriteWB),
        .forwardA(forwardA),
        .forwardB(forwardB),
        .forwardC(forwardC),
        .forwardD(forwardD)
    );

    hazardDetection hazardDetec(
        .beqID(beqID),
        .bneID(bneID),
        .memReadEX(memReadEX),
        .regWriteEX(regWriteEX),
        .memReadMEM(memReadMEM),
        .registerRsID(registerRsID),
        .registerRtID(registerRtID),
        .registerRtEX(registerRtEX),
        .registerRdEX(registerEX),
        .registerRdMEM(registerMEM),
        .stall(stall),
        .flush(flushIDEX)
    );

    assign PCOutput = PCOutputIF;

endmodule

`endif
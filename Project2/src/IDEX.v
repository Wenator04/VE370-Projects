`ifndef MODULE_IDEX
`define MODULE_IDEX
`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/07/09 15:30:13
// Design Name: 
// Module Name: IDEX
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


module IDEX (clk, flush, regReadData1ID,  regReadData2ID, signExtendID, registerRsID, registerRtID, registerRdID, ALUOpID,  regDstID,  memReadID,  memRegID, memWriteID, 
ALUSrcID, regWriteID, regReadData1EX, regReadData2EX, signExtendEX, registerRsEX, registerRtEX, registerRdEX, ALUOpEX, regDstEX, memReadEX, memRegEX, memWriteEX, ALUSrcEX,
regWriteEX);

    input clk;
    input flush;
    input[31:0] regReadData1ID,
                regReadData2ID,
                signExtendID;
    input[4:0] registerRsID,
               registerRtID,
               registerRdID;
    input[1:0] ALUOpID;
    input regDstID,
          memReadID,
          memRegID,
          memWriteID,
          ALUSrcID,
          regWriteID;

    output reg [31:0] regReadData1EX,
                      regReadData2EX,
                      signExtendEX;
    output reg [4:0] registerRsEX,
                     registerRtEX,
                     registerRdEX;
    output reg  [1:0] ALUOpEX;
    output reg regDstEX,
               memReadEX,
               memRegEX,
               memWriteEX,
               ALUSrcEX,
               regWriteEX;

    initial begin
        regReadData1EX = 32'b0;
        regReadData2EX = 32'b0;
        signExtendEX = 32'b0;
        registerRsEX = 5'b0;
        registerRtEX = 5'b0;
        registerRdEX = 5'b0;
        ALUOpEX = 2'b0;
        regDstEX = 1'b0;
        memReadEX = 1'b0;
        memRegEX = 1'b0;
        memWriteEX = 1'b0;
        ALUSrcEX = 1'b0;
        regWriteEX = 1'b0;
    end

    always @ (posedge clk) begin
        if (flush) begin
            ALUOpEX <= 2'b0;
            regDstEX <= 1'b0;
            memReadEX <= 1'b0;
            memRegEX <= 1'b0;
            memWriteEX <= 1'b0;
            ALUSrcEX <= 1'b0;
            regWriteEX <= 1'b0;
        end else begin
            regReadData1EX <= regReadData1ID;
            regReadData2EX <= regReadData2ID;
            signExtendEX <= signExtendID;
            registerRsEX <= registerRsID;
            registerRtEX <= registerRtID;
            registerRdEX <= registerRdID;
            ALUOpEX <= ALUOpID;
            regDstEX <= regDstID;
            memReadEX <= memReadID;
            memRegEX <= memRegID;
            memWriteEX <= memWriteID;
            ALUSrcEX <= ALUSrcID;
            regWriteEX <= regWriteID;
        end
    end

endmodule

`endif

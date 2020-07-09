`ifndef MODULE_REGISTERFILE
`define MODULE_REGISTERFILE
`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/07/08 23:44:24
// Design Name: 
// Module Name: Register
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

module registerFile (clk, regWrite, readReg1, readReg2, readRegExtra, writeReg, readData1, readData2, readDataExtra, writeData);
    input clk, regWrite;
    input[4:0] readReg1, readReg2, readRegExtra;
    input[4:0] writeReg;
    output[31:0] readData1, readData2, readDataExtra;
    input[31:0] writeData;
    reg [31:0] registers [0:31];
    integer i;

    initial begin
        for (i = 0; i < 32; i = i + 1)
            registers[i] = 32'b0;
    end

    always @ (posedge clk)
    begin
        if (regWrite == 1)
            registers[writeReg] <= writeData;
    end
    
    assign readData1 = registers[readReg1];
    assign readData2 = registers[readReg2];
    assign readDataExtra = registers[readRegExtra];
endmodule

`endif

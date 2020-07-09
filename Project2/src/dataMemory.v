`ifndef MODULE_DATAMEMORY
`define MODULE_DATAMEMORY
`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/07/08 22:41:26
// Design Name: 
// Module Name: dataMemory
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


module dataMemory(clk, address, dataWrite, dataRead, writeMem, readMem);
    parameter bits=32;
    parameter size=128;
    
    input clk;
    input writeMem;
    input readMem;
    input [bits-1:0] address;
    input [bits-1:0] dataWrite;
    output [bits-1:0] dataRead;
    
    reg [bits-1:0] memory[0:size - 1];
    
    integer             i;
    
   initial begin
        for (i = 0; i < size; i = i + 1)
            memory[i] = 32'b0;
    end
    
    always @(posedge clk)
    begin
        if (writeMem==1'b1)
        begin
            memory[address>>2]=dataWrite;
        end
    end
    
    assign dataRead=(readMem==1'b1)?memory[address>>2]:32'b0;
endmodule

`endif 
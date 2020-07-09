`ifndef MODULE_PC
`define MODULE_PC
`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/07/08 22:22:45
// Design Name: 
// Module Name: PC
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


module PC(PCInput, PCOutput, PCHold, clk);
input [31:0]PCInput;
input PCHold;
input clk;
output [31:0]PCOutput;

reg [31:0]PCOutput;

initial PCOutput <=0;

always@(posedge clk)
begin
    if(!PCHold)
        PCOutput <= PCInput;
end
endmodule

`endif
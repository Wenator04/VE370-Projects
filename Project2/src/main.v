`ifndef MODULE_MAIN
`define MODULE_MAIN
`timescale 1ns / 1ps

`include "pipelined.v"
`include "ssd.v"
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/07/09 21:40:41
// Design Name: 
// Module Name: main
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


module main(clk50M, clk, ifPC, register, C, AN);
    input clk50M, clk, ifPC;
    input [4:0] register;
    output [6:0] C;
    output [3:0] AN;
    
    wire[4:0] regInput;
    wire[31:0] PCOutput,
                regOut;
    wire[15:0] display;

    assign display = (ifPC) ? PCOutput : regOut;
    assign regInput = (register < 8) ? register + 16 : ((register < 16) ? register : register + 8);
    pipelined pipe(.clk(clk), .PCOutput(PCOutput), .regInput(regInput), .regOutput(regOut));
    ssd SSD(.clk(clk50M), .inputNum(display), .C(C), .AN(AN));
endmodule

`endif
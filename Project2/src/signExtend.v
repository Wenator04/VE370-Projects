`ifndef MODULE_SIGNEXTEND
`define MODULE_SIGNEXTEND
`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/07/08 02:52:07
// Design Name: 
// Module Name: sign_extend
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


module signExtend(short,extended);
parameter shortbits=16; //bits of short input
parameter extendedbits=32; //bits of extended output

input [shortbits-1:0] short;
output [extendedbits-1:0] extended;

assign extended[shortbits-1:0] = short[shortbits-1:0];
assign extended[extendedbits-1:shortbits] = (short[shortbits-1])?16'b1111111111111111:16'b0; //extension
endmodule

`endif
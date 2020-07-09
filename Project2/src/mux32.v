`ifndef MODULE_MUX32
`define MODULE_MUX32
`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/07/09 13:28:01
// Design Name: 
// Module Name: mux_32
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


module mux32(inputA, inputB, control, out);
    parameter bits = 32;
    input [bits-1:0] inputA;
    input [bits-1:0] inputB;
    input control; //the control signal
    output [bits-1:0] out; //the output
    assign out= (control==1'b0) ?inputA:inputB;
endmodule

`endif
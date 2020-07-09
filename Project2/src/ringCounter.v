`ifndef MODULE_RINGCOUNTER
`define MODULE_RINGCOUNTER
`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/07/09 21:35:20
// Design Name: 
// Module Name: ringCounter
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


module ringCounter(clk, counter);
    input clk;
    output reg[1:0] counter;
    initial begin
        counter = 2'b0;
    end

    always @(posedge clk) begin
        counter = counter + 1;
    end
endmodule

`endif
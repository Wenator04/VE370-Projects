`ifndef MODULE_CLOCKDIVIDER
`define MODULE_CLOCKDIVIDER
`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/07/09 21:33:55
// Design Name: 
// Module Name: clockDivider
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


module clockDivider(clk, divided);
    input clk;
    output reg divided;
    parameter ratio = 10;
    integer now = 1;

    initial begin
        divided = 1'b0;
    end

    always @(posedge clk) begin
        if (now <= ratio / 2) divided = 1;
        else divided = 0;
        if (now == ratio) now = 1;
        else now = now + 1;
    end

endmodule

`endif
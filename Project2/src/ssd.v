`ifndef MODULE_SSD
`define MODULE_SSD
`timescale 1ns / 1ps

`include "ringCounter.v"
`include "clockDivider.v"
`include "SSDDriver.v"

//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/07/09 21:37:08
// Design Name: 
// Module Name: ssd
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


module ssd(clk, inputNum, C, AN);
    input clk;
    input[15:0] inputNum;
    output[6:0] C;
    output reg[3:0] AN;
    
     wire                clk500,
                        clk1;
    wire        [1:0]   counter;
    reg         [3:0]   Q;

    initial begin
        Q = 4'b0000;
        AN = 4'b1111;
    end

    clockDivider #(
        .ratio(100000)
    ) clockDivider1(
        .clk(clk),
        .divided(clk500)
    );

    clockDivider #(
        .ratio(500)
    ) clockDivider2(
        .clk(clk),
        .divided(clk1)
    );

    ringCounter rCounter(
        .clk(clk500),
        .counter(counter)
    );

    always @ ( * ) begin
        case (counter)
            2'b00: begin
                Q = inputNum[15:12];
                AN = 4'b0111;
            end
            2'b01: begin
                Q = inputNum[11:8];
                AN = 4'b1011;
            end
            2'b10: begin
                Q = inputNum[7:4];
                AN = 4'b1101;
            end
            2'b11: begin
                Q = inputNum[3:0];
                AN = 4'b1110;
            end
            default: begin
                Q = 4'b0000;
                AN = 4'b1111;
            end
        endcase
    end

    SSDDriver ssdDriver (.Q(Q), .C(C));
endmodule

`endif
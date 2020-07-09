`ifndef MODULE_IFID
`define MODULE_IFID
`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/07/09 15:30:13
// Design Name: 
// Module Name: IFID
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


module IFID (clk, stall, flush, PCPlus4IF, instructionIF, PCPlus4ID, instructionID);
    input clk;
    input stall;
    input flush;
    input[31:0] PCPlus4IF;
    input[31:0] instructionIF;
    output reg [31:0] PCPlus4ID;
    output reg [31:0] instructionID;

    initial begin
        PCPlus4ID = 32'b0;
        instructionID = 32'b0;
    end

    always @ (posedge clk) begin
        if (flush) begin
            PCPlus4ID <= 32'b0;
            instructionID <= 32'b0;
        end else if (!stall) begin
            PCPlus4ID <= PCPlus4IF;
            instructionID <= instructionIF;
        end
    end

endmodule


`endif
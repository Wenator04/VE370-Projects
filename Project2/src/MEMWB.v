`ifndef MODULE_MEMWB
`define MODULE_MEMWB
`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/07/09 15:30:13
// Design Name: 
// Module Name: MEMWB
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


module MEMWB (clk, memReadDataMEM, ALUResultMEM, registerMEM, memRegMEM, regWriteMEM, memReadDataWB, ALUResultWB, registerWB, memRegWB, regWriteWB);
    input clk;
    input[31:0] memReadDataMEM;
    input[31:0] ALUResultMEM;
    input[4:0] registerMEM;
    input memRegMEM;
    input regWriteMEM;

    output reg[31:0] memReadDataWB;
    output reg[31:0] ALUResultWB;
    output reg[4:0] registerWB;
    output reg memRegWB;
    output reg regWriteWB;

    initial begin
        memReadDataWB = 32'b0;
        ALUResultWB = 32'b0;
        registerWB = 5'b0;
        memRegWB = 1'b0;
        regWriteWB = 1'b0;
    end

    always @ (posedge clk) begin
        memReadDataWB <= memReadDataMEM;
        ALUResultWB <= ALUResultMEM;
        registerWB <= registerMEM;
        memRegWB <= memRegMEM;
        regWriteWB <= regWriteMEM;
    end

endmodule

`endif

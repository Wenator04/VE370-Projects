`ifndef MODULE_EXMEM
`define MODULE_EXMEM
`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/07/09 15:30:13
// Design Name: 
// Module Name: EXMEM
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


module EXMEM (clk, ALUResultEX, regReadData2EX, registerEX, memReadEX, memRegEX, memWriteEX, regWriteEX, ALUResultMEM, regReadData2MEM, registerMEM, memReadMEM, memRegMEM, memWriteMEM, regWriteMEM);
input clk;
input[31:0] ALUResultEX;
input[31:0] regReadData2EX;
input[4:0] registerEX;
input memReadEX;
input memRegEX;
input memWriteEX;
input regWriteEX;

output reg[31:0] ALUResultMEM;
output reg[31:0] regReadData2MEM;
output reg[4:0] registerMEM;
output reg memReadMEM;
output reg memRegMEM;
output reg memWriteMEM;
output reg regWriteMEM;

    initial begin
        ALUResultMEM = 32'b0;
        regReadData2MEM = 32'b0;
        registerMEM = 5'b0;
        memReadMEM = 1'b0;
        memRegMEM = 1'b0;
        memWriteMEM = 1'b0;
        regWriteMEM = 1'b0;
    end

    always @ (posedge clk) begin
        ALUResultMEM <= ALUResultEX;
        regReadData2MEM <= regReadData2EX;
        registerMEM <= registerEX;
        memReadMEM <= memReadEX;
        memRegMEM <= memRegEX;
        memWriteMEM <= memWriteEX;
        regWriteMEM <= regWriteEX;
    end

endmodule // EX_MEM

`endif // MODULE_EX_MEM

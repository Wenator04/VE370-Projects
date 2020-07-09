`ifndef MODULE_ALUCONTROL
`define MODULE_ALUCONTROL
`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/07/08 02:34:12
// Design Name: 
// Module Name: ALUcontrol
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


module ALUControl(func, opCode, control);
    parameter cbits=4;
    
    input [5:0] func; //function part of machine code
    input [1:0] opCode;
    output reg [cbits-1:0] control;
    
    always @(func or opCode)
    begin
        case(opCode)
            2'b00:
                control = 4'b0010;
            2'b01:
                control = 4'b0110;
            2'b10:
            begin
                case(func)
                6'b100100:
                    control = 4'b0000;
                6'b100101:
                    control = 4'b0001;
                6'b100000:
                    control = 4'b0010;
                6'b100010:
                    control = 4'b0110;
                6'b101010:
                    control = 4'b0111;
                endcase
            end
            2'b11:
                control = 4'b0000;
            endcase
    end
endmodule

`endif

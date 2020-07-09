`ifndef MODULE_ALU
`define MODULE_ALU
`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/07/08 02:02:56
// Design Name: 
// Module Name: ALU
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


module ALU(first, second, control, zero, result);
    parameter bits=32;
    parameter cbits=4; //bits of ALU control signal
    
    input [bits-1:0] first;
    input [bits-1:0] second;
    input [cbits-1:0] control;
    output [bits-1:0] result;
    output zero;
    
    reg [bits-1:0] result;
    
    assign zero = (result == 0);
    
    always @(control or first or second)
    begin
        case(control)
            4'b0000:
            begin
                result = first & second;
            end
            4'b0001:
            begin
                result = first | second;
            end
            4'b0010:
            begin
                result = first + second;
            end
            4'b0110:
            begin
                result = first - second;
            end
            4'b0111:
            begin
                result = (first < second) ? 1:0;
            end
            4'b1100:
                result = ~(first | second);
            default: ;
       endcase
    end
endmodule

`endif
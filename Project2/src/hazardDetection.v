`ifndef MODULE_HAZARDDETECTION
`define MODULE_HAZARDDETECTION
`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/07/09 15:30:13
// Design Name: 
// Module Name: harzarDetection
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


module hazardDetection (beqID, bneID, memReadEX, regWriteEX, memReadMEM, registerRsID, registerRtID, registerRtEX, registerRdEX, registerRdMEM, stall, flush);
    input beqID,
          bneID,
          memReadEX,
          regWriteEX,
          memReadMEM;
    input [4:0] registerRsID,
                registerRtID,
                registerRtEX,
                registerRdEX,
                registerRdMEM;
    output reg stall,
                flush;
    initial begin
        stall = 1'b0;
        flush = 1'b0;
    end

    always @ ( * ) begin
        if (memReadEX && registerRtEX && (registerRtEX == registerRsID || registerRtEX == registerRtID)) begin
            stall = 1'b1;
            flush = 1'b1;
        end else if (beqID || bneID) begin
            if (regWriteEX && registerRdEX && (registerRdEX == registerRsID || registerRdEX == registerRtID)) begin
                stall = 1'b1;
                flush = 1'b1;
            end else if (memReadMEM && registerRdMEM && (registerRdMEM == registerRsID || registerRdMEM == registerRtID)) begin
                stall = 1'b1;
                flush = 1'b1;
            end else begin
                stall = 1'b0;
                flush = 1'b0;
            end
        end else begin
            stall = 1'b0;
            flush = 1'b0;
        end
    end

endmodule

`endif

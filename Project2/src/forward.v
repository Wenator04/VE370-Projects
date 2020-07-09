`ifndef MODULE_FORWARD
`define MODULE_FORWARD
`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/07/09 15:30:13
// Design Name: 
// Module Name: forward
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


module forward (registerRsID, registerRtID, registerRsEX, registerRtEX, registerRdMEM, registerRdWB, regWriteMEM, regWriteWB, forwardA, forwardB, forwardC, forwardD);
    input[4:0] registerRsID,
               registerRtID,
               registerRsEX,
               registerRtEX,
               registerRdMEM,
               registerRdWB;
    input regWriteMEM,
          regWriteWB;
    output reg  [1:0] forwardA,
                       forwardB;
    output reg forwardC,
                forwardD;
    initial begin
        forwardA = 2'b00;
        forwardB = 2'b00;
        forwardC = 1'b0;
        forwardD = 1'b0;
    end

    always @ ( * ) begin
        if (regWriteMEM && registerRdMEM && registerRdMEM == registerRsEX)
            forwardA = 2'b10;
        else if (regWriteWB && registerRdWB && registerRdWB == registerRsEX)
            forwardA = 2'b01;
        else
            forwardA = 2'b00;

        if (regWriteMEM && registerRdMEM && registerRdMEM == registerRtEX)
            forwardB = 2'b10;
        else if (regWriteWB && registerRdWB && registerRdWB == registerRtEX)
            forwardB = 2'b01;
        else
            forwardB = 2'b00;

        if (regWriteMEM && registerRdMEM && registerRdMEM == registerRsID)
            forwardC = 1'b1;
        else
            forwardC = 1'b0;

        if (regWriteMEM && registerRdMEM && registerRdMEM == registerRtID)
            forwardD = 1'b1;
        else
            forwardD = 1'b0;
    end

endmodule

`endif

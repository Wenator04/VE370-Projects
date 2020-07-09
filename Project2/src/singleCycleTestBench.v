`timescale 1ns / 1ps
`include "singleCycle.v"
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/07/09 12:52:26
// Design Name: 
// Module Name: singleCycleTestBench
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


module singleCycleTestBench();
    integer i = 0;
	reg clk;
	singleCycle uut(.clk(clk));

	initial begin
	#0	clk = 0;
        $dumpfile("singleCycle.vcd");
        $dumpvars(1, uut);
        $display("Result of single cycle simulation:");
        $display("==========================================================");
        #500;
        $stop;
	end

    always #10 begin
        $display("Time: %d ns, CLK = %d, PC = 0x%H", i, clk, uut.PCOutput);
        $display("Instruction: %H", uut.instruction);
        $display("writeData: %H",uut.writeData);
        $display("[$s0] = 0x%H, [$s1] = 0x%H, [$s2] = 0x%H", uut.RF.registers[16], uut.RF.registers[17], uut.RF.registers[18]);
        $display("[$s3] = 0x%H, [$s4] = 0x%H, [$s5] = 0x%H", uut.RF.registers[19], uut.RF.registers[20], uut.RF.registers[21]);
        $display("[$s6] = 0x%H, [$s7] = 0x%H, [$t0] = 0x%H", uut.RF.registers[22], uut.RF.registers[23], uut.RF.registers[8]);
        $display("[$t1] = 0x%H, [$t2] = 0x%H, [$t3] = 0x%H", uut.RF.registers[9], uut.RF.registers[10], uut.RF.registers[11]);
        $display("[$t4] = 0x%H, [$t2] = 0x%H, [$t6] = 0x%H", uut.RF.registers[12], uut.RF.registers[13], uut.RF.registers[14]);
        $display("[$t7] = 0x%H, [$t8] = 0x%H, [$t9] = 0x%H", uut.RF.registers[15], uut.RF.registers[24], uut.RF.registers[25]);
        $display("----------------------------------------------------------");
        clk = ~clk;
        i = i + 10;
    end
endmodule

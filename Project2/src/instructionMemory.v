`ifndef MODULE_INSTRUCTIONMEMORY
`define MODULE_INSTRUCTIONMEMORY
`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/07/08 21:51:15
// Design Name: 
// Module Name: instructionMemory
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


module instructionMemory(address, instruction);
	input [31:0] address;  //instruction addrress
	output reg [31:0] instruction; //get instruction's machine code

//store instruction and pick out by programs	
	always @(*)
		case (address>>2)
  'd0:  instruction = 32'b00100000000010000000000000100000; //addi $t0, $zero, 0x20
  'd1:    instruction = 32'b00100000000010010000000000110111; //addi $t1, $zero, 0x37
  'd2:    instruction = 32'b00000001000010011000000000100100; //and $s0, $t0, $t1
   'd3:   instruction = 32'b00000001000010011000000000100101; //or $s0, $t0, $t1
   'd4:  instruction = 32'b10101100000100000000000000000100; //sw $s0, 4($zero)
    'd5:  instruction = 32'b10101100000010000000000000001000; //sw $t0, 8($zero)
    'd6:  instruction = 32'b00000001000010011000100000100000; //add $s1, $t0, $t1
    'd7: instruction = 32'b00000001000010011001000000100010; //sub $s2, $t0, $t1
    'd8:  instruction= 32'b00010010001100100000000000001001; //beq $s1, $s2, error0
     'd9: instruction = 32'b10001100000100010000000000000100; //lw $s1, 4($zero)
    'd10:  instruction = 32'b00110010001100100000000001001000; //andi $s2, $s1, 0x48
    'd11:  instruction = 32'b00010010001100100000000000001001; //beq $s1, $s2, error1
    'd12:  instruction = 32'b10001100000100110000000000001000; //lw $s3, 8($zero)
    'd13:  instruction= 32'b00010010000100110000000000001010; //beq $s0, $s3, error2
     'd14: instruction = 32'b00000010010100011010000000101010; //slt $s4, $s2, $s1 (Last)
    'd15: instruction = 32'b00010010100000000000000000001111; //beq $s4, $0, EXIT
    'd16:  instruction = 32'b00000010001000001001000000100000; //add $s2, $s1, $0
     'd17: instruction =32'b00001000000000000000000000001110; //j Last
    'd18: instruction =32'b00100000000010000000000000000000; //addi $t0, $0, 0(error0)
    'd19:  instruction = 32'b00100000000010010000000000000000; //addi $t1, $0, 0
     'd20: instruction = 32'b00001000000000000000000000011111; //j EXIT
     'd21: instruction = 32'b00100000000010000000000000000001; //addi $t0, $0, 1(error1)
    'd22:  instruction =32'b00100000000010010000000000000001; //addi $t1, $0, 1
    'd23: instruction =32'b00001000000000000000000000011111; //j EXIT
     'd24: instruction = 32'b00100000000010000000000000000010; //addi $t0, $0, 2(error2)
    'd25:  instruction = 32'b00100000000010010000000000000010; //addi $t1, $0, 2
     'd26: instruction = 32'b00001000000000000000000000011111; //j EXIT
     'd27: instruction =32'b00100000000010000000000000000011; //addi $t0, $0, 3(error3)
    'd28:  instruction =32'b00100000000010010000000000000011; //addi $t1, $0, 3
     'd29: instruction =32'b00001000000000000000000000011111; //j EXIT
			default: instruction <= 32'h00000000;
		endcase
		
endmodule

`endif
`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:37:02 04/02/2012 
// Design Name: 
// Module Name:    Lab5 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module Lab6( DIGIT, DISPLAY, ROW, COLUMN, operator, clk, reset_n);
	output [3:0] DIGIT;
	output [8:0] DISPLAY;
	output [3:0] ROW;
	input [3:0] COLUMN;
	input [1:0] operator;
	input clk;
	input reset_n;
	
	wire clk_15;
	wire DB_reset_n;
	wire [3:0] KEY_IN;
	wire [3:0] A,B;
	wire [3:0] value_result_tens,value_result_units;
	wire [1:0] DB_operator;
   wire sign_result;
	
	/*add your design here*/
	clock_divisor cd(clk_15, clk);
	debounce db1(DB_reset_n, reset_n, clk_15);
	debounce db2(DB_operator[0], operator[0], clk_15);
	debounce db3(DB_operator[1], operator[1], clk_15);
	KeyBoard_ctrl kc(ROW, KEY_IN, COLUMN, clk, DB_reset_n);
	ADD_SUB as(A, B, value_result_tens, value_result_units, sign_result, KEY_IN, clk, DB_reset_n, DB_operator);
	LED7SEG led(DIGIT, DISPLAY, A, B, value_result_tens, value_result_units, sign_result, 0, 0, clk_15);
endmodule

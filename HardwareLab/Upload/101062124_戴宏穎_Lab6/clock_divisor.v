`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:34:25 03/14/2011 
// Design Name: 
// Module Name:    clock_divisor 
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
module clock_divisor(clk15, clk);
	input clk;
	output clk15;

	reg [14:0] num;
	wire [14:0] next_num;

	always @(posedge clk) begin
		num <= next_num;
	end

	assign next_num = num + 1;
	assign clk15 = num[14];
endmodule

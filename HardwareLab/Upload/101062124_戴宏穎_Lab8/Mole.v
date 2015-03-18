`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:18:44 05/15/2014 
// Design Name: 
// Module Name:    Mole 
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
module Mole(
			output reg [15:0] mole16bit,
			input [3:0]random_value,
			input isFinished,
			input clk, 
			input rst_n
    );
	reg [15:0] next_mole;
	always@ (posedge clk or negedge rst_n) begin
		if (!rst_n) begin
			mole16bit <= 16'd0;
		end else begin
			mole16bit <= next_mole;
		end
	end
	always@ (*) begin
		if (isFinished) begin
			next_mole = mole16bit;
		end else begin
			next_mole = (16'b1 << random_value);
		end
	end
endmodule

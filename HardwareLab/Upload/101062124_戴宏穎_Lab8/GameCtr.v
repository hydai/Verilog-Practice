`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:44:30 05/15/2014 
// Design Name: 
// Module Name:    GameCtr 
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
module GameCtr(
			output reg [3:0] ten,
			output reg [3:0] one,
			output reg [15:0] mole16bit,
			input [3:0] keyIn,
			input isPressed,
			input isFinished,
			input clk_slow,
			input clk_fast,
			input rst_n
    );
	parameter IDLE = 2'b00;
	parameter ON = 2'b01;
	parameter OFF = 2'b10;
	reg [3:0] next_ten, next_one;
	wire [3:0]random_value;
	reg [1:0] nST, ST;
	LFSR rdgen(random_value, clk_slow, rst_n);
	reg [15:0] next_mole;
	always@ (posedge clk_fast or negedge rst_n) begin
		if (!rst_n) begin
			mole16bit <= 16'd0;
			ten <= 4'b0;
			one <= 4'b0;
		end else if (!isFinished) begin
			mole16bit <= next_mole;
			ten <= next_ten;
			one <= next_one;
		end else begin
			mole16bit <= mole16bit;
			ten <= ten;
			one <= one;
		end
	end

	always @(posedge clk_slow or negedge rst_n) begin
		if (!rst_n) begin
			next_ten <= 0;
			next_one <= 0;
		end else if (isFinished) begin
			next_ten <= ten;
			next_one <= one;
		end else if (ST == ON) begin
			if (one == 4'd9) begin
				next_ten <= ten + 4'd1;
				next_one <= 4'd0;
			end else begin
				next_ten <= ten;
				next_one <= one + 4'd1;
			end
		end else if (ST == OFF) begin
			if (one >= 4'd8) begin
				next_ten <= ten + 4'd1;
				next_one <= 4'd0;
			end else begin
				next_ten <= ten;
				next_one <= one + 4'd2;
			end
		end else begin
			next_ten <= ten;
			next_one <= one;
		end
	end
	
	always @(posedge clk_fast) begin
		if (isFinished) begin
			next_mole <= mole16bit;
		end else if (ST == ON || ST == OFF) begin
			next_mole <= mole16bit;
			next_mole[keyIn] <= 1'b0;
		end else begin
			next_mole <= (16'b1 << random_value);
		end
	end
	
	always @(*) begin
		case (ST)
			IDLE: begin
				if ((keyIn & 1 == 1'b1) && (mole16bit[keyIn] == 1'b1)) begin
					nST = ON;
				end else if (mole16bit[keyIn] == 1'b1) begin;
					nST = OFF;
				end else begin
					nST = IDLE;
				end
			end
			ON: begin
				if (clk_slow) begin
					nST = IDLE;
				end else begin
					nST = ON;
				end
			end
			OFF: begin
				if (clk_slow) begin
					nST = IDLE;
				end else begin
					nST = OFF;
				end
			end
			default: begin
				nST = IDLE;
			end
		endcase
	end
	
	always @(posedge clk_fast) begin
		ST <= nST;
	end
endmodule

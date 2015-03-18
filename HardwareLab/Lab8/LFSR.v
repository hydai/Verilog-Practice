`timescale 1ns / 1ps
module LFSR(random, reset, clk);
	input clk, reset;
	output [3:0] random;

	reg [3:0] random;

	always @(posedge clk or negedge reset)begin
		if(!reset)begin
			random[3:0] <= 4'b0000;
		end else begin
			if(random == 4'b0000)
				random <= 4'b0001;
			else begin
				random[2:0] <= random[3:1];
				random[3] <= random[1] ^ random[0];
			end
		end
	 end

endmodule

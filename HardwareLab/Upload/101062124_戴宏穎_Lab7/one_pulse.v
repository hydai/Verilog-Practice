`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:56:06 05/01/2014 
// Design Name: 
// Module Name:    one_pulse 
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
module one_pulse(
					output reg out,
					input in,
					input clk,
					input rst_n
    );

parameter S0 = 0;
parameter S1 = 1;
reg state, nextState, nextOut;
always @(posedge clk or negedge rst_n) begin
	if (!rst_n) begin
		state <= S0;
		out <= 0;
	end else begin
		state <= nextState;
		out <= nextOut;
	end // end of if-else block
end // end of always

// next state
always @(*) begin
	case (state) 
		S0: begin 				// previous input is 0
			if (in == 0) begin	// 0 -> 0 => 0
				nextState = 0;
				nextOut = 0;
			end else begin		// 0 -> 1 => 1
				nextState = 1;
				nextOut = 1;
			end
		end
		S1: begin				// previous input is 1
			nextOut = 0;
			if (in == 0) begin	// 1 -> 0 => 0
				nextState = 0;
			end else begin		// 1 -> 1 => 0;
				nextState = 1;
			end
		end
	endcase
end

endmodule
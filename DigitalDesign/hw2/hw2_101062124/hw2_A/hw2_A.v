//-----------------------------------------------------
// Design Name : hw2_A
// File Name : hw2_A.v
// Function : This program designs an One-Pulse Generator.
// Coder    : hydai
//-----------------------------------------------------
`timescale 1 ns/1 ns
module hw2_A (
				input in,
				input clk,
				input rst_n,
				output reg out
			 );
parameter S0 = 0;
parameter S1 = 1;
reg state, nextState;
reg tmp_out;
always @(posedge clk or negedge rst_n) begin
	if (~rst_n) begin
		state <= S0;
	end else begin
		state <= nextState;
	end // end of if-else block
end // end of always

// next state
always @(*) begin
	case (state) 
		S0: begin 				// previous input is 0
			if (in == 0) begin	// 0 -> 0 => 0
				nextState <= 0;
			end else begin		// 0 -> 1 => 1
				nextState <= 1;
			end
		end
		S1: begin				// previous input is 1
			if (in == 0) begin	// 1 -> 0 => 0
				nextState <= 0;
			end else begin		// 1 -> 1 => 0;
				nextState <= 1;
			end
		end
	endcase
end

// output
always @(*) begin
	case (state)
		S0: begin 				// previous input is 0
			if (in == 0) begin	// 0 -> 0 => 0
				tmp_out <= 0;
			end else begin		// 0 -> 1 => 1
				tmp_out <= 1;
			end
		end
		S1: begin				// previous input is 1
			tmp_out <= 0;
		end
	endcase
end

always @(posedge clk or negedge rst_n) begin
	if(~rst_n) begin
		out <= 0;
	end else begin
		out <= tmp_out;
	end
end
endmodule // endmodule of hw2_A

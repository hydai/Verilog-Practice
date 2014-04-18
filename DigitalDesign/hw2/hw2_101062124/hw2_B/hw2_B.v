//-----------------------------------------------------
// Design Name : hw2_B
// File Name : hw2_B.v
// Function : This program designs a Stream Filter.
// Coder    : hydai
//-----------------------------------------------------
`timescale 1 ns/1 ns
module hw2_B (
				input in,
				input clk,
				input rst_n,
				output reg out
			 );
reg [1:0]state, nextState;
reg nextOut;
parameter S0 = 0;
parameter S1 = 1;
parameter S2 = 2;
always @(posedge clk or negedge rst_n) begin
	if (!rst_n) begin
		out <= 0;
		state <= 0;
	end else begin
		state <= nextState;
		out <= nextOut;
	end // end of if-else block
end // end of always

always @(state or in) begin
	case (state)
		S0: begin								// previous input is 0
			if (in == 0) begin					// 0 -> 0 => 0
				nextState <= S0;
			end else begin						// 0 -> 1 => 0
				nextState <= S1;
			end
		end
		S1: begin								// previous input is 1
			if (in == 0) begin					// 1 -> 0 => 1
				nextState <= S0;
			end else begin						// 1 -> 1 => 0
				nextState <= S2;
			end
		end
		S2: begin
			if (in == 0) begin					// 1 -> 1 -> 0 => 1
				nextState <= S0;
			end else begin						// 1 -> 1 -> 1 => 1
				nextState <= S2;
			end
		end
	endcase
end
always @(state or in) begin
	case (state)
		S0: begin								// previous input is 0
			nextOut <= 0;
		end
		S1: begin								// previous input is 1
			if (in == 0) begin					// 1 -> 0 => 1
				nextOut <= 1;
			end else begin						// 1 -> 1 => 0
				nextOut <= 0;
			end
		end
		S2: begin
			nextOut <= 1;
		end
	endcase
end

always @(posedge clk or negedge rst_n) begin
	if (~rst_n) begin
		out <= 0;
	end else begin
		out <= nextOut;
	end // end of if-else block
end // end of always

endmodule // endmodule of hw2_B

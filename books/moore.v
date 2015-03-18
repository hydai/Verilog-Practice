module mooreFSM (
	output	reg	o_d,
	input 		i_d,
	input		clk,
	input		reset_n
);
parameter	IDLE	=	2'b00;
parameter	S0		=	2'b01;
parameter	S1		=	2'b10;
// inner state/next_state
reg [1:0] state, next_state;
//state
always @(posedge clk or negedge reset_n) begin
	if (!reset_n) begin
		state	<=	IDLE;
	end else begin
		state	<=	next_state;
	end
end
//next_state
always @(*) begin
	case (state)
		IDLE: begin
			if (i_d == 1'b1) begin
				next_state = S0;
			end else begin
				next_state = IDLE;
			end
		end
		S0:	begin
			if (i_d == 1'b1) begin
				next_state = S1;
			end else begin
				next_state = IDLE;
			end
		end
		S1:	begin
			if (i_d == 1'b1) begin
				next_state = S1;
			end else begin
				next_state = IDLE;
			end
		end
		default:	begin
			next_state = IDLE;
		end
	endcase
end
//output
always @(*) begin
	o_d = 1'b0;
	case (state)
		S0: begin
			o_d = 1'b1;
		end
	endcase
end
endmodule
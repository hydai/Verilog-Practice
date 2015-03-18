module mealyFSM (
	output	reg	o_d,
	input 		i_d,
	input		clk,
	input		reset_n
);
parameter	IDLE	=	2'b00;
parameter	S0		=	2'b01;
// inner state/next_state
reg [1:0] state, next_state;
reg o_d_next;
//state
always @(posedge clk or negedge reset_n) begin
	if (!reset_n) begin
		state	<=	IDLE;
	end else begin
		state	<=	next_state;
	end
end
//output
always @(*) begin
	o_d_next = 1'b0;
	case (state)
		IDLE: begin
			if (i_d == 1'b1) begin
				o_d_next = 1'b1;
			end
		end
	endcase
end
//next_state
always @(*) begin
	next_state = IDLE;
	case (state)
		IDLE: begin
			if (i_d == 1'b1) begin
				next_state = S0;
			end
		end
		S0: begin
			if (i_d == 1'b1) begin
				next_state = S0;
			end
		end
	endcase
end
// D-FF stores output
always @(posedge clk or negedge reset_n) begin
    if (!reset_n) begin
        o_d <= 1'b0;
    end else begin
        o_d <= o_d_next;
    end
end
endmodule

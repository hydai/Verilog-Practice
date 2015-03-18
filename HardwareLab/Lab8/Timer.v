`timescale 1ns / 1ps
module Timer(BCD3, BCD2, timesup, reset, clk);

	output[3:0] BCD3, BCD2;
	output timesup;
	input clk, reset;

	reg[3:0] BCD3, BCD2;
	wire[3:0] next_BCD3, next_BCD2;
	wire timesup;
	always@(posedge clk or negedge reset)begin
		if (!reset) begin 	//reset timer to 30
			BCD2 <= 4'b0000;
			BCD3 <= 4'b0011;
		end else begin 		//update the timer
			BCD2 <= next_BCD2;
			BCD3 <= next_BCD3;
		end
	end
	
	// decrement the timer
	assign next_BCD2 = (BCD2==4'd0)? ((BCD3==4'd0)? BCD2:4'd9) : (BCD2-4'd1);
	assign next_BCD3 = (BCD2==4'd0)? ((BCD3==4'd0)? BCD3:BCD3-4'd1) : BCD3;
	assign timesup = (BCD2==0)? ((BCD3==0)? 1'd1:1'd0) : 1'd0;
endmodule

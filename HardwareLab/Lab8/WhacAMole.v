`timescale 1ns / 1ps
module WhacAMole(BCD1, BCD0, mole_position, random, mallet_position, timesup, PRESS_VALID, reset, clk_1us);

	input PRESS_VALID, reset, clk_1us;
	input [3:0] random;
	input [3:0] mallet_position;
	input timesup;

	output [3:0] BCD1, BCD0;
	output [4:0] mole_position;
	
	reg [4:0] mole_position;
	wire [4:0] next_mole;
	reg [3:0] BCD0, BCD1;
	wire [3:0] next_BCD0, next_BCD1;
	reg[19:0] counter500000, next_counter500000;	//500000 * 1us = 0.5s
	reg [1:0] state, next_state;
	reg generatenewmole, next_generatenewmole;
	wire hit;
	parameter status0 = 2'h0;
	parameter status1 = 2'h1;
	parameter status2 = 2'h2;
	
	
	always @(posedge clk_1us or negedge reset)begin
		if(!reset)begin
			mole_position <= 5'd0;
			state <= 2'd0;
			BCD0 <= 4'd0;
			BCD1 <= 4'd0;
			counter500000 <= 20'd0;
			generatenewmole <= 0;
		end else begin
			mole_position <= next_mole;
			state <= next_state;
			BCD0 <= next_BCD0;
			BCD1 <= next_BCD1;
			counter500000 <= next_counter500000;
			generatenewmole <= next_generatenewmole;
		end
	end
	 
	 
	
	always @(*)	begin
		case (state)
		
			status0: begin
				if(hit) begin
					next_state = status2;
					next_counter500000 = 20'd0;
				end else if(counter500000==20'd500000) begin
					next_state = status1;
					next_counter500000 = 20'd0;
				end else begin
					next_state = state;
					next_counter500000 = counter500000 + 20'd1;
				end
				next_generatenewmole = 0;
			end
			
			status1: begin
				if(hit) begin
					next_state = status2;
					next_counter500000 = 20'd0;
				end else if(counter500000==20'd500000) begin
					next_state = status2;
					next_counter500000 = 20'd0;
				end else begin
					next_state = state;
					next_counter500000 = counter500000 + 20'd1;
				end
				next_generatenewmole = 0;
			end
			
			// disappear and generate next new mole (hit or 1s after appear)
			status2: begin
				if(counter500000==20'd500000) begin
					next_state = status0;
					next_counter500000 = 20'd0;
					next_generatenewmole = 1;
				end else begin
					next_state = state;
					next_counter500000 = counter500000 + 20'd1;
					next_generatenewmole = 0;
				end
			end
			
			default: begin
				next_state = 2'd0;
				next_counter500000 = 20'd0;
				next_generatenewmole = 1;
			end
			
		endcase
	end
	
	// judge the hit and update the scores
	assign next_BCD0 = (hit==4'd1) ? ( (BCD0==4'd9) ? 4'd0 : (BCD0+4'd1) ) : BCD0;
	assign next_BCD1 = (hit==4'd1) ? ( (BCD0==4'd9) ? (BCD1+4'd1) : BCD1 ) : BCD1;
	assign hit = ((mallet_position == mole_position[3:0])&&(!timesup)&&(PRESS_VALID)) ? 1'd1 : 1'd0;
	
	//one bit for "no mole to show" ( 5'b10000 = 16'd0 = none -> refer MoleDecoder.v )
	assign next_mole = (hit) ? 5'b10000 : ((state==status2) ? 5'b10000 : ((generatenewmole && !timesup) ? random : mole_position));	
	 
	
	
endmodule

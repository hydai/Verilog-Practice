`timescale 1ns / 1ps
module CLK_DIV(
    output reg  clk_1us,
    input       clk
);

	wire next_clk_1us;
	reg  [15:0] num;
	wire [15:0] next_num;
	reg [5:0] num1us, next_num1us;
	
	always @( posedge clk)begin
		num <= next_num;
		num1us <= next_num1us;
		clk_1us <= next_clk_1us;
	end
	
	always @( * )begin
		//40/40Mhz=1us
		if(num1us>=6'd39)
			next_num1us = 6'd0;
		else
			next_num1us = num1us + 6'd1;
	end
	assign next_num = num + 16'd1;
		
	assign next_clk_1us = (num1us<6'd20) ? 1'd0 : 1'd1;
endmodule



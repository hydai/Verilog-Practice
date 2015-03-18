`timescale 1ns / 1ps
module CLK_DIV(clk_LCD, clk_7seg, clk_1s, clk_500ms, clk_1us, clk);

	input clk;
	output clk_LCD, clk_7seg, clk_1s, clk_500ms, clk_1us;
	
	wire clk_LCD, clk_7seg;
	reg clk_1s, clk_500ms, clk_1us;
	wire next_clk_1s, next_clk_500ms, next_clk_1us;
	
	reg  [15:0] num;
	wire [15:0] next_num;
	reg [5:0] num1us, next_num1us;
	reg [25:0] num500ms, next_num500ms;
	reg [25:0] num1s, next_num1s;
	
	always @( posedge clk)begin
		num <= next_num;

		num1us <= next_num1us;
		num500ms <= next_num500ms;
		num1s <= next_num1s;
		
		clk_1s <= next_clk_1s;
		clk_500ms <= next_clk_500ms;
		clk_1us <= next_clk_1us;
	end
	
	
	always @( * )begin
		//40/40Mhz=1us
		if(num1us>=6'd39)
			next_num1us = 6'd0;
		else
			next_num1us = num1us + 6'd1;

		//20M/40Mhz=500ms
		if(num500ms>=26'd19999999)
			next_num500ms = 26'd0;
		else
			next_num500ms = num500ms + 26'd1;

		//40M/40Mhz=1s
		if(num1s>=26'd39999999)
			next_num1s = 26'd0;
		else
			next_num1s = num1s + 26'd1;
	end
	
	assign next_num = num + 16'd1;
		
	assign clk_LCD = num[8];
	assign clk_7seg = num[15];		
	assign next_clk_1s = (num1s<26'd20000000) ? 1'd0 : 1'd1;
	assign next_clk_500ms = (num500ms<26'd10000000) ? 1'd0 : 1'd1;
	assign next_clk_1us = (num1us<6'd20) ? 1'd0 : 1'd1;
endmodule



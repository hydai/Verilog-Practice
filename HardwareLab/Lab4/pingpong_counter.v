`timescale 1ns / 10ps
module pingpong_counter(rst_n, clk, en, dir, out);
	output [3:0]out;
	output dir;
	input clk, rst_n, en;
	wire [3:0]tmp;
	wire isUp;

	dff_1bit DFF2( dir, clk, rst_n, isUp);
	dff_4bit DFF1( out, clk, rst_n, tmp );
	assign isUp =(!en)?(dir):
					 (dir)?((out == 0)?(!dir):(dir)):
					 (out == 9)?(!dir):(dir);
					 
	assign tmp = (!en)?(out):
					 (isUp)?(out-1):(out+1);
endmodule

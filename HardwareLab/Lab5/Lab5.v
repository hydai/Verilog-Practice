`timescale 1ns / 1ps

module lab5(DIGIT, DISPLAY, max, min, clk, reset, speed, row, column);
input clk; // clock signal 
input reset; //When mode set to 1, reset to 99, otherwise set to 60
input speed; //1 to perform the counting at a higher speed, clk/2^22, 
				//and 0 to perform the counting at a lower speed, clk/2^24
input [3:0] column;
output [3:0] row;
output [3:0] DIGIT;
output [7:0] DISPLAY;
output max; //1 if the counter reaches the largest number 99 or 60
output min; //1 if the counter reaches the smallest number 00

wire clk24, clk22, clk15, clk_selected;
wire DB_rst;
wire [3:0] BCD1, BCD0;
wire [3:0] KB1, KB0;

//Fill in the modules
clock_divisor CD(clk24, clk22, clk15, clk);
debounce resDB(DB_rst, reset, clk15);
KeyBoard_ctrl kbSeg(clk, DB_rst, row, column, KB1, KB0);
pingpong_counter PC(max, min, BCD1, BCD0, KB1, KB0, clk_selected, DB_rst );
LED7SEG SevenSeg(DIGIT, DISPLAY, BCD0, BCD1, KB0, KB1, clk15);

assign clk_selected = (speed==0) ? clk24 : clk22 ;

endmodule


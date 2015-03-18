`timescale 1ns / 1ps
module Lab7(LCD_ENABLE, LCD_RW, LCD_DI, LCD_CS1, LCD_CS2, LCD_RST, LCD_DATA, clk, reset, startStop, Pause);

	input clk;
	input reset;
	input startStop, Pause;
	output LCD_ENABLE;
	output LCD_RW;
	output LCD_DI;
	output LCD_CS1;
	output LCD_CS2;
	output LCD_RST;
	output [7:0] LCD_DATA;
	
	wire reset_db;
	wire startStop_db, Pause_db;
	wire [1:0] state;
	wire [0:255] pattern;
	wire clk_LCD;
	wire clk8, clk16;
	
	clock_divider cd(clk16,clk8,clk);
	clock_generator_LCD CLK_GEN (clk,reset,clk_LCD);
	 
	debounce db0(reset_db, reset, clk16);
	debounce db1(startStop_db, startStop, clk16);
	debounce db2(Pause_db, Pause, clk16);
	display_ctrl gen_pattern(pattern, reset_db, clk_LCD, startStop_db, Pause_db);
	LCD_display lcd(LCD_ENABLE,LCD_RW,LCD_DI,LCD_CS1,LCD_CS2,LCD_RST,LCD_DATA,pattern,reset_db,clk8);

endmodule

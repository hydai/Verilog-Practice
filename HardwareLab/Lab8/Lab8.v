`timescale 1ns / 1ps
module Lab8(LCD_ENABLE, LCD_RW, LCD_DI, LCD_CS1, LCD_CS2, LCD_RST, LCD_DATA, ROW, DIGIT, DISPLAY, COLUMN, rst_n, clk);

	input  clk, rst_n;
	input  [3:0] COLUMN;

	output LCD_ENABLE, LCD_RW, LCD_DI, LCD_CS1, LCD_CS2, LCD_RST;
	output [7:0] LCD_DATA;
	output [3:0] ROW;
	output [3:0] DIGIT;
	output [7:0] DISPLAY;

	
	wire clk_LCD, clk_7seg, clk_1s, clk_500ms, clk_1us;
	wire rst_n_db, rst_n_1p;
	
	wire [3:0] random;
	wire [3:0] mallet_position;
	wire [4:0] mole_position;	//1 bit for "no mole to show"
	wire [15:0] mole16bit;
	
	wire [3:0] BCD3, BCD2, BCD1, BCD0;
	wire [255:0] PATTERN;
	wire CLEAR, CALLFORPATTERN;
	wire PRESS_VALID;
	
	// pre hanlding
	CLK_DIV CD1(clk_LCD, clk_7seg, clk_1s, clk_500ms, clk_1us, clk);
	DEBOUNCE DB1(rst_n_db, rst_n, clk);
	ONE_PULSE OP1(rst_n_1p, rst_n_db, clk);
	
	
	// implement the "radom" function
	LFSR LFSR1(random, rst_n_1p, clk_1us);
	
	// implement the countdown clock
	Timer T1(BCD3, BCD2, timesup, rst_n_1p, clk_1s);
	
	KEYBOARD KB1(ROW, mallet_position, PRESS_VALID, COLUMN, rst_n_1p, clk_1us, clk);
	
	// main function of this lab
	WhacAMole WAM1(BCD1, BCD0, mole_position, random, mallet_position, timesup, PRESS_VALID, rst_n_1p, clk_1us);

	// mole decoding for displaying
	MoleDecoder MD1(mole16bit, mole_position);
	
	
	LED7SEG L7S1(DIGIT, DISPLAY, BCD3, BCD2, BCD1, BCD0, clk_7seg);
	
	LCD_DISPLAY_CTRL LCDDC1(PATTERN, CLEAR, CALLFORPATTERN, mole16bit, rst_n_1p, clk_LCD);
	LCD_DISPLAY LCDD1(LCD_ENABLE, LCD_RW, LCD_DI, LCD_CS1, LCD_CS2, LCD_RST, LCD_DATA, CLEAR, CALLFORPATTERN, PATTERN, rst_n_1p, clk_LCD);
	
endmodule

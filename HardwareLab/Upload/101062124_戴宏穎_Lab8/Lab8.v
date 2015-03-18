`timescale 1ns / 1ps
module Lab8(LCD_ENABLE, LCD_RW, LCD_DI, LCD_CS1, LCD_CS2, LCD_RST, LCD_DATA, rst_n, clk, DIGIT, DISPLAY, ROW, COLUMN);

	input  clk, rst_n;
	output [3:0] DIGIT;
	output [8:0] DISPLAY;
	output [3:0] ROW;
	input [3:0] COLUMN;
	output LCD_ENABLE, LCD_RW, LCD_DI, LCD_CS1, LCD_CS2, LCD_RST;
	output [7:0] LCD_DATA;
	
	wire clk_LCD, clk_7seg, clk_1s, clk_500ms, clk_1us;
	wire [15:0] mole16bit;

	wire [255:0] PATTERN;
	wire CLEAR, CALLFORPATTERN;
	wire PRESS_VALID;
	
	wire db_rst_n;
	wire [3:0]TTen, TOne, STen, SOne, KEY_IN;
	
	wire isFinished;
	Timer timer(
		TTen,
		TOne,
		isFinished,
		clk_1s,
		db_rst_n
    );

	CLK_DIV CD1(clk_LCD, clk_7seg, clk_1s, clk_500ms, clk_1us, clk);
	debounce db(db_rst_n, rst_n, clk);
	KeyBoard_ctrl kbc(ROW, KEY_IN, COLUMN, clk, rst_n);
	LED7SEG led (DIGIT, DISPLAY, TTen, TOne, STen, SOne, 0, 0, 0, clk_7seg);
	LCD_DISPLAY_CTRL LCDDC1(PATTERN, CLEAR, CALLFORPATTERN, mole16bit, rst_n, clk_LCD);
	LCD_DISPLAY LCDD1(LCD_ENABLE, LCD_RW, LCD_DI, LCD_CS1, LCD_CS2, LCD_RST, LCD_DATA, CLEAR, CALLFORPATTERN, PATTERN, rst_n, clk_LCD);
	
	GameCtr gtr(
			STen,
			SOne,
			mole16bit,
			KEY_IN,
			PRESS_VALID,
			isFinished,
			clk_1s,
			clk_1us,
			db_rst_n
    );

endmodule

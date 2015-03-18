module LCD_display(LCD_ENABLE, LCD_RW, LCD_DI, LCD_CS1, LCD_CS2, LCD_RST, LCD_DATA, display, rst_n, clk);
	input clk;
	input rst_n;
	input [0:255] display;
	output LCD_ENABLE;
	output LCD_RW;
	output LCD_DI;
	output LCD_CS1;
	output LCD_CS2;
	output LCD_RST;
	output [7:0] LCD_DATA;
	reg [7:0] LCD_DATA;
	reg [1:0] LCD_SEL;
	reg [2:0] STATE;
	reg [2:0] X_PAGE;
	reg [1:0] DELAY;
	reg [7:0] INDEX;
	reg [1:0] ENABLE;
	reg CLEAR;
	reg LCD_RW;
	reg LCD_DI;
	reg LCD_RST;
	wire clk;
	wire LCD_CS1;
	wire LCD_CS2;
	wire LCD_ENABLE;
	
	always@(negedge clk or negedge rst_n) begin
		if(!rst_n) begin
			CLEAR <= 1'b1;
			STATE <= 3'b0;
			DELAY <= 2'b00;
			X_PAGE <= 3'o0;
			INDEX = 0;
			LCD_RST<= 1'b0;
			ENABLE <= 2'b00;
			LCD_SEL<= 2'b11;
			LCD_DI <= 1'b0;
			LCD_RW <= 1'b0;
		end
		else begin
			if(ENABLE < 2'b10) begin
				ENABLE <= ENABLE + 2'b1;
				DELAY[1]<= 1'b1;
			end
			else if(DELAY != 2'b00)
				DELAY <= DELAY - 2'b1;
			else if(STATE == 3'o0) begin
				STATE <= 3'o1;
				LCD_RST <= 1'b1;
				LCD_DATA<= 8'h3F;
				ENABLE <= 2'b00;
			end
			else if(STATE == 3'o1) begin
				/*set up start line*/
				STATE <= 3'o2;
				LCD_DATA<= {2'b11,6'b000000};
				ENABLE <= 2'b00;
			end
			else if(STATE == 3'o2) begin
				/*set Y*/
				STATE <= 3'o3;
				LCD_DATA<= 8'h40;
				ENABLE <= 2'b00;
			end
			else if(STATE == 3'o3) begin
				/*set X*/
				STATE <= 3'o4;
				LCD_DI <= 1'b0;
				INDEX = 0;
				LCD_DATA<= {5'b10111,X_PAGE};
				ENABLE <= 2'b00;
			end
			else if(STATE == 3'o4) begin
				if(CLEAR) begin
					LCD_SEL <= 2'b11;
					if(INDEX < 64) begin
						INDEX = INDEX + 8'h1;
						LCD_DI <= 1'b1;
						LCD_DATA<= 8'h00;
						ENABLE <= 2'b00;
					end
					else if(X_PAGE < 3'o7) begin
						STATE <= 3'o3;
						X_PAGE <= X_PAGE + 3'o1;
					end
					else begin
						STATE <= 3'o3;
						X_PAGE <= 3'o0;
						CLEAR <= 1'b0;
					end
				end
				else begin
					LCD_SEL <= 2'b01;
					if(INDEX < 64) begin
						LCD_DI <= 1'b1;
						
						if(display[((X_PAGE<<1)<<4) + (INDEX>>2)] == 1'b1)
							LCD_DATA[3:0] <= 4'hF;
						else
							LCD_DATA[3:0] <= 4'h0;
						
						if(display[(((X_PAGE<<1)+1)<<4) + (INDEX>>2)] == 1'b1)
							LCD_DATA[7:4] <= 4'hF;
						else
							LCD_DATA[7:4] <= 4'h0;
						INDEX = INDEX + 8'h1;
						ENABLE<= 2'b00;
					end
					else begin
						LCD_SEL <= 2'b11;
						STATE <= 3'o3;
						X_PAGE <= X_PAGE + 3'o1;
					end
				end
			end 
		end
	end
	assign LCD_ENABLE = ENABLE[0];
	assign LCD_CS1 = LCD_SEL[0];
	assign LCD_CS2 = LCD_SEL[1];

endmodule

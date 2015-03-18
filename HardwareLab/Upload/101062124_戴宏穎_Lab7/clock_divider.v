
module clock_divider(clk16, clk8, clk);
	
	input clk;
	output clk8;
	output clk16;
	
	reg [24:0] num;
	wire [24:0] next_num;
	
	always@(posedge clk)
		num <= next_num;
	
	assign next_num = num + 25'b1;
	
	assign clk8 = num[7];
	assign clk16 = num[15];

endmodule

module clock_generator_LCD (clk, rst, clk_LCD);
	
	input      clk;
	input      rst;
	output     clk_LCD;
	
	reg        clk_LCD;
	reg        clk_LCD_next;
	reg [24:0] clk_cnt;
	reg [24:0] clk_cnt_next;
 
	always @(posedge clk or negedge rst) begin
		if (rst == 1'b0) begin
			clk_LCD = 1'b0;
			clk_cnt = 25'd0;
		end 
		else begin
			clk_LCD = clk_LCD_next;
			clk_cnt = clk_cnt_next;
		end
	end

	always @(*) begin
		if (clk_cnt == 25'd4999999) begin
			clk_LCD_next = ~clk_LCD;
			clk_cnt_next = 25'd0;
		end
		else begin
			clk_LCD_next = clk_LCD;
			clk_cnt_next = clk_cnt + 1'b1;
		end
	end
	
endmodule

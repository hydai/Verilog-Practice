`timescale 1ns / 10ps
module bcd_counter(reset, clk, en, co, out);
	output [3:0]out;
	output co;
	input clk, reset, en;
	reg [3:0]out;
	reg co;
	wire [3:0]tmp_out;
	initial begin
		co <= 0;
	end
	
	always @ (posedge clk or negedge reset) begin
		if (!reset) begin
			co <= 0;
			out <= 0;
		end
		else if (tmp_out == 10) begin
			out <= 0;
			co <= 0;
		end
		else if (tmp_out == 9) begin
			co <= 1;
			out <= tmp_out;
		end
		else begin
			out <= tmp_out;
		end
	end
	assign tmp_out = (en)?(out + 1):(out);
	/*
	initial begin
		co <= 0;
	end
	
	always @ (posedge clk) begin
		if (!reset) begin
			co <= 1'b0;
			out <= 4'b0000;
		end //end of if (!reset)
		else if (en) begin
			out <= out + 4'b0001;
		end //end of else if (en)
		
		if (out == 4'b1000) begin
			co <= 1'b1;
		end //end of if (out == 8)
		else begin
			if (out == 4'b1001) begin
				out <= 1'b0;
			end //end of if (out == 9)
			co <= 1'b0;
		end //end of else
	end //end of always
	*/
endmodule

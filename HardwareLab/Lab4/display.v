`timescale 1ns / 1ps
module display(clk, rst_n, digit, out);
		
		input clk;
		input rst_n;
		input [15:0]digit;
		output [18:0]out;
		
		wire clk, rst_n;
		wire [15:0]digit;
		reg [18:0]out;
		
		reg [1:0]select;
		reg [1:0]select_nxt;
		
		// modify this section
		parameter d0=15'b0000_0011_1111_111;
		parameter d1=15'b1111_1111_1011_011;
		parameter d2=15'b0110_0101_1101_111;
		parameter d3=15'b0110_1101_1101_101;
		parameter d4=15'b1111_1000_1011_011;
		parameter d5=15'b0110_1001_1111_101;
		parameter d6=15'b1100_0000_1111_111;
		parameter d7=15'b0001_1011_1111_111;
		parameter d8=15'b0110_1111_0100_101;
		parameter d9=15'b0001_1000_1111_111;
		parameter dark=15'b1111_1111_1111_111;
		
		always @*begin
			case(digit[(select*4)+:4])
				4'd0:out[14:0]=d0;
				4'd1:out[14:0]=d1;
				4'd2:out[14:0]=d2;
				4'd3:out[14:0]=d3;
				4'd4:out[14:0]=d4;
				4'd5:out[14:0]=d5;
				4'd6:out[14:0]=d6;
				4'd7:out[14:0]=d7;
				4'd8:out[14:0]=d8;
				4'd9:out[14:0]=d9;
				default:out[14:0]=dark;
			endcase
			case(select)
				2'd0:out[18:15]=4'b1110;
				2'd1:out[18:15]=4'b1101;
				2'd2:out[18:15]=4'b1011;
				2'd3:out[18:15]=4'b0111;
				default:out[18:15]=4'b1111;
			endcase
			select_nxt=select+1;
		end
		always@(posedge clk or negedge rst_n)begin
			if(!rst_n)begin
				select=2'd0;
			end else begin
				select=select_nxt;
			end
		end
			
endmodule

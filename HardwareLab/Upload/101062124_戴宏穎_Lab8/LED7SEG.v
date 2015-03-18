`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    12:58:54 03/17/2011 
// Design Name: 
// Module Name:    LED7SEG 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module LED7SEG(DIGIT, DISPLAY, value_A, value_B, value_result_tens, value_result_units, sign_result, sign_A, sign_B, clk);
	input clk;
	input [3:0] value_A;
	input [3:0] value_B;
	input [3:0] value_result_tens;
	input [3:0] value_result_units;
	input sign_result;
	input sign_A;
	input sign_B;
	
	output reg [3:0] DIGIT;
	output reg [8:0] DISPLAY;

	reg [3:0] value;
	reg sign;

	always @ ( posedge clk ) begin	
		case(DIGIT) 
			4'b0111: begin
				value = value_B;
				sign = sign_B;
				DIGIT <= 4'b1011;
			end
			4'b1011: begin
				value = value_result_tens;
				sign = 0;
				DIGIT <= 4'b1101;
			end
			4'b1101: begin
				value = value_result_units;
				sign = sign_result;
				DIGIT <= 4'b1110;
			end
			4'b1110: begin
				value = value_A;
				sign = sign_A;
				DIGIT <= 4'b0111;
			end
			default begin
				DIGIT <= 4'b0111;
			end
		endcase	
	end

	
	always @(*)begin 
		case (value) 
			4'h0: DISPLAY = { ~sign , 8'b11000000 };
			4'h1: DISPLAY = { ~sign , 8'b11111001 };
			4'h2: DISPLAY = { ~sign , 8'b00100100 };
			4'h3: DISPLAY = { ~sign , 8'b00110000 };
			4'h4: DISPLAY = { ~sign , 8'b00011001 };
			4'h5: DISPLAY = { ~sign , 8'b00010010 };
			4'h6: DISPLAY = { ~sign , 8'b00000010 };
			4'h7: DISPLAY = { ~sign , 8'b11111000 };
			4'h8: DISPLAY = { ~sign , 8'b00000000 };
			4'h9: DISPLAY = { ~sign , 8'b00010000 };
			default:begin
				DISPLAY = 9'b111111111;
			end
		endcase 
	end

endmodule

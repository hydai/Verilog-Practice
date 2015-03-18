`timescale 1ns / 1ps
module MoleDecoder(mole16bit, mole_position);
	input [4:0]mole_position;
	output [15:0]mole16bit;
	
	reg [15:0]mole16bit;
	
	always @( * )begin
		case(mole_position)
			5'd0: mole16bit = 16'b0000_0000_0000_0001;
			5'd1: mole16bit = 16'b0000_0000_0000_0010;
			5'd2: mole16bit = 16'b0000_0000_0000_0100;
			5'd3: mole16bit = 16'b0000_0000_0000_1000;
			5'd4: mole16bit = 16'b0000_0000_0001_0000;
			5'd5: mole16bit = 16'b0000_0000_0010_0000;
			5'd6: mole16bit = 16'b0000_0000_0100_0000;
			5'd7: mole16bit = 16'b0000_0000_1000_0000;
			5'd8: mole16bit = 16'b0000_0001_0000_0000;
			5'd9: mole16bit = 16'b0000_0010_0000_0000;
			5'd10:mole16bit = 16'b0000_0100_0000_0000;
			5'd11:mole16bit = 16'b0000_1000_0000_0000;
			5'd12:mole16bit = 16'b0001_0000_0000_0000;
			5'd13:mole16bit = 16'b0010_0000_0000_0000;
			5'd14:mole16bit = 16'b0100_0000_0000_0000;
			5'd15:mole16bit = 16'b1000_0000_0000_0000;
			default:
				mole16bit = 16'b0000_0000_0000_0000;
		endcase
	end
	
endmodule

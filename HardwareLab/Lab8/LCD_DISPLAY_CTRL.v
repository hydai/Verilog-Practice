`timescale 1ns / 1ps
module LCD_DISPLAY_CTRL(PATTERN, CLEAR, CALLFORPATTERN, mole16bit, reset, clk);

	input clk;
	input reset, CLEAR, CALLFORPATTERN;
	input [15:0] mole16bit;
	output [255:0] PATTERN;
	
	reg [255:0] PATTERN, next_PATTERN;
	reg [4:0] counter, next_counter;
	wire [255:0] MOLE_UPPER_PATTERN, MOLE_LOWER_PATTERN;
	wire [255:0] EDGE_UPPER_PATTERN, EDGE_LOWER_PATTERN;

	always @(negedge clk or negedge reset) begin
		if (!reset) begin
			PATTERN <= 256'd0;
			counter <= 5'd31;
		end else begin
			if(!CLEAR)begin
				PATTERN <= next_PATTERN;
				counter <= next_counter;
			end else begin
				PATTERN <= 256'd0;
				counter <= 5'd31;
			end
			
		end
	end
	
	
	always @(*)begin
		case(counter)
			5'd0 : 	
				if(mole16bit[15]==1)next_PATTERN = MOLE_UPPER_PATTERN;
				else next_PATTERN = EDGE_UPPER_PATTERN;
			5'd2 :  
				if(mole16bit[15]==1)next_PATTERN = MOLE_LOWER_PATTERN;
				else next_PATTERN = EDGE_LOWER_PATTERN;
			5'd1 : 
				if(mole16bit[14]==1)next_PATTERN = MOLE_UPPER_PATTERN;
				else next_PATTERN = EDGE_UPPER_PATTERN;
			5'd3 :  
				if(mole16bit[14]==1)next_PATTERN = MOLE_LOWER_PATTERN;
				else next_PATTERN = EDGE_LOWER_PATTERN;
			5'd4 :  
				if(mole16bit[11]==1)next_PATTERN = MOLE_UPPER_PATTERN;
				else next_PATTERN = EDGE_UPPER_PATTERN;
			5'd6 :  
				if(mole16bit[11]==1)next_PATTERN = MOLE_LOWER_PATTERN;
				else next_PATTERN = EDGE_LOWER_PATTERN;
			5'd5 :  
				if(mole16bit[3]==1)next_PATTERN = MOLE_UPPER_PATTERN;
				else next_PATTERN = EDGE_UPPER_PATTERN;	
			5'd7 :  
				if(mole16bit[3]==1)next_PATTERN = MOLE_LOWER_PATTERN;
				else next_PATTERN = EDGE_LOWER_PATTERN;
			5'd8 :  
				if(mole16bit[10]==1)next_PATTERN = MOLE_UPPER_PATTERN;
				else next_PATTERN = EDGE_UPPER_PATTERN;
			5'd10:  
				if(mole16bit[10]==1)next_PATTERN = MOLE_LOWER_PATTERN;
				else next_PATTERN = EDGE_LOWER_PATTERN;
			5'd9 :  
				if(mole16bit[2]==1)next_PATTERN = MOLE_UPPER_PATTERN;
				else next_PATTERN = EDGE_UPPER_PATTERN;
			5'd11:  
				if(mole16bit[2]==1)next_PATTERN = MOLE_LOWER_PATTERN;
				else next_PATTERN = EDGE_LOWER_PATTERN;
			5'd12:  
				if(mole16bit[0]==1)next_PATTERN = MOLE_UPPER_PATTERN;
				else next_PATTERN = EDGE_UPPER_PATTERN;
			5'd14:	
				if(mole16bit[0]==1)next_PATTERN = MOLE_LOWER_PATTERN;
				else next_PATTERN = EDGE_LOWER_PATTERN;
			5'd13:  
				if(mole16bit[1]==1)next_PATTERN = MOLE_UPPER_PATTERN;
				else next_PATTERN = EDGE_UPPER_PATTERN;
			5'd15:	
				if(mole16bit[1]==1)next_PATTERN = MOLE_LOWER_PATTERN;
				else next_PATTERN = EDGE_LOWER_PATTERN;
			5'd16:  
				if(mole16bit[13]==1)next_PATTERN = MOLE_UPPER_PATTERN;
				else next_PATTERN = EDGE_UPPER_PATTERN;
			5'd18:	
				if(mole16bit[13]==1)next_PATTERN = MOLE_LOWER_PATTERN;
				else next_PATTERN = EDGE_LOWER_PATTERN;
			5'd17:  
				if(mole16bit[12]==1)next_PATTERN = MOLE_UPPER_PATTERN;
				else next_PATTERN = EDGE_UPPER_PATTERN;
			5'd19:	
				if(mole16bit[12]==1)next_PATTERN = MOLE_LOWER_PATTERN;
				else next_PATTERN = EDGE_LOWER_PATTERN;
			5'd20:  
				if(mole16bit[6]==1)next_PATTERN = MOLE_UPPER_PATTERN;
				else next_PATTERN = EDGE_UPPER_PATTERN;
			5'd22:	
				if(mole16bit[6]==1)next_PATTERN = MOLE_LOWER_PATTERN;
				else next_PATTERN = EDGE_LOWER_PATTERN;
			5'd21:  
				if(mole16bit[9]==1)next_PATTERN = MOLE_UPPER_PATTERN;
				else next_PATTERN = EDGE_UPPER_PATTERN;
			5'd23:	
				if(mole16bit[9]==1)next_PATTERN = MOLE_LOWER_PATTERN;
				else next_PATTERN = EDGE_LOWER_PATTERN;
			5'd24:  
				if(mole16bit[5]==1)next_PATTERN = MOLE_UPPER_PATTERN;
				else next_PATTERN = EDGE_UPPER_PATTERN;
			5'd26:	
				if(mole16bit[5]==1)next_PATTERN = MOLE_LOWER_PATTERN;
				else next_PATTERN = EDGE_LOWER_PATTERN;
			5'd25:  
				if(mole16bit[8]==1)next_PATTERN = MOLE_UPPER_PATTERN;
				else next_PATTERN = EDGE_UPPER_PATTERN;
			5'd27:	
				if(mole16bit[8]==1)next_PATTERN = MOLE_LOWER_PATTERN;
				else next_PATTERN = EDGE_LOWER_PATTERN;
			5'd28:  
				if(mole16bit[4]==1)next_PATTERN = MOLE_UPPER_PATTERN;
				else next_PATTERN = EDGE_UPPER_PATTERN;
			5'd30:	
				if(mole16bit[4]==1)next_PATTERN = MOLE_LOWER_PATTERN;
				else next_PATTERN = EDGE_LOWER_PATTERN;
			5'd29:  
				if(mole16bit[7]==1)next_PATTERN = MOLE_UPPER_PATTERN;
				else next_PATTERN = EDGE_UPPER_PATTERN;
			5'd31:	
				if(mole16bit[7]==1)next_PATTERN = MOLE_LOWER_PATTERN;
				else next_PATTERN = EDGE_LOWER_PATTERN;
			default:
				next_PATTERN = PATTERN;
		endcase
	end
	
	always @( * )begin
		if(CALLFORPATTERN) next_counter = counter + 5'd1;
		else next_counter = counter;
	end
	
	assign MOLE_UPPER_PATTERN[255:0] = 256'hFF01_0101_0101_0101_8141_2111_0905_0303_0303_0305_0911_2141_8101_0101_0101_01FF;
	assign MOLE_LOWER_PATTERN[255:0] = 256'hFF80_8080_8080_8080_8182_8488_90A0_C0C0_C0C0_C0A0_9088_8482_8180_8080_8080_80FF;
	assign EDGE_UPPER_PATTERN[255:0] = 256'hFF01_0101_0101_0101_0101_0101_0101_0101_0101_0101_0101_0101_0101_0101_0101_01FF;
	assign EDGE_LOWER_PATTERN[255:0] = 256'hFF80_8080_8080_8080_8080_8080_8080_8080_8080_8080_8080_8080_8080_8080_8080_80FF;

endmodule

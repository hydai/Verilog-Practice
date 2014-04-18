`timescale 1ns / 1ps

module LED7SEG(DIGIT, DISPLAY,BCD0, BCD1, KB0, KB1, clk);
input clk;
input [3:0] BCD1;
input [3:0] BCD0;
input [3:0] KB1;
input [3:0] KB0;
output reg [3:0] DIGIT;
output [7:0] DISPLAY;
reg [3:0] value;

	always @ ( posedge clk) begin	
		case(DIGIT) 
			4'b0111: begin
				value <= BCD1;
				DIGIT <= 4'b1011;
			end
			4'b1011: begin // L2
				value <= KB0;
				DIGIT <= 4'b1101;
			end
			4'b1101: begin // L1
				value <= KB1;
				DIGIT <= 4'b1110;
			end
			4'b1110: begin
				value <= BCD0; // L4
				DIGIT <= 4'b0111;
			end
			default begin
				DIGIT <= 4'b0111;
			end
		endcase	
	end

	assign DISPLAY = (value==4'h0) ? 8'hC0 :
                 (value==4'h1) ? 8'hF9 :
                 (value==4'h2) ? 8'h24 :
                 (value==4'h3) ? 8'h30 :
                 (value==4'h4) ? 8'h19 :
                 (value==4'h5) ? 8'h12 :
                 (value==4'h6) ? 8'h02 :
                 (value==4'h7) ? 8'hF8 :
                 (value==4'h8) ? 8'h00 :
                 (value==4'h9) ? 8'h10 : 8'hFF ;

endmodule

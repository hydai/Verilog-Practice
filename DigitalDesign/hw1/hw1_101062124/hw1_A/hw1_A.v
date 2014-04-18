//-----------------------------------------------------
// Design Name : hw1_A
// File Name : hw1_A.v
// Function : This program designs a single mux-based bus.
// Coder    : hydai
//-----------------------------------------------------

module hw1_A (
	input [15:0] data,
	input [6:0] control,
	input clk,
	input rst_n,
	output reg [15:0] R0,
	output reg [15:0] R1,
	output reg [15:0] R2,
	output reg [15:0] R3
);

reg [15:0] tmpData;
reg [15:0] T0, T1, T2, T3;
always @(posedge clk or negedge rst_n) begin
	if (!rst_n) begin
		R0 <= 0;
		R1 <= 0;
		R2 <= 0;
		R3 <= 0;
	end else begin
		R0 <= (control[0])?(tmpData):R0;
		R1 <= (control[1])?(tmpData):R1;
		R2 <= (control[2])?(tmpData):R2;
		R3 <= (control[3])?(tmpData):R3;
	end // end of if-else block
end // end of always

always @(posedge clk or negedge rst_n) begin
	if (!rst_n) begin
		tmpData <= 0;
	end // end of if (!rst_n)

	case (control[6:4]) 
		3'b000:		tmpData <= R0;
		3'b001:		tmpData <= R1;
		3'b010:		tmpData <= R2;
		3'b011:		tmpData <= R3;
		3'b111:		tmpData <= data;
		default:	tmpData <= 0;
	endcase // end of case (control)
	
end // end of always

endmodule // endmodule of hw1_A

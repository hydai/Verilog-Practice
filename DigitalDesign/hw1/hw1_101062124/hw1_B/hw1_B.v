//-----------------------------------------------------
// Design Name : hw1_B
// File Name : hw1_B.v
// Function : Dedicated MUX-Based Transfer
// Coder    : hydai
//-----------------------------------------------------

module hw1_B (
				input [15:0] data,
				input [15:0] control,
				input clk,
				input rst_n,
				output reg [15:0] R0,
				output reg [15:0] R1,
				output reg [15:0] R2,
				output reg [15:0] R3
			 );

wire [15:0] T0, T1, T2, T3;

always @(posedge clk or negedge rst_n) begin
	if (!rst_n) begin
		R0 <= 0;
		R1 <= 0;
		R2 <= 0;
		R3 <= 0;
	end else begin
		R0 <= (control[0])?(T0):(R0);
		R1 <= (control[1])?(T1):(R1);
		R2 <= (control[2])?(T2):(R2);
		R3 <= (control[3])?(T3):(R3);
	end // end of if-else block
end

assign T0 = (!rst_n)?(0):
			(control[15:13] == 3'b000)?(R1):
			(control[15:13] == 3'b001)?(R2):
			(control[15:13] == 3'b010)?(R3):
			(control[15:13] == 3'b011)?(data):
			(0);
assign T1 = (!rst_n)?(0):
			(control[12:10] == 3'b000)?(R0):
			(control[12:10] == 3'b001)?(R2):
			(control[12:10] == 3'b010)?(R3):
			(control[12:10] == 3'b011)?(data):
			(0);
assign T2 = (!rst_n)?(0):
			(control[9:7] == 3'b000)?(R0):
			(control[9:7] == 3'b001)?(R1):
			(control[9:7] == 3'b010)?(R2):
			(control[9:7] == 3'b011)?(data):
			(0);
assign T3 = (!rst_n)?(0):
			(control[6:4] == 3'b000)?(R0):
			(control[6:4] == 3'b001)?(R1):
			(control[6:4] == 3'b010)?(R2):
			(control[6:4] == 3'b011)?(data):
			(0);
endmodule

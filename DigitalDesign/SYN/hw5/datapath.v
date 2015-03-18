//-----------------------------------------------------
// Design Name : datapath
// File Name : datapath.v
// Function : This program designs an One-Pulse Generator.
// Coder    : hydai
//-----------------------------------------------------
module datapath (
				output reg V,
				output reg C,
				output reg N,
				output reg Z,
				output [15:0] R0,
				output [15:0] R1,
				output [15:0] R2,
				output [15:0] R3,
				output [15:0] R4,
				output [15:0] R5,
				output [15:0] R6,
				output [15:0] R7,
				output [15:0] R8,
				output [15:0] R9,
				output [15:0] R10,
				output [15:0] R11,
				output [15:0] R12,
				output [15:0] R13,
				output [15:0] R14,
				output [15:0] R15,
				output reg [15:0] BUSA,
				output reg [15:0] BUSB,
				input [25:0] control,
				input [15:0] constant,
				input [15:0] data,
				input clk,
				input rst_n
			 );
			 
reg [15:0] R [0:15];
reg [15:0] BUSD;
wire [3:0] DA, AA, BA, FS, SA;
wire [2:0] SS;
wire MB, MD, RW;
reg [15:0] MUXB, FUResult;
reg [15:0] tmp16bit, tmp16bit1, tmp16bit2;
// get all signal
assign {DA, AA, BA, MB, FS, SS, SA, MD, RW} = control;
assign R0 = R[0];
assign R1 = R[1];
assign R2 = R[2];
assign R3 = R[3];
assign R4 = R[4];
assign R5 = R[5];
assign R6 = R[6];
assign R7 = R[7];
assign R8 = R[8];
assign R9 = R[9];
assign R10 = R[10];
assign R11 = R[11];
assign R12 = R[12];
assign R13 = R[13];
assign R14 = R[14];
assign R15 = R[15];

// Register files
always @(posedge clk or negedge rst_n) begin
	if (!rst_n) begin
		R[0] <= 0;
		R[1] <= 0;
		R[2] <= 0;
		R[3] <= 0;
		R[4] <= 0;
		R[5] <= 0;
		R[6] <= 0;
		R[7] <= 0;
		R[8] <= 0;
		R[9] <= 0;
		R[10] <= 0;
		R[11] <= 0;
		R[12] <= 0;
		R[13] <= 0;
		R[14] <= 0;
		R[15] <= 0;
	end else begin
		if (RW) begin
			R[DA] <= BUSD;
		end else begin
			R[DA] <= R[DA];
		end
	end // end of if-else block
end // end of always

// MUX B
always @(*) begin
	if (MB) begin
		MUXB <= constant;
	end else begin
		MUXB <= R[BA];
	end
end

// BUS A
always @(*) begin
	BUSA <= R[AA];
end

// MUX D
always @(*) begin
	if (MD) begin
		BUSD <= data;
	end else begin
		BUSD <= FUResult;
	end
end

// Barrel shifter
always @(*) begin
	tmp16bit <= 0;
	tmp16bit1 <= 0;
	case(SS)
		// B >> (SA) bits
		3'b000: begin
			BUSB <= MUXB >> SA;
		end
		// B << (SA) bits
		3'b001: begin
			BUSB <= MUXB << SA;
		end
		// B right rotating by (SA) bits
		3'b010: begin
			if (SA == 0) begin
				BUSB <= MUXB;
			end else begin
				tmp16bit <= MUXB >> SA;
				tmp16bit1 <= MUXB << (16 - SA);
				BUSB <= tmp16bit | tmp16bit1;
			end
		end
		// B left rotating by (SA) bits
		3'b011: begin
			if (SA == 0) begin
				BUSB <= MUXB;
			end else begin
				tmp16bit <= MUXB << SA;
				tmp16bit1 <= MUXB >> (16 - SA);
				BUSB <= tmp16bit | tmp16bit1;
			end
		end
		// B arithmetic-right-shift by (SA) bits
		3'b100: begin
			BUSB <= $signed(MUXB) >>> SA;
		end
		// Other cases
		default: begin
			BUSB <= MUXB;
		end
	endcase
end

// Function Unit
always @(*) begin
	C <= 0;
	V <= 0;
	tmp16bit2 <= 0;
	case (FS)
		// F <- A
		4'b0000: begin
			FUResult <= BUSA;
		end
		// F <- A+1
		4'b0001: begin
			{C, FUResult} <= BUSA + 1'b1;
			if (BUSA[15] == FUResult[15]) begin
				V <= 0;
			end else begin
				V <= 1;
			end
		end
		// F <- A+B
		4'b0010: begin
			{C, FUResult} <= BUSA + BUSB;
			if (BUSA[15] == BUSB[15]) begin
				if (FUResult[15] == BUSA[15]) begin
					V <= 0;
				end else begin
					V <= 1;
				end
			end else begin
				V <= 0;
			end
		end
		// F <- A+B+1
		4'b0011: begin
			{C, FUResult} <= BUSA + BUSB + 2'b01;
			if (BUSA[15] == BUSB[15]) begin
				if (FUResult[15] == BUSA[15]) begin
					V <= 0;
				end else begin
					V <= 1;
				end
			end else begin
				V <= 0;
			end
		end
		// F <= A + ~B
		4'b0100: begin
			tmp16bit2 <= ~BUSB;
			{C, FUResult} <= BUSA + tmp16bit2;
			if (BUSA[15] == tmp16bit2[15]) begin
				if (FUResult[15] == BUSA[15]) begin
					V <= 0;
				end else begin
					V <= 1;
				end
			end else begin
				V <= 0;
			end
		end
		// F <= A + !B + 1
		4'b0101: begin
			tmp16bit2 <= ~BUSB;
			{C, FUResult} <= BUSA + tmp16bit2 + 2'b01;
			if (BUSA[15] == tmp16bit2[15]) begin
				if (FUResult[15] == BUSA[15]) begin
					V <= 0;
				end else begin
					V <= 1;
				end
			end else begin
				V <= 0;
			end
		end
		// F <= A - 1
		4'b0110: begin
			{C, FUResult} <= BUSA + 16'hffff;
			if (BUSA[15] == FUResult[15]) begin
				V <= 0;
			end else begin
				V <= 1;
			end
		end
		// F <= A
		4'b0111: begin
			FUResult <= BUSA;
		end
		// F <= A AND B
		4'b1000: begin
			FUResult <= BUSA & BUSB;
		end
		// F <= A OR B
		4'b1001: begin
			FUResult <= BUSA | BUSB;
		end
		// F <= A XOR B
		4'b1010: begin
			FUResult <= BUSA ^ BUSB;
		end
		// F <= !A
		4'b1011: begin
			FUResult <= ~BUSA;
		end
		4'b1100: begin
			FUResult <= BUSB;
		end
		default: begin
			FUResult <= 0;
		end
	endcase
end

// Detect Negtive
always @(*) begin
	if (FUResult[15] == 1) begin
		N <= 1;
	end else begin
		N <= 0;
	end
end
// Detect Zero
always @(*) begin
	if (FUResult == 0) begin
		Z <= 1;
	end else begin
		Z <= 0;
	end
end

endmodule // endmodule of datapath

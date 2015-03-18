//-----------------------------------------------------
// Design Name : datapath
// File Name : datapath.v
// Function : This program designs an One-Pulse Generator.
// Coder    : hydai
//-----------------------------------------------------
module datapath (
				output reg [291:0] snapshot,
				input [25:0] control,
				input [15:0] constant,
				input [15:0] data,
				input clk,
				input rst_n
			 );
			 
reg [15:0] R [0:15];
reg [15:0] BUSD, BUSB, BUSA;
reg [3:0] DA, AA, BA, FS, SS;
reg [2:0] SA;
reg MB, MD, RW, V, C, N, Z;
reg [15:0] MUXB, FUResult;
reg [15:0] tmp16bit, tmp16bit1, tmp16bit2;
// get all signal
assign {DA, AA, BA, MB, FS, SS, SA, MD, RW} = control;

// Register files
always @(posedge clk or negedge rst_n) begin
	if (!rst_n) begin
		for (integer i = 0; i < 16; i = i + 1) begin
			R[i] <= 0;
		end
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
	if (!rst_n) begin
		BUSA <= 0;
	end else begin
		BUSA <= R[AA];
	end
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
	if (!rst_n) begin
		BUSB <= 0;
	end else begin
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
				tmp16bit1 <= MUXB << (15 - SA);
				BUSB <= tmp16bit | tmp16bit1;
			end
		end
		// B left rotating by (SA) bits
		3'b011: begin
			if (SA == 0) begin
				BUSB <= MUXB;
			end else begin
				tmp16bit <= MUXB << SA;
				tmp16bit1 <= MUXB >> (15 - SA);
				BUSB <= tmp16bit | tmp16bit1;
			end
		end
		// B arithmetic-right-shift by (SA) bits
		3'b100: begin
			BUSB <= MUXB >>> SA;
		end
		// Other cases
		default: begin
			BUSB <= MUXB;
		end
	endcase
	end
end

// Function Unit
always @(*) begin
/*
	if (!rst_n) begin
		C <= 0;
		V <= 0;
	end else begin
	*/
		C <= 0;
		V <= 0;
	//end
	case (FS)
		// F <- A
		4'b0000: begin
			FUResult <= BUSA;
		end
		// F <- A+1
		4'b0001: begin
			{C, FUResult} <= BUSA + 1;
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
			{C, FUResult} <= BUSA + BUSB + 1;
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
		// F <= A + !B
		4'b0100: begin
			tmp16bit <= ~BUSB;
			{C, FUResult} <= BUSA + tmp16bit;
			if (BUSA[15] == tmp16bit[15]) begin
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
			tmp16bit <= ~BUSB;
			{C, FUResult} <= BUSA + tmp16bit + 1;
			if (BUSA[15] == tmp16bit[15]) begin
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
			{C, FUResult} <= BUSA - 1;
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
	if (!rst_n) begin
		N <= 0;
	end else begin
		if (FUResult[15] == 1) begin
			N <= 1;
		end else begin
			N <= 0;
		end
	end
end
// Detect Zero
always @(*) begin
	if (!rst_n) begin
		Z <= 0;
	end else begin
		if (FUResult == 0) begin
			Z <= 1;
		end else begin
			Z <= 0;
		end
	end
end

// Deal with output
assign snapshot = {V, C, N, Z, R[0], R[1], R[2], R[3], R[4], R[5], R[6], R[7], R[8], R[9], R[10], R[11], R[12], R[13], R[14], R[15], BUSA, BUSB};
endmodule // endmodule of datapath

//-----------------------------------------------------
// Design Name : hw3_t
// File Name : hw3_t.v
// Function : This program will test datapath.v
// Coder    : hydai
//-----------------------------------------------------
`timescale 1 ns/10 ps
`define TESTSIZE 44
`define STRINGIFY(x) `"x`"
`define PATTERN pattern1.dat
`define GOLDEN golden1.dat
`define SNAPSHOT dump1.dat
`define CLOCK_CYCLE 10
`define HALF_CYCLE 5
module hw3_t ;
reg [57:0] test_vector [`TESTSIZE-1:0];
reg [291:0] test_response [`TESTSIZE-1:0];
reg [25:0] control;
reg [15:0] constant;
reg [15:0] data;
reg clk, rst_n;
reg V, C, N, Z;
reg [15:0] R0;
reg [15:0] R1;
reg [15:0] R2;
reg [15:0] R3;
reg [15:0] R4;
reg [15:0] R5;
reg [15:0] R6;
reg [15:0] R7;
reg [15:0] R8;
reg [15:0] R9;
reg [15:0] R10;
reg [15:0] R11;
reg [15:0] R12;
reg [15:0] R13;
reg [15:0] R14;
reg [15:0] R15;
reg [15:0] BUSA;
reg [15:0] BUSB;
wire [291:0] snapshot;
integer error, snapshotPT, descPT, i;
reg cmp;

datapath golden(
				snapshot,
				control,
				constant,
				data,
				clk,
				rst_n,
			   );


always begin
	#`CLOCK_CYCLE clk = ~clk;
end

task simulation;
	input [57:0] instr;
	begin
		#(`HALF_CYCLE) assign {control, constant, data} = instr;
		#(`HALF_CYCLE)
		#(`CLOCK_CYCLE)
		$display("i = %d", i);
	end
endtask

initial begin
	$fsdbDumpfile("hw3_t.fsdb");
	$fsdbDumpvars;
end

initial begin
	#0 clk = 0; rst_n = 0; constant = 0; control = 0; data = 0;
	#20 rst_n = 1;
	$readmemb(`STRINGIFY(`PATTERN), test_vector);
	$readmemb(`STRINGIFY(`GOLDEN), test_response);
	snapshotPT = $fopen(`STRINGIFY(`SNAPSHOT));
	$display("File dump handle in %h", snapshotPT);
	error = 0;
	for (i = 0; i < `TESTSIZE; i++) begin
		simulation(test_vector[i]);
		descPT = snapshotPT;
		assign {V, C, N, Z, R0, R1, R2, R3, R4, R5, R6, R7, R8, R9, R10, R11, R12, R13, R14, R15, BUSA, BUSB} = snapshot;
		$fdisplay(descPT, "%b_%b_%b_%b_%b_%b_%b_%b_%b_%b_%b_%b_%b_%b_%b_%b_%b_%b_%b_%b_%b_%b", V, C, N, Z, R0, R1, R2, R3, R4, R5, R6, R7, R8, R9, R10, R11, R12, R13, R14, R15, BUSA, BUSB);
		cmp = (snapshot == test_response[i])?1:0;
		if (cmp == 0) begin
		error++;
		end
	end
	#10
	if (error == 0) begin
		$display("PASS");
	end else begin
		$display("NOT PASS");
	end
	$fclose(snapshotPT);
	$finish;
end
endmodule // End of Module hw3_t

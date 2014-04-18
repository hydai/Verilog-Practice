//-----------------------------------------------------
// Design Name : hw1_B_testbench
// File Name : hw1_B_testbench.v
// Function : This program will test hw1_B.v
// Coder    : hydai
//-----------------------------------------------------
`timescale 1 ns/1 ns
`include "hw1_B.v"
module hw1_B_testbench ;

reg [15:0] data;
reg [15:0] control;
reg clk, rst_n;
wire [15:0] R0, R1, R2, R3;

hw1_B testB(data, 
			control, 
			clk, 
			rst_n, 
			R0, 
			R1, 
			R2, 
			R3);
			
initial begin
	#0 rst_n = 1'b0; clk = 1'b0; control = 16'h0000;
	$display ("====================================================================");
	$display ("Simulate hw1_B");
	$display ("Time %t status", $time);
	$display ("rst_n = %b\tdata = %h\tcontrol = %b\nR0 = %h\tR1 = %h\tR2 = %h\tR3 = %h",
				rst_n, data, control, R0, R1, R2, R3);
	#20 rst_n = 1'b1;
	$display ("====================================================================");
	$display ("Time %t status", $time);
	$display ("rst_n = %b\tdata = %h\tcontrol = %b\nR0 = %h\tR1 = %h\tR2 = %h\tR3 = %h",
				rst_n, data, control, R0, R1, R2, R3);
	// R0 <- 0x0101
	#20 data = 16'h0101; control = 16'b011_111_111_111_0001;
	$display ("====================================================================");
	$display ("Time %t status", $time);
	$display ("rst_n = %b\tdata = %h\tcontrol = %b\nR0 = %h\tR1 = %h\tR2 = %h\tR3 = %h",
				rst_n, data, control, R0, R1, R2, R3);
	// R0 <- 0x0202; R1 <- R0
	#20 data = 16'h0202; control = 16'b011_000_111_111_0011;
	$display ("====================================================================");
	$display ("Time %t status", $time);
	$display ("rst_n = %b\tdata = %h\tcontrol = %b\nR0 = %h\tR1 = %h\tR2 = %h\tR3 = %h",
				rst_n, data, control, R0, R1, R2, R3);
	// R0 <- 0x0303, R1 <- R0, R2 <- R1
	#20 data = 16'h0303; control = 16'b011_000_001_111_0111;
	$display ("====================================================================");
	$display ("Time %t status", $time);
	$display ("rst_n = %b\tdata = %h\tcontrol = %b\nR0 = %h\tR1 = %h\tR2 = %h\tR3 = %h",
				rst_n, data, control, R0, R1, R2, R3);
	// R0 <- 0x0404, R1 <- R0, R2 <- R1, R3 <- R2
	#20 data = 16'h0404; control = 16'b011_000_001_010_1111;
	$display ("====================================================================");
	$display ("Time %t status", $time);
	$display ("rst_n = %b\tdata = %h\tcontrol = %b\nR0 = %h\tR1 = %h\tR2 = %h\tR3 = %h",
				rst_n, data, control, R0, R1, R2, R3);
	// R0 <- R3, R1 <- R0, R2 <- R1, R3 <- R2
	#20 control = 16'b010_000_001_010_1111;
	$display ("====================================================================");
	$display ("Time %t status", $time);
	$display ("rst_n = %b\tdata = %h\tcontrol = %b\nR0 = %h\tR1 = %h\tR2 = %h\tR3 = %h",
				rst_n, data, control, R0, R1, R2, R3);
	// R0 <- R3, R1 <- R0, R2 <- R1, R3 <- R2
	#20 control = 16'b010_000_001_010_1111;
	$display ("====================================================================");
	$display ("Time %t status", $time);
	$display ("rst_n = %b\tdata = %h\tcontrol = %b\nR0 = %h\tR1 = %h\tR2 = %h\tR3 = %h",
				rst_n, data, control, R0, R1, R2, R3);
	#20
	$display ("====================================================================");
	$display ("Time %t status", $time);
	$display ("rst_n = %b\tdata = %h\tcontrol = %b\nR0 = %h\tR1 = %h\tR2 = %h\tR3 = %h",
				rst_n, data, control, R0, R1, R2, R3);
	$display ("====================================================================");
	#40 $finish;
end

always begin
	#10 clk = ~clk;
end
initial begin
	$fsdbDumpfile("hw1_B_testbench.fsdb");
	$fsdbDumpvars;
end

endmodule // End of Module hw1_B_testbench

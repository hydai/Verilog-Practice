//-----------------------------------------------------
// Design Name : hw1_B_testbench_A_testcase
// File Name : hw1_B_testbench_A_testcase.v
// Function : This program will test hw1_B.v
// Coder    : hydai
//-----------------------------------------------------
`timescale 1 ns/1 ns
`include "hw1_B.v"
module hw1_B_testbench_A_testcase ;

reg [15:0] data;
reg [15:0] control;
reg clk, rst_n;
wire [15:0] R0, R1, R2, R3;

hw1_B testA(data, 
			control, 
			clk, 
			rst_n, 
			R0, 
			R1, 
			R2, 
			R3);
			
initial begin
	#0 rst_n = 1'b0; clk = 1'b0; control = 16'b111_111_111_0000;
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
	// R1 <- Data(0x1234)
	#20 data = 16'h1234; control = 16'b111_011_111_111_0010;
	$display ("====================================================================");
	$display ("Time %t status", $time);
	$display ("rst_n = %b\tdata = %h\tcontrol = %b\nR0 = %h\tR1 = %h\tR2 = %h\tR3 = %h",
				rst_n, data, control, R0, R1, R2, R3);
	// R2 <- Data(0x8888)
	#20 data = 16'h8888; control = 16'b111_111_011_111_0100;
	$display ("====================================================================");
	$display ("Time %t status", $time);
	$display ("rst_n = %b\tdata = %h\tcontrol = %b\nR0 = %h\tR1 = %h\tR2 = %h\tR3 = %h",
				rst_n, data, control, R0, R1, R2, R3);
	// R1 <- R2; R2 <- R1
	#20 control = 16'b111_001_001_111_0110;
	$display ("====================================================================");
	$display ("Time %t status", $time);
	$display ("rst_n = %b\tdata = %h\tcontrol = %b\nR0 = %h\tR1 = %h\tR2 = %h\tR3 = %h",
				rst_n, data, control, R0, R1, R2, R3);
	// R3 <- R1; R0 <- R1
	#20 control = 16'b000_111_111_001_1001;
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
	$fsdbDumpfile("hw1_B_testbench_A_testcase.fsdb");
	$fsdbDumpvars;
end

endmodule // End of Module hw1_B_testbench_A_testcase

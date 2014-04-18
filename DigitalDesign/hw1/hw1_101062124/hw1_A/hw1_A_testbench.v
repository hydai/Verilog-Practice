//-----------------------------------------------------
// Design Name : hw1_A_testbench
// File Name : hw1_A_testbench.v
// Function : This program will test hw1_A.v
// Coder    : hydai
//-----------------------------------------------------
`timescale 1 ns/1 ns
`include "hw1_A.v"
module hw1_A_testbench ;

reg [15:0] data;
reg [6:0] control;
reg clk, rst_n;
wire [15:0] R0, R1, R2, R3;

hw1_A testA(data, 
			control, 
			clk, 
			rst_n, 
			R0, 
			R1, 
			R2, 
			R3);
			
initial begin
	#0 rst_n = 1'b0; clk = 1'b0;
	$display ("====================================================================");
	$display ("Simulate hw1_A");
	$display ("Time %t status", $time);
	$display ("rst_n = %b\tdata = %h\tcontrol = %b\nR0 = %h\tR1 = %h\tR2 = %h\tR3 = %h",
				rst_n, data, control, R0, R1, R2, R3);
	#20 rst_n = 1'b1;
	$display ("====================================================================");
	$display ("Time %t status", $time);
	$display ("rst_n = %b\tdata = %h\tcontrol = %b\nR0 = %h\tR1 = %h\tR2 = %h\tR3 = %h",
				rst_n, data, control, R0, R1, R2, R3);
	// Data <- 0x1234
	#20 data = 16'h1234;
	$display ("====================================================================");
	$display ("Time %t status", $time);
	$display ("rst_n = %b\tdata = %h\tcontrol = %b\nR0 = %h\tR1 = %h\tR2 = %h\tR3 = %h",
				rst_n, data, control, R0, R1, R2, R3);
	// R1 <- Data(0x1234)
	#20 control = 7'b111_0010;
	$display ("====================================================================");
	$display ("Time %t status", $time);
	$display ("rst_n = %b\tdata = %h\tcontrol = %b\nR0 = %h\tR1 = %h\tR2 = %h\tR3 = %h",
				rst_n, data, control, R0, R1, R2, R3);
	// Data <- 0x8888
	#20 data = 16'h8888;
	$display ("====================================================================");
	$display ("Time %t status", $time);
	$display ("rst_n = %b\tdata = %h\tcontrol = %b\nR0 = %h\tR1 = %h\tR2 = %h\tR3 = %h",
				rst_n, data, control, R0, R1, R2, R3);
	// R2 <- Data(0x8888)
	#20 control = 7'b111_0100;
	$display ("====================================================================");
	$display ("#### R1 = 0x1234");
	$display ("Time %t status", $time);
	$display ("rst_n = %b\tdata = %h\tcontrol = %b\nR0 = %h\tR1 = %h\tR2 = %h\tR3 = %h",
				rst_n, data, control, R0, R1, R2, R3);
	// Pass R2
	#20 control = 7'b010_0000;
	$display ("====================================================================");
	$display ("#### R2 = 0x8888");
	$display ("Time %t status", $time);
	$display ("rst_n = %b\tdata = %h\tcontrol = %b\nR0 = %h\tR1 = %h\tR2 = %h\tR3 = %h",
				rst_n, data, control, R0, R1, R2, R3);
	// Pass R1; Save passing value to R1
	#20 control = 7'b001_0010;
	$display ("====================================================================");
	$display ("Time %t status", $time);
	$display ("rst_n = %b\tdata = %h\tcontrol = %b\nR0 = %h\tR1 = %h\tR2 = %h\tR3 = %h",
				rst_n, data, control, R0, R1, R2, R3);
	// Save passing value to R2; Pass Null
	#20 control = 7'b100_0100;
	$display ("====================================================================");
	$display ("Time %t status", $time);
	$display ("rst_n = %b\tdata = %h\tcontrol = %b\nR0 = %h\tR1 = %h\tR2 = %h\tR3 = %h",
				rst_n, data, control, R0, R1, R2, R3);
	// Pass R1
	#20 control = 7'b001_0000;
	$display ("====================================================================");
	$display ("Time %t status", $time);
	$display ("rst_n = %b\tdata = %h\tcontrol = %b\nR0 = %h\tR1 = %h\tR2 = %h\tR3 = %h",
				rst_n, data, control, R0, R1, R2, R3);
	// Save passing value to R3; Pass R1
	#20 control = 7'b001_1000;
	$display ("====================================================================");
	$display ("Time %t status", $time);
	$display ("rst_n = %b\tdata = %h\tcontrol = %b\nR0 = %h\tR1 = %h\tR2 = %h\tR3 = %h",
				rst_n, data, control, R0, R1, R2, R3);
	// Save passing value to R0; Pass Null
	#20 control = 7'b100_0001;
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
	$fsdbDumpfile("hw1_A_testbench.fsdb");
	$fsdbDumpvars;
end

endmodule // End of Module hw1_A_testbench

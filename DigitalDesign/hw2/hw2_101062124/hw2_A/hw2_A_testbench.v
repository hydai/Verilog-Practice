//-----------------------------------------------------
// Design Name : hw2_A_testbench
// File Name : hw2_A_testbench.v
// Function : This program will test hw2_A.v
// Coder    : hydai
//-----------------------------------------------------
`timescale 1 ns/1 ns
module hw2_A_testbench ;

reg in;
reg clk, rst_n;
wire out;

hw2_A A(
				in, 
				clk, 
				rst_n, 
				out, 
	   );

initial begin
#0 rst_n = 1'b0; clk = 1'b0;
#20 rst_n = 1'b1; in = 1'b0;
$display ("====================================================================");
$display ("Time %t", $time);
$display ("rst_n = %b\tin = %b\tout = %b",
				rst_n, in, out);
$display ("====================================================================");
end

wire [20:0] inputArr = 21'b0101_0011_1110_0010_1110_0; 		// Test pattern
integer i;
initial begin
#20 $display ("Simulate hw2_A");
for (i = 20; i >= 0; i = i - 1) begin
#20 in = inputArr[i];
$display ("====================================================================");
$display ("Time %t", $time);
$display ("rst_n = %b\tin = %b\tout = %b",
				rst_n, in, out);
$display ("====================================================================");
end

#40 $finish;
end

always begin
#10 clk = ~clk;
end

initial begin
$fsdbDumpfile("hw2_A_testbench.fsdb");
$fsdbDumpvars;
end

endmodule // End of Module hw2_A_testbench

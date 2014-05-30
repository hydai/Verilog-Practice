//-----------------------------------------------------
// Design Name : Test Bench
// File Name : TestBench.v
// Function : Test bench design
// Coder    : hydai
//-----------------------------------------------------

module TestBench;
reg in;
reg clk, rst_n;
wire out;

DesignName DesignInstance(
    out,
    in,
    clk,
    rst_n
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

wire [17:0] inputArr = 18'b0111_0001_0011_1110_00; 		// Test pattern
integer i;
initial begin
    #20 $display ("Simulate DesignName");
    for (i = 17; i >= 0; i = i - 1) begin
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

endmodule // End of TestBench

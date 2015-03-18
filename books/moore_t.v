//-----------------------------------------------------
// Design Name : moore_t
// File Name : moore_t.v
// Function : Testing moore.v design.
// Coder    : hydai
//-----------------------------------------------------

module moore_t;

reg reset_n, clk;
reg i_d;
wire o_d;

mooreFSM fsm(
    .o_d(o_d),
    .i_d(i_d),
    .clk(clk),
    .reset_n(reset_n)
);

reg [59:0] testpattern;
integer i;
initial begin
    testpattern = 60'b00010001100000111000011111000001111110000010101010110110101;
    #0 reset_n = 1'b0; clk = 0;
    #30 reset_n = 1'b1; i_d = 0;
    $display("%t i_d = %b, o_d = %b", $time, i_d, o_d);
    for (i = 0; i < 60; i = i+1) begin
        #20 i_d = testpattern[i];
        $display("%t i_d = %b, o_d = %b", $time, i_d, o_d);
    end
    #100 $finish;
end

always begin
    #10 clk = ~clk;
end

initial begin
    $dumpfile("moore_t.vcd");
    $dumpvars;
end

endmodule // End of moore_t


//-----------------------------------------------------
// Design Name : rrab_t
// File Name : rrab_t.v
// Function : Testing rrab.v design.
// Coder    : hydai
//-----------------------------------------------------

module rrab_t;

reg reset_n, clk;
reg [1:0] request;
wire [1:0] grant;

rrab rrab_instance(
    grant,
    request,
    clk,
    reset_n
);
initial begin
    $monitor("%t request = %b grant = %b", $time, request, grant);
    #0 reset_n = 1'b0; clk = 0;
    #45 reset_n = 1'b1; request = 2'b00;
    #25 request = 2'b00;
    #25 request = 2'b01;
    #25 request = 2'b10;
    #25 request = 2'b11;
    #45 request = 2'b00;
    #55 request = 2'b01;
    #65 request = 2'b10;
    #75 request = 2'b11;
    #25 request = 2'b00;
    #35 request = 2'b01;
    #45 request = 2'b10;
    #55 request = 2'b11;
    #75 request = 2'b00;
    #65 request = 2'b01;
    #55 request = 2'b10;
    #45 request = 2'b11;
    #55 request = 2'b00;
    #45 request = 2'b01;
    #35 request = 2'b10;
    #25 request = 2'b11;
    #100 $finish;
end

always begin
    #10 clk = ~clk;
end

initial begin
    $dumpfile("rrab.vcd");
    $dumpvars;
end

endmodule // End of rrab_t


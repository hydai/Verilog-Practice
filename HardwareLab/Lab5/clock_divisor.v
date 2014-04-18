`timescale 1ns / 1ps

module clock_divisor(clk24, clk22, clk15, clk
	);
input clk;
output clk24, clk22, clk15;

reg [24:0] num;
wire [24:0] next_num;

always @(posedge clk) begin
  num <= next_num;
end

assign next_num = num + 1;
assign clk24 = num[23];
assign clk22 = num[21];
assign clk15 = num[14];
endmodule

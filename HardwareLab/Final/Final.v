`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    12:45:27 06/19/2014 
// Design Name: 
// Module Name:    Final 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module Final(
    output  md1,
    output  md2,
    output  md3,
    output  md4,
    input   inf1,
    input   inf2,
    input   clk,
    input   reset_n
);
wire clk_1us;
CLK_DIV clk_div(clk_1us, clk);
CAR_CTR car_ctr(md1, md2, md3, md4, inf1, inf2, clk_1us, reset_n);

endmodule

`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:38:21 02/27/2014 
// Design Name: 
// Module Name:    Lab1 
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

//sum = a^b^c_in;
//c_out = (ab)+(c_in(a^b));
//////////////////////////////////////////////////////////////////////////////////
module Lab1(p, q, c_in, sum, c_out);
output sum, c_out;
input p, q, c_in;
wire t1, t2, t3;

xor(t1, p, q);
xor(sum, t1, c_in);

and(t2, p, q);
and(t3, c_in, t1);
or(c_out, t2, t3);

endmodule

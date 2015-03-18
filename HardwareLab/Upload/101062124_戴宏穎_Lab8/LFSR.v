`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    00:34:17 05/15/2014 
// Design Name: 
// Module Name:    LFSR 
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
module LFSR(random, clk, rst_n);
  input clk ;
  input rst_n ;
  output [3:0] random ;
  reg [3:0] random ;

  always @(posedge clk or negedge rst_n) 
    begin
      if (!rst_n) 
        random[3:0] <= 4'b1000;
      else 
        begin
          random[2:0] <= random[3:1];
          random[3] <= random[1] ^ random[0];
        end
    end
endmodule

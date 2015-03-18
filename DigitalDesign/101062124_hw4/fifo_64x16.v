//////////////////////////////////////////////////////////////////////////
// Department of Computer Science
// National Tsing Hua University
// Project   : FIFO for CS4125 Digital System Design
// Module    : fifo.v
// Author    : Chih-Tsun Huang
// E-mail    : cthuang@cs.nthu.edu.tw
// Revision  : 4
// Date      : 2014/04/28
// Abstract  :
//     The top module of FIFO consists of FIFO controller and the RAM module.
// Note      :
//     1.  The purpose of this version is to provide a design style. It is
//         not a complete module. Please fix any *unexpected feature* by
//         yourself if any.
//     2.  Feel free to rewrite this file header to your own.
//

module fifo (
				input clk,
				input rst_n,
				input push,
				input pop,
				input [15:0] datain,
				output empty,
				output almost_empty,
				output full,
				output almost_full,
				output error,
				output reg [15:0] dataout
			);

wire   [5:0] addr;
wire   cen;
wire   oen;
wire   wen;
wire   [15:0] data_to_ram;
wire   [7:0] next_dataout_1f, next_dataout_1e, next_dataout_2f, next_dataout_2e;
reg   [7:0] next_datain_1f, next_datain_1e, next_datain_2f, next_datain_2e;
reg   [5:0] next_addr;

		fifo_ctr controller (
						.clk(clk),
						.rst_n(rst_n),
						.push(push),
						.pop(pop),
						.empty(empty),
						.almost_empty(almost_empty),
						.full(full),
						.almost_full(almost_full),
						.error(error),
						.cen(cen),
						.wen(wen),
						.oen(oen),
						.addr(addr)
						);

		// LAB NOTE:
		// You should include the memory simulation model by your own

		RAM32x8 ram1_front (
						.Q(next_dataout_1f),
						.CLK(clk),
						.CEN(cen),
						.WEN(wen),
						.A(next_addr[4:0]),
						.D(next_datain_1f),
						.OEN(oen)
					);
		RAM32x8 ram1_end (
						.Q(next_dataout_1e),
						.CLK(clk),
						.CEN(cen),
						.WEN(wen),
						.A(next_addr[4:0]),
						.D(next_datain_1e),
						.OEN(oen)
					);
		RAM32x8 ram2_front (
						.Q(next_dataout_2f),
						.CLK(clk),
						.CEN(cen),
						.WEN(wen),
						.A(next_addr[4:0]),
						.D(next_datain_2f),
						.OEN(oen)
					);
		RAM32x8 ram2_end (
						.Q(next_dataout_2e),
						.CLK(clk),
						.CEN(cen),
						.WEN(wen),
						.A(next_addr[4:0]),
						.D(next_dataout_2e),
						.OEN(oen)
					);
		always @(*) begin
			if (addr[4] == 1) begin
				dataout = {next_dataout_2f, next_dataout_2e};
				{next_datain_2f, next_datain_2e} = datain;
				{next_datain_1f, next_datain_1e} = {next_datain_1f, next_datain_1e};
			end else begin
				dataout = {next_dataout_1f, next_dataout_1e};
				{next_datain_1f, next_datain_1e} = datain;
				{next_datain_2f, next_datain_2e} = {next_datain_2f, next_datain_2e};
			end
		end
endmodule

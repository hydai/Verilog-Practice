//////////////////////////////////////////////////////////////////////////
// Department of Computer Science
// National Tsing Hua University
// Project   : FIFO for CS4125 Digital System Design
// Module    : fifo_ctl.v
// Author    : Chih-Tsun Huang
// E-mail    : cthuang@cs.nthu.edu.tw
// Revision  : 4
// Date      : 2014/04/28
// Abstract  :
//     FIFO controller is mainly the finite state machine and its
//     control signals to manage the RAM module.
// Note      :
//     1.  The purpose of this version is to provide a design style. It is
//         not a complete module. Please fix any *unexpected feature* by
//         yourself if any.
//     2.  Feel free to rewrite this file header to your own.
//

module fifo_ctr (

				// inputs
				input wire clk,
				input wire rst_n,
				input wire push,
				input wire pop,

				// outputs
				output reg empty,
				output reg almost_empty,
				output reg full,
				output reg almost_full,
				output reg error,
				output reg cen,
				output reg wen,
				output reg oen,
				output reg [5:0] addr
				);

parameter numOfRam = 64;
// small delay of flip-flop outputs
parameter delay = 1.5;

// state encoding
parameter EMPTY   = 2'b00;
parameter BETWEEN = 2'b01;
parameter READOUT = 2'b10;
parameter FULL    = 2'b11;

// state vector
reg    [1:0] state;
reg    [1:0] state_next;

// pointers
reg    [5:0] head;
reg    [5:0] head_next;
reg    [5:0] tail;
reg    [5:0] tail_next;

reg    head_plus;
reg    tail_plus;
reg    addr_head;
reg    addr_tail;

reg		do_idle;
reg		do_pop;
reg		do_push;
reg		do_push_pop;

// sequential part
always @(posedge clk or negedge rst_n) begin
if (rst_n == 0) begin
state <= EMPTY;
head  <= 6'b0;
tail  <= 6'b0;
end else begin
state <= #(delay) state_next;
head  <= #(delay) head_next;
tail  <= #(delay) tail_next;
end
end


// combinational parts

// Lab Note:
// Complete your design here

always @(*) begin
do_idle = 1'b0;
do_pop  = 1'b0;
do_push = 1'b0;
do_push_pop = 1'b0;
case ({push,pop})
		2'b00: begin do_idle = 1'b1; end
		2'b01: begin do_pop = 1'b1; end
		2'b10: begin do_push = 1'b1; end
		2'b11: begin do_push_pop = 1'b1; end
		endcase
		end

		always @(*) begin
		if (head_plus) begin
		head_next = (head + 1'b1)%numOfRam;
		end else begin
		head_next = head;
		end
		if (tail_plus) begin
		tail_next = (tail + 1'b1)%numOfRam;
		end else begin
		tail_next = tail;
		end
		end


		always @(*) begin
		if (tail == head - 1'b1) begin
		almost_empty  = 1'b1;
		end else begin
		almost_empty  = 1'b0;
		end
		if (head == tail - 1'b1) begin
		almost_full   = 1'b1;
		end else begin
		almost_full   = 1'b0;
		end
		oen               = 1'b0;
		end


		// FSM
		always @(*) begin
		empty         = 1'b0;
		full          = 1'b0;
		error         = 1'b0;
		cen           = 1'b0;
		wen           = 1'b0;
		addr          = 6'b0;
		head_plus     = 1'b0;
		tail_plus     = 1'b0;
		addr_head     = 1'b0;
		addr_tail     = 1'b0;
		state_next    = state;
case (state)
		EMPTY:    begin
		if (do_idle || do_pop || do_push_pop) begin
		error         = (do_pop | do_push_pop);
		state_next    = EMPTY;
		end else if (do_push) begin
		addr          = head;
		head_plus     = 1'b1;
		wen           = 1'b0;
		state_next    = BETWEEN;
		end
		end
		BETWEEN:  begin
		if (do_push && !almost_full) begin
		addr          = head;
		head_plus     = 1'b1;
		wen           = 1'b0;
		state_next    = BETWEEN;
		end else if (do_idle || do_push_pop) begin
		error         = do_push_pop;
		state_next    = BETWEEN;
		end else if (do_pop) begin
		addr          = tail;
		state_next    = READOUT;
		end else if (do_push && almost_full) begin
		addr          = head;
		head_plus     = 1'b1;
		wen           = 1'b0;
		state_next    = FULL;
		end
		end
		READOUT:  begin
		if (!almost_empty) begin
		tail_plus     = 1'b1;
		error         = (do_push | do_pop);
		state_next    = BETWEEN;
		end else begin
		tail_plus     = 1'b1;
		error         = (do_push | do_pop);
		state_next    = EMPTY;
		end
		end
		FULL:     begin
		if (do_pop) begin
		addr          = tail;
		state_next    = READOUT;
		end else if (do_idle || do_push || do_push_pop) begin
		error         = (do_push | do_push_pop);
		state_next    = FULL;
		end

		end
		endcase
		end
		endmodule

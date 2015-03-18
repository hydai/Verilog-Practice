// Put your file header here
//

module stimulus;
	parameter period = 20;
	parameter delay = 2;


	// declare the signals here
	reg clk, rst_n, push, pop;
	reg [15:0] datain;
	wire empty, almost_empty, full, almost_full, error;
	wire [15:0] dataout;

	fifo fifo1 (
					clk,
					rst_n,
					push,
					pop,
					datain,
					empty,
					almost_empty,
					full,
					almost_full,
					error,
					dataout
			   );

	always #(period/2) clk = ~clk;

	initial begin
		`ifdef NETLIST
			$sdf_annotate("fifo_64_x16syn.sdf", fifo1);
			$fsdbDumpfile("fifo_64_x16syn.fsdb");
		`else
			$fsdbDumpfile("fifo_64x16.fsdb");
		`endif
		$fsdbDumpvars;
	end

	initial begin
		clk = 1;
		rst_n = 1;
		idle;
		#(period);
		#(delay)  rst_n = 0;
		#(period*4) rst_n = 1;
		//    #(period/2*5+delay) rst_n = 1;
		//    #(period/2-delay);
		#(period*2);

		#(period) popping;
		#(period) idle;
		#(period) pushing(16'd1);
		#(period) idle;
		#(period) pushing(16'd2);
		#(period) pushing(16'd3);
		#(period) pushing(16'd4);
		#(period) popping;
		#(period) pushing(16'd5);
		#(period) popping;
		#(period) popping;
		#(period) idle;
		#(period) popping;
		#(period) idle;
		#(period) popping;
		#(period) idle;
		#(period) popping;
		#(period) idle;
		#(period) idle;
		#(period) invalid;
		#(period) invalid;
		#(period) idle;
		#(period) idle;
		#(period) idle;
		#(period) popping;
		#(period) idle;
		#(period) invalid;
		#(period) idle;
		#(period) popping;
		#(period) idle;
		#(period) pushing(16'd6);
		#(period) pushing(16'd7);
		#(period) pushing(16'd8);
		#(period) pushing(16'd9);
		#(period) pushing(16'd11);
		#(period) pushing(16'd12);
		#(period) pushing(16'd13);
		#(period) idle;
		#(period) invalid;
		#(period) idle;
		#(period) pushing(16'd14);
		#(period) pushing(16'd15);
		#(period) pushing(16'd16);
		#(period) pushing(16'd17);
		#(period) pushing(16'd18);
		#(period) pushing(16'd19);
		#(period) pushing(16'd20);
		#(period) pushing(16'd21);
		#(period) pushing(16'd22);
		#(period) popping;
		#(period) idle;
		#(period) popping;
		#(period) idle;
		#(period) popping;
		#(period) idle;
		#(period) pushing(16'd23);
		#(period) pushing(16'd24);
		#(period) pushing(16'd25);
		#(period) pushing(16'd26);
		#(period) pushing(16'd27);
		#(period) pushing(16'd28);
		#(period) pushing(16'd29);
		#(period) pushing(16'd30);
		#(period) idle;
		#(period) pushing(16'd31);
		#(period) pushing(16'd32);
		#(period) pushing(16'd33);
		#(period) pushing(16'd34);
		#(period) pushing(16'd35);
		#(period) pushing(16'd36);
		#(period) pushing(16'd37);
		#(period) pushing(16'd38);
		#(period) pushing(16'd39);
		#(period) pushing(16'd40);
		#(period) pushing(16'd41);
		#(period) pushing(16'd42);
		#(period) pushing(16'd43);
		#(period) pushing(16'd44);
		#(period) pushing(16'd45);
		#(period) idle;
		#(period) idle;
		#(period) idle;
		#(period) idle;
		#(period) idle;

		#(period) popping;
		#(period) idle;
		#(period) idle;
		#(period) idle;
		#(period) popping;
		#(period) idle;
		#(period) popping;
		#(period) idle;
		#(period) popping;
		#(period) idle;

		#(period) idle;
		#(period*4);
		$finish;
	end

	// tasks
	task idle;
		begin
			push = 0;
			pop = 0;
			datain = 16'b0;
		end
	endtask
	task pushing;
		input [15:0] data;
		begin
			push = 1;
			pop = 0;
			datain = data;
		end
	endtask
	task popping;
		begin
			push = 0;
			pop = 1;
		end
	endtask
	task invalid;
		begin
			push = 1;
			pop = 1;
		end
	endtask
endmodule

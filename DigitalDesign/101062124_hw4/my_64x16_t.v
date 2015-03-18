// Put your file header here
//

`ifndef TESTSIZE
`define TESTSIZE 78
`endif
module stimulus;
	reg [9:0] test_vector [`TESTSIZE-1:0];
	parameter period = 20;
	parameter delay = 2;


	// declare the signals here
	reg clk, rst_n, push, pop;
	reg [15:0] datain;
	wire empty, almost_empty, full, almost_full, error;
	wire [15:0] dataout;
	integer i;

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
			$sdf_annotate("fifo_my_64x16_syn.sdf", fifo1);
			$fsdbDumpfile("fifo_my_64x16_syn.fsdb");
		`else
			$fsdbDumpfile("fifo_my_64x16.fsdb");
		`endif
		$fsdbDumpvars;
	end

	initial begin
		$readmemb("pattern1.dat", test_vector);
		clk = 1;
		rst_n = 1;
		idle;
		#(period);
		#(delay)  rst_n = 0;
		#(period*4) rst_n = 1;
		//    #(period/2*5+delay) rst_n = 1;
		//    #(period/2-delay);
		#(period*2);

		for (i = 0; i < `TESTSIZE; i = i + 1) begin
			case ({test_vector[i][9],test_vector[i][8]})
				2'b00: begin
					#(period) pushing({test_vector[i][7:0]});
				end
				2'b01: begin
					#(period) popping;
				end
				2'b10: begin
					#(period) idle;
				end
				2'b11: begin
					#(period) invalid;
				end
			endcase
		end

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

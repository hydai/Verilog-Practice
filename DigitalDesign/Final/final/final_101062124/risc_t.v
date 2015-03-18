module stimulus;
  parameter data_width = 32;
  parameter address_width = 32;
  parameter address_depth = 2048;
  parameter opcode_width = 7;
  parameter reg_addr_width = 5;
  parameter immediate_width = 15;
  parameter period = 20;
  parameter delay = 1;

  //  Define the input and output file names
  /*
  parameter program_code  = "01_gcd_plain-bin.dat";
  parameter program_data  = "01_gcd_plain-data.dat";
  parameter program_code  = "02_mult-bin.dat";
  parameter program_data  = "02_mult-data.dat";
  parameter program_code  = "04_lcm-bin.dat";
  parameter program_data  = "04_lcm-data.dat";
  parameter program_code  = "09_fabonacci-bin.dat";
  parameter program_data  = "09_fabonacci-data.dat";
  parameter program_code  = "12_factional_2-bin.dat";
  parameter program_data  = "12_factional_2-data.dat";
  */
  parameter program_code  = "03_division-bin.dat";
  parameter program_data  = "03_division-data.dat";
  parameter sdf_file      = "Processor.sdf";
  parameter fsdb_syn_file = "risc_syn.fsdb";
  parameter fsdb_file     = "risc.fsdb";
  parameter vcd_syn_file  = "risc_syn.vcd";
  parameter vcd_file      = "risc.vcd";
  parameter instr_count   = 20;
  parameter HALT = 32'b11111111111111111111111111111111;

  reg clk;
  reg rst_n;
  wire [31:0] pPC, pdatain, paddr;
  wire pwen, poen;

  // signals for instruction memory IM
  reg im_cen;
  reg im_wen;
  reg [10:0] im_addr;
  reg [31:0] im_datain;
  reg im_oen;
  wire [31:0] im_dataout;

  // signals for data memory DM
  reg dm_cen;
  reg dm_wen;
  reg [10:0] dm_addr;
  reg [31:0] dm_datain;
  reg dm_oen;
  wire [31:0] dm_dataout;

  reg [data_width - 1:0] pc;
  reg [data_width - 1:0] pc_pre;
  reg [data_width - 1:0] ir;
  reg [opcode_width - 1:0] opcode;
  reg [reg_addr_width - 1:0] dr, sa, sb, sh;
  reg signed [immediate_width - 1:0] imm;

  RAM2Kx32 #(
   .preload_file(program_code)
  ) IMEM (
   .Q(im_dataout),
   .CLK(clk),
   .CEN(im_cen),
   .WEN(im_wen),
   .A(im_addr),
   .D(im_datain),
   .OEN(im_oen)
  );

  RAM2Kx32 #(
   .preload_file(program_data)
  ) DMEM (
   .Q(dm_dataout),
   .CLK(clk),
   .CEN(dm_cen),
   .WEN(dm_wen),
   .A(dm_addr),
   .D(dm_datain),
   .OEN(dm_oen)
  );
  SingleCycleProcessor processor (
  	.PC(pPC),
	.datain(pdatain),
	.address(paddr),
	.MW(pwen),
	.MR(poen),
	.instruction(im_dataout),
	.dataout(dm_dataout),
	.clk(clk),
	.reset_n(rst_n)
  );
  always #(period/2) clk = ~clk;

  initial begin
    `ifdef NETLIST
      $sdf_annotate(sdf_file, processor);
      `ifdef FSDB
        $fsdbDumpfile(fsdb_syn_file);
        $fsdbDumpvars;
      `else
        $dumpfile(vcd_syn_file);
        $dumpvars(0, stimulus);
      `endif
    `else
      `ifdef FSDB
        $fsdbDumpfile(fsdb_file);
        $fsdbDumpvars;
      `else
        $dumpfile(vcd_file);
        $dumpvars(0, stimulus);
      `endif
    `endif
  end

  initial begin
    // initialization
    clk = 1;
    rst_n = 1'b1;
    im_cen = 0;
    im_wen = 1'b1;
    im_oen = 1'b1;
    dm_cen = 0;
    dm_wen = 1'b1;
    dm_oen = 1'b1;
    pc = 0;
    pc_pre = 0;

    #(period) rst_n = 0;
	im_oen = 1'b0;
	im_addr = 0;
	dm_datain = pdatain;
	dm_addr = paddr;
	dm_wen = pwen;
	dm_oen = poen;
    #(period*10) rst_n = 1;
	while (im_dataout != HALT) begin
		im_addr = pPC;
		dm_datain = pdatain;
		dm_addr = paddr;
		dm_wen = pwen;
		dm_oen = poen;
		#(period);
	end
    #(period) idle;
    #(period) idle;
    #(period) idle;

    #(period*4);
    $finish;
  end

  // tasks
  task idle;
    begin
      im_wen = 1;
      im_oen = 1;
      im_datain = 32'bz;
    end
  endtask
  task dm_nop;
    begin
      dm_wen = 1;
      dm_oen = 1;
      dm_datain = 32'bz;
    end
  endtask
  always @(posedge clk) begin
    pc_pre = #(delay) pc;
  end

endmodule

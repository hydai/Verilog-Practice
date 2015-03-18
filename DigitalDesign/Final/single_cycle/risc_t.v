//////////////////////////////////////////////////////////////////////////
// Department of Computer Science
// National Tsing Hua University
// Project   : RISC Processor for CS4125 Digital System Design
// Module    : risc_t.v
// Author    : Chih-Tsun Huang
// E-mail    : cthuang@cs.nthu.edu.tw
// Revision  : 3
// Date      : 2014/06/07
// Abstract  :
//     Test stimulus for RISC processor.
// Note      :
//     1.  The purpose of this test stimulus is to provide a test
//         template to include the main memory with auto-loading of
//         binary program (machine code).  You can replace the binary
//         code by changing the parameter 'preload_file' (it's
//         "01_gcd_plain-bin.dat" by default).
//         In addition, you can use the same memory module as the data
//         memory by loading "01_gcd_plain-data.dat").
//     2.  In addition, there is a simple de-assembler in this stimulus to
//         facilitate your debugging.
//     3.  Feel free to improve the code by your own.
//

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
  parameter program_code  = "01_gcd_plain-bin.dat";
  parameter program_data  = "01_gcd_plain-data.dat";
  parameter sdf_file      = "risc_syn.sdf";
  parameter fsdb_syn_file = "risc_syn.fsdb";
  parameter fsdb_file     = "risc.fsdb";
  parameter vcd_syn_file  = "risc_syn.vcd";
  parameter vcd_file      = "risc.vcd";
  parameter instr_count   = 20;

  reg clk;
  reg rst_n;

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

  always #(period/2) clk = ~clk;

  initial begin
    `ifdef NETLIST
      $sdf_annotate(sdf_file, risc1);
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

    idle;
    dm_nop;
    #(period);
    #(delay)  rst_n = 0;
    #(period*4) rst_n = 1;
//    #(period/2*5+delay) rst_n = 1;
//    #(period/2-delay);
    #(period*2);


    #(period) idle;
    @(posedge clk);

    // Fetch instruction one by one
    // Note that instruction count has to be pre-defined
    // Increast the parameter instr_count for a longer code
    $display("\nFetching the instructions:");
    while (pc <= instr_count) begin
      instr_fetch(pc);
      pc = pc + 1;
    end

    #(period) idle;
    #(period) idle;

    $display("\nPerform some writes and reads to/from the data memory:");
    //  Here I also show some writes to the data memory and
    //  reads to the data memory
    //  Write to address 1026
    dm_write(32'd1026, 32'd217);
    //  Write to address 512
    dm_write(32'd512, 32'd115);
    //  Write to address 1145
    dm_write(32'd1145, 32'd93);

    #(period) dm_nop;

    //  Two-cycle read is used to make the timing clearer.
    //  Of course You can take advantage of pipelined read if necessary.
    //  Read from address 1026
    dm_read(32'd1026);
    //  Read from address 1145
    dm_read(32'd1145);
    //  Read from address 512
    dm_read(32'd512);
    //  Read from address 1024
    dm_read(32'd1024);
    //  Read from address 1025
    dm_read(32'd1025);

    #(period) idle;
    #(period) idle;
    #(period*4);
    $finish;
  end

`ifdef DEBUG
  initial begin
    $monitor($time, " [pc=%5d] [ir=%b]", pc, ir);
  end
`endif

  // tasks
  task idle;
    begin
      im_wen = 1;
      im_oen = 1;
      im_datain = 32'bz;
    end
  endtask
  task instr_fetch;
    input [address_width - 1:0] program_counter;
    begin
      im_addr = #(delay) program_counter;
      im_wen = 1;
      im_oen = 0;
      @(posedge clk)
      ir = im_dataout;
      opcode = ir[31:25];
      dr = ir[24:20];
      sa = ir[19:15];
      sb = ir[14:10];
      imm = ir[14:0];
      sh = ir[4:0];
    end
  endtask
  task dm_nop;
    begin
      dm_wen = 1;
      dm_oen = 1;
      dm_datain = 32'bz;
    end
  endtask
  task dm_write;
    input [address_width - 1:0] address;
    input [data_width - 1:0] data;
    begin
      @(posedge clk) begin
        #(delay)
        dm_addr = address;
        dm_datain = data;
        dm_wen = 0;
`ifdef DEBUG_DATAMEM_RW
        $display("[", $time, "] Writing %d to DMEM[%d]", dm_datain, dm_addr);
`endif
      end
    end
  endtask
  task dm_read;
    input [address_width - 1:0] address;
    begin
      @(posedge clk) begin
        #(delay)
        dm_addr = address;
        dm_wen = 1;
        dm_oen = 0;
      end
      @(posedge clk) begin
        #(delay)
        dm_oen = 0;
`ifdef DEBUG_DATAMEM_RW
        $display("[",$time, "] Reading DMEM[%d]: %d", dm_addr, dm_dataout);
`endif
      end
    end
  endtask

  // De-assembler
  parameter NOP  = 7'b0000000;
  parameter MOVA = 7'b1000000;
  parameter ADD  = 7'b0000010;
  parameter SUB  = 7'b0000101;
  parameter AND  = 7'b0001000;
  parameter OR   = 7'b0001001;
  parameter XOR  = 7'b0001010;
  parameter NOT  = 7'b0001011;
  parameter ADI  = 7'b0100010;
  parameter SBI  = 7'b0100101;
  parameter ANI  = 7'b0101000;
  parameter ORI  = 7'b0101001;
  parameter XRI  = 7'b0101010;
  parameter AIU  = 7'b0100010;
  parameter SIU  = 7'b0100101;
  parameter MOVB = 7'b0001100;
  parameter LSR  = 7'b0001101;
  parameter LSL  = 7'b0001110;
  parameter LD   = 7'b0010000;
  parameter ST   = 7'b0100000;
  parameter JMR  = 7'b1110000;
  parameter SLT  = 7'b1100101;
  parameter BZ   = 7'b1100000;
  parameter BNZ  = 7'b1001000;
  parameter JMP  = 7'b1101000;
  parameter JML  = 7'b0110000;

  always @(posedge clk) begin
    pc_pre = #(delay) pc;
  end

`ifndef CYC_BASED_DEASSEMBLY
  always @(ir) begin
`else
  always @(posedge clk) begin
`endif
    case (ir[31:25])
      NOP: begin
        $display("[%5d] NOP  ", pc_pre);
      end
      MOVA: begin
        $display("[%5d] MOVA R%d, R%d", pc_pre, dr, sa);
      end
      ADD: begin
        $display("[%5d] ADD  R%0d, R%0d", pc_pre, dr, sa);
      end
      SUB: begin
        $display("[%5d] SUB  R%0d, R%0d, R%0d", pc_pre, dr, sa, sb);
      end
      AND: begin
        $display("[%5d] AND  R%0d, R%0d, R%0d", pc_pre, dr, sa, sb);
      end
      OR: begin
        $display("[%5d] OR   R%0d, R%0d, R%0d", pc_pre, dr, sa, sb);
      end
      XOR: begin
        $display("[%5d] XOR  R%0d, R%0d, R%0d", pc_pre, dr, sa, sb);
      end
      NOT: begin
        $display("[%5d] NOT  R%0d, R%0d", pc_pre, dr, sa);
      end
      ADI: begin
        $display("[%5d] ADI  R%0d, R%0d, #(%d)", pc_pre, dr, sa, imm);
      end
      SBI: begin
        $display("[%5d] SBI  R%0d, R%0d, #(%d)", pc_pre, dr, sa, imm);
      end
      ANI: begin
        $display("[%5d] ANI  R%0d, R%0d, #(%d)", pc_pre, dr, sa, imm);
      end
      ORI: begin
        $display("[%5d] ORI  R%0d, R%0d, #(%d)", pc_pre, dr, sa, imm);
      end
      XRI: begin
        $display("[%5d] XRI  R%0d, R%0d, #(%d)", pc_pre, dr, sa, imm);
      end
      AIU: begin
        $display("[%5d] AIU  R%0d, R%0d, #(%d)", pc_pre, dr, sa, imm);
      end
      SIU: begin
        $display("[%5d] SIU  R%0d, R%0d, #(%d)", pc_pre, dr, sa, imm);
      end
      MOVB: begin
        $display("[%5d] MOVB R%0d, R%0d", pc_pre, dr, sb);
      end
      LSR: begin
        $display("[%5d] LSR  R%0d, R%0d >> %d", pc_pre, dr, sa, sh);
      end
      LSL: begin
        $display("[%5d] LSL  R%0d, R%0d << %d", pc_pre, dr, sa, sh);
      end
      LD: begin
        $display("[%5d] LD   R%0d, M[R%0d]", pc_pre, dr, sa);
      end
      ST: begin
        $display("[%5d] ST   R%0d, M[R%0d]", pc_pre, sa, sb);
      end
      JMR: begin
        $display("[%5d] JMR  R%0d", pc_pre, sa);
      end
      SLT: begin
        $display("[%5d] SLT  R%0d, R%0d, R%0d", pc_pre, dr, sa, sb);
      end
      BZ: begin
        $display("[%5d] BZ   R%0d, #(%d)", pc_pre, sa, imm);
      end
      BNZ: begin
        $display("[%5d] BNZ  R%0d, #(%d)", pc_pre, sa, imm);
      end
      JMP: begin
        $display("[%5d] JMP  #(%d)", pc_pre, imm);
      end
      JML: begin
        $display("[%5d] JML  R%0d, #(%d)", pc_pre, dr, imm);
      end
      default: begin
        $display("[%5d] Unknown Instruction! Opcode = %b", pc_pre, opcode);
      end
    endcase
  end
endmodule

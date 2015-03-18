// Put your file header here
//

module stimulus;
  parameter period = 20;
  parameter delay = 2;

  // declare the signals here

  fifo fifo1 (
    // complete the port connection here
  );

  always #(period/2) clk = ~clk;

  initial begin
    `ifdef NETLIST
      $sdf_annotate("fifo_syn.sdf", fifo1);
      $fsdbDumpfile("fifo_syn.fsdb");
    `else
      $fsdbDumpfile("fifo.fsdb");
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
    #(period) pushing(8'd1);
    #(period) idle;
    #(period) pushing(8'd2);
    #(period) pushing(8'd3);
    #(period) pushing(8'd4);
    #(period) popping;
    #(period) pushing(8'd5);
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
    #(period) pushing(8'd6);
    #(period) pushing(8'd7);
    #(period) pushing(8'd8);
    #(period) pushing(8'd9);
    #(period) pushing(8'd11);
    #(period) pushing(8'd12);
    #(period) pushing(8'd13);
    #(period) idle;
    #(period) invalid;
    #(period) idle;
    #(period) pushing(8'd14);
    #(period) pushing(8'd15);
    #(period) pushing(8'd16);
    #(period) pushing(8'd17);
    #(period) pushing(8'd18);
    #(period) pushing(8'd19);
    #(period) pushing(8'd20);
    #(period) pushing(8'd21);
    #(period) pushing(8'd22);
    #(period) popping;
    #(period) idle;
    #(period) popping;
    #(period) idle;
    #(period) popping;
    #(period) idle;
    #(period) pushing(8'd23);
    #(period) pushing(8'd24);
    #(period) pushing(8'd25);
    #(period) pushing(8'd26);
    #(period) pushing(8'd27);
    #(period) pushing(8'd28);
    #(period) pushing(8'd29);
    #(period) pushing(8'd30);
    #(period) idle;
    #(period) pushing(8'd31);
    #(period) pushing(8'd32);
    #(period) pushing(8'd33);
    #(period) pushing(8'd34);
    #(period) pushing(8'd35);
    #(period) pushing(8'd36);
    #(period) pushing(8'd37);
    #(period) pushing(8'd38);
    #(period) pushing(8'd39);
    #(period) pushing(8'd40);
    #(period) pushing(8'd41);
    #(period) pushing(8'd42);
    #(period) pushing(8'd43);
    #(period) pushing(8'd44);
    #(period) pushing(8'd45);
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
      datain = 8'b0;
    end
  endtask
  task pushing;
    input [7:0] data;
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

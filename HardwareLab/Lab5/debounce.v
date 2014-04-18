`timescale 1ns / 1ps

// Debounce Pushbutton: Filters out mechanical switch bounce for around 40Ms
module debounce(pb_debounced, pb, clk);

  //push_button_debounced, push_button, clock
  output    pb_debounced; // signal of push button after debounced
  input     pb;           // signal from push button of the FPGA board
  input     clk;          // 100hz clock
  
  reg [3:0] shift_reg;    // use shift_reg to filter push button bounce 

  //when positive edge clock, shift the signal of pb to shift_reg[0]
  always @(posedge clk) begin
    shift_reg[3:1] <= shift_reg[2:0];
    shift_reg[0] <= pb;
  end

  //if pb remain 0 at 4 positive edge clock, then pb_debounced = 0
  assign pb_debounced = ((shift_reg == 4'b0000) ? 1'b0 : 1'b1);

endmodule


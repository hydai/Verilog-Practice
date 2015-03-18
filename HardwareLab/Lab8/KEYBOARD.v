`timescale 1ns / 1ps
module KEYBOARD (ROW, KEY_BUFFER, PRESS_VALID, COLUMN, reset, circuit_clk, clk);

  input  clk, circuit_clk;
  input  reset;
  input  [3:0]  COLUMN;
  output [3:0]  ROW;
  output [3:0]  KEY_BUFFER;
  output PRESS_VALID;
  
  reg    [3:0]  ROW;
  reg    [3:0]  DEBOUNCE_COUNT;
  reg    [3:0]  SCAN_CODE;
  reg    [4:0]  KEY_CODE;
  reg    [3:0] KEY_BUFFER;
  reg    PRESS;
  wire   PRESS_VALID;

  
/***************************
 * Scanning Code Generator *
 ***************************/
 
  always @(posedge clk or negedge reset)
    begin
      if (!reset) 
	        SCAN_CODE <= 4'h0;
      else if (PRESS)
	        SCAN_CODE <= SCAN_CODE + 1;
    end

/*********************
 * Scanning Keyboard *
 *********************/
 
  always @(SCAN_CODE or COLUMN)
    begin
      case (SCAN_CODE[3:2])
        2'b00 : ROW = 4'b1110;
        2'b01 : ROW = 4'b1101;
        2'b10 : ROW = 4'b1011;
        2'b11 : ROW = 4'b0111;
      endcase
      case (SCAN_CODE[1:0])
        2'b00 : PRESS = COLUMN[0];
        2'b01 : PRESS = COLUMN[1];
        2'b10 : PRESS = COLUMN[2];
        2'b11 : PRESS = COLUMN[3];
      endcase
    end
    
/********************
 * Debounce Circuit *
 ********************/

  always @(posedge circuit_clk or negedge reset)
    begin
      if (!reset)
	        DEBOUNCE_COUNT <= 4'h0;
	   else if (PRESS)
			  DEBOUNCE_COUNT <= 4'h0;
      else if (DEBOUNCE_COUNT <= 4'hE)
	        DEBOUNCE_COUNT <= DEBOUNCE_COUNT + 1;
    end 
  assign PRESS_VALID = (DEBOUNCE_COUNT == 4'hD) ?
                        1'b1 : 1'b0;
 
/******************
 * Fetch Key Code *
 ******************/
 
  always @(negedge circuit_clk or negedge reset)
    begin
      if (!reset)
         KEY_CODE <= 5'b10000;     
      else if (PRESS_VALID)
         KEY_CODE <= {1'b0,SCAN_CODE};
		else
			KEY_CODE <= 5'b10000;
    end
    
      
/********************************
 * Convert Key Code Into Number * 
 ********************************/

  always @(KEY_CODE)
   begin
    case (KEY_CODE)
     {1'b0,4'hC} : KEY_BUFFER = 4'h0; // 0
     {1'b0,4'hD} : KEY_BUFFER = 4'h1; // 1
     {1'b0,4'h9} : KEY_BUFFER = 4'h2; // 2
     {1'b0,4'h5} : KEY_BUFFER = 4'h3; // 3
     {1'b0,4'hE} : KEY_BUFFER = 4'h4; // 4
     {1'b0,4'hA} : KEY_BUFFER = 4'h5; // 5
     {1'b0,4'h6} : KEY_BUFFER = 4'h6; // 6
     {1'b0,4'hF} : KEY_BUFFER = 4'h7; // 7
     {1'b0,4'hB} : KEY_BUFFER = 4'h8; // 8
     {1'b0,4'h7} : KEY_BUFFER = 4'h9; // 9
     {1'b0,4'h8} : KEY_BUFFER = 4'hA; // A
     {1'b0,4'h4} : KEY_BUFFER = 4'hB; // B
     {1'b0,4'h3} : KEY_BUFFER = 4'hC; // C
     {1'b0,4'h2} : KEY_BUFFER = 4'hD; // D
     {1'b0,4'h1} : KEY_BUFFER = 4'hE; // E
     {1'b0,4'h0} : KEY_BUFFER = 4'hF; // F
	  default: KEY_BUFFER = 4'h0;
    endcase  
   end

endmodule 
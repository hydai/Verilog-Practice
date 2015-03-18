//-----------------------------------------------------
// Design Name : ProgramCounter
// File Name : ProgramCounter.v
// Function : Implement PC for processer.
// Coder    : hydai
//-----------------------------------------------------

module ProgramCounter (
    output reg          [31:0] PC_o,
    input               PC_cen,
    input               PC_wen,
    input               [31:0] PC_write,
    input               clk,
    input               reset_n
);
    /*
    * When PC is enable, the output of PC will plus 1;
    * otherwise, the output of PC will hold the origin
    * previous value.
    * */
    always @(posedge clk or negedge reset_n) begin
        if (!reset_n) begin
            PC_o <= 32'b0;
        end else begin
            if (PC_cen) begin
                PC_o <= PC_o + 32'b1;
            end else if (PC_wen) begin
                PC_o <= PC_write;
            end else begin
                PC_o <= PC_o;
            end
        end
    end
    
endmodule

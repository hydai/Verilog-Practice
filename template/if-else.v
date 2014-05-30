module If_Else_Block (
    output reg o_sum,
    input i_a,
    input i_b,
    input en
);

//========================================
// Using assign statement
// assign o_sum = (en) ? (i_a + i_b) : (0);
//========================================
// Using always block
// Without clk, using * is easy and useful
always @(*) begin
    if (en) begin
        o_sum = i_a + i_b;
    end else begin
        o_sum = 0;
    end
end

endmodule

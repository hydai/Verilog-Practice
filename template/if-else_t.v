//-----------------------------------------------------
// Design Name : TestIfElse
// File Name : if-else_t.v
// Function : Testing if-else.v
// Coder    : hydai
//-----------------------------------------------------

module TestIfElse;
    reg i_a, i_b, en;
    wire o_sum;
    integer i;
    If_Else_Block ieb(
        .o_sum(o_sum),
        .i_a(i_a),
        .i_b(i_b),
        .en(en)
    );
    initial begin
        $monitor("en = %d, i_a = %d, i_b = %d, o_sum = %d", en, i_a, i_b, o_sum);
        #10 en = 0;
        i_a = 0;
        i_b = 0;
        #10 en = 1;
        i_a = 1;
        for (i = 0; i < 10; i = i + 1) begin
            #10 i_a = ~i_a;
            i_b = ~i_b;
        end
        #20 i_a = 1;
        i_b = 1;
        for (i = 0; i < 10; i = i + 1) begin
            #10 i_a = ~i_a;
            i_b = ~i_b;
        end
    end
    
endmodule // End of TestIfElse


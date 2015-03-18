module example (a, b, out) begin
    always @ (posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            out = 0;
        end else begin
            out = (a&b) ^ (a|b);
        end
    end
end

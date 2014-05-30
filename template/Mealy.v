module Mealy (
    output out,
    input in,
    input clk,
    input reset_n
);
parameter S0 = 2'b00;
parameter S1 = 2'b01;
parameter S2 = 2'b10;
parameter S3 = 2'b11;
reg state, nextState;
reg out;
always @(posedge clk or negedge reset_n) begin
    if (!reset_n) begin
        state <= 0;
    end else begin
        state <= nextState;
    end
end

always @(*) begin
    case(state) 
        S0: begin
            if (in == 0) begin
                nextState <= S0;
                out <= 0;
            end else if (in == 1) begin
                nextState <= S1;
                out <= 1;
            end else begin
                nextState <= S0;
                out <= 0;
            end
        end
        S1: begin
            if (in == 0) begin
                nextState <= S1;
                out <= 0;
            end else if (in == 1) begin
                nextState <= S2;
                out <= 1;
            end else begin
                nextState <= S0;
                out <= 0;
            end
        end
        S2: begin
            if (in == 0) begin
                nextState <= S2;
                out <= 0;
            end else if (in == 1) begin
                nextState <= S3;
                out <= 1;
            end else begin
                nextState <= S0;
                out <= 0;
            end
        end
        S3: begin
            if (in == 0) begin
                nextState <= S3;
                out <= 0;
            end else if (in == 1) begin
                nextState <= S0;
                out <= 1;
            end else begin
                nextState <= S0;
                out <= 0;
            end
        end
    endcase
end


endmodule


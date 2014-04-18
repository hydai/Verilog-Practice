module Moore #(
    parameter width = 2)(
    output [width-1:0] out,
    input [width-1:0] in,
    input clk,
    input rst_n
);
parameter S0 = 2'b00;
parameter S1 = 2'b01;
parameter S2 = 2'b10;
parameter S3 = 2'b11;

reg [width-1:0] state, nextState;

always @(posedge clk, negedge rst_n) begin
    if (!rst_n) begin
        state <= S0;
    end else begin
        state <= nextState;
    end
end

always @(*) begin
    case(state) begin
        S0: begin
            if (in == 1) begin
                nextState <= S1;
            end else begin
                nextState <= S0;
            end
        end
        S1: begin
            if (in == 0) begin
                nextState <= S2;
            end else begin
                nextState <= S1;
            end
        end
        S2: begin
            if (in == 0) begin
                nextState <= S0;
            end else begin
                nextState <= S1;
            end
        end
        default: begin
            nextState <= S0;
        end
    endcase
end

assign out = (state == S2)?(1):(0);

endmodule

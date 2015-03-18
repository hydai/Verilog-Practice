module rrab (
    output reg [1:0] grant,
    input [1:0] request,
    input clk,
    input reset_n
);
    parameter S0 = 2'b00;
    parameter S1 = 2'b01;
    parameter S2 = 2'b10;
    parameter S3 = 2'b11;
    
    
    reg [1:0] grant_i;
    reg last_winner, winner;

    always @(posedge clk or negedge reset_n) begin
        if (!reset_n) begin
            last_winner <= 1'b0;
            grant       <= S0;
        end else begin
            last_winner <= winner;
            grant       <= grant_i;
        end
    end

    always @(*) begin
        case(request) 
            S0: begin
                grant_i = S0;
            end
            S1: begin
                grant_i = S1;
            end
            S2: begin
                grant_i = S2;
            end
            S3: begin
                if (last_winner == 1'b0) begin
                    grant_i = S2;
                end else begin
                    grant_i = S1;
                end
            end
        endcase
    end

    always @(*) begin
        if (grant_i == S0) begin
            winner = last_winner;
        end else begin
            winner = grant_i[1];
        end
    end
endmodule

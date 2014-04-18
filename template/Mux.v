module Mux (
    output out,
    input [1:0] sel,
    input [1:0] s0,
    input [1:0] s1,
    input [1:0] s2,
    input [1:0] s3
);
parameter S0 = 2'b00;
parameter S1 = 2'b01;
parameter S2 = 2'b10;
parameter S3 = 2'b11;

    always @(sel) begin
        case(sel) begin
            S0: begin
                out <= s0;
            end
            S1: begin
                out <= s1;
            end
            S2: begin
                out <= s2;
            end
            S3: begin
                out <= s3;
            end
        endcase
    end
    
endmodule


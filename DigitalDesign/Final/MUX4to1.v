module Mux4to1 (
    output reg  [31:0]  result,
    input       [1:0]   select,
    input       [31:0]  I0,
    input       [31:0]  I1,
    input       [31:0]  I2,
    input       [31:0]  I3,
);
parameter P0 = 2'b00;
parameter P1 = 2'b01;
parameter P2 = 2'b10;
parameter P3 = 2'b11;

    always @(*) begin
        case (select)
            P0: begin
                result = I0;
            end
            P1: begin
                result = I1;
            end
            P2: begin
                result = I2;
            end
            P3: begin
                result = I3;
            end
        endcase
    end
endmodule

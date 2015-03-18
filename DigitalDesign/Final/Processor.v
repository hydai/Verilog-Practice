module Processor (
    //TODO
);

// For PC
wire [31:0] next_PC, PCp1;
wire [1:0] PC_sel;
reg [31:0] IR, PC, PCn1, PCn2;
// For ID
input [31:0] instruction;
wire [4:0] AA, BA, DA;
reg [6:0] op;
reg [3:0] FS;
reg [1:0] MD, BS;
reg PS, RW, MW, MB, MA, CS;
parameter NOP   = 7'b0000000;
parameter MOVA  = 7'b1000000;
parameter ADD   = 7'b0000010;
parameter SUB   = 7'b0000101;
parameter AND   = 7'b0001000;
parameter OR    = 7'b0001001;
parameter XOR   = 7'b0001010;
parameter NOT   = 7'b0001011;
parameter ADI   = 7'b0100010;
parameter SBI   = 7'b0100101;
parameter ANI   = 7'b0101000;
parameter ORI   = 7'b0101001;
parameter XRI   = 7'b0101010;
parameter AIU   = 7'b1000010;
parameter SIU   = 7'b1000101;
parameter MOVB  = 7'b0001100;
parameter LSR   = 7'b0001101;
parameter LSL   = 7'b0001110;
parameter LD    = 7'b0010000;
parameter ST    = 7'b0100000;
parameter JMR   = 7'b1110000;
parameter SLT   = 7'b1100101;
parameter BZ    = 7'b1100000;
parameter BNZ   = 7'b1001000;
parameter JMP   = 7'b1101000;
parameter JML   = 7'b0110000;

// ====================================
// ProgramCounter - PC
assign PC_sel = {(BS[1]), (((PS^Z)|BS[1])&BS[0])};
assign PCp1 = PC + 1;
Mux4to1 MUXC (
    .result(next_PC),
    .select(PC_sel),
    .I0(PCp1),
    .I1(BrA),
    .I2(RAA),
    .I3(BrA)
);
always @(posedge clk or negedge reset_n) begin
    if (!reset_n) begin
        PC <= 0;
        PCn1 <= 0;
        PCn2 <= 0;
        IR <= 0;
    end else begin
        PCn2 <= PCn1;
        PCn1 <= PC;
        PC <= next_PC;
        IR <= instruction;
    end
end

// ====================================
// Instruction Decoder
assign AA = instruction[19:15];
assign BA = instruction[14:10];
assign DA = instruction[24:20];
always @(*) begin
    case(instruction[31:25]) 
        JML: begin
            op = JMP;
            RW = 1'b1;
            MD = 2'b00;
            BS = 2'b11;
            PS = 1'bX;
            MW = 1'b0;
            FS = 4'b0000;
            MB = 1'b1;
            MA = 1'b1;
            CS = 1'b1;
        end
        JMP: begin
            op = JMP;
            RW = 1'b0;
            MD = 2'bXX;
            BS = 2'b11;
            PS = 1'bX;
            MW = 1'b0;
            FS = 4'bXXXX;
            MB = 1'b1;
            MA = 1'bX;
            CS = 1'b1;
        end
        BNZ: begin
            op = BNZ;
            RW = 1'b0;
            MD = 2'bXX;
            BS = 2'b01;
            PS = 1'b1;
            MW = 1'b0;
            FS = 4'b0000;
            MB = 1'b1;
            MA = 1'b0;
            CS = 1'b1;
        end
        BZ: begin
            op = BZ;
            RW = 1'b0;
            MD = 2'bXX;
            BS = 2'b01;
            PS = 1'b0;
            MW = 1'b0;
            FS = 4'b0000;
            MB = 1'b1;
            MA = 1'b0;
            CS = 1'b1;
        end
        JMR: begin
            op = JMR;
            RW = 1'b0;
            MD = 2'bXX;
            BS = 2'b10;
            PS = 1'bX;
            MW = 1'b0;
            FS = 4'bXXXX;
            MB = 1'bX;
            MA = 1'b0;
            CS = 1'bX;
        end
        ST: begin
            op = ST;
            RW = 1'b0;
            MD = 2'bXX;
            BS = 2'b00;
            PS = 1'bX;
            MW = 1'b1;
            FS = 4'bXXXX;
            MB = 1'b0;
            MA = 1'b0;
            CS = 1'bX;
        end
        LD: begin
            op = LD;
            RW = 1'b1;
            MD = 2'b01;
            BS = 2'b00;
            PS = 1'bX;
            MW = 1'b0;
            FS = 4'bXXXX;
            MB = 1'bX;
            MA = 1'b0;
            CS = 1'bX;
        end
        LSL: begin
            op = LSL;
            RW = 1'b1;
            MD = 2'b00;
            BS = 2'b00;
            PS = 1'bX;
            MW = 1'b0;
            FS = 4'b1110;
            MB = 1'bX;
            MA = 1'b0;
            CS = 1'bX;
        end
        LSR: begin
            op = LSR;
            RW = 1'b1;
            MD = 2'b00;
            BS = 2'b00;
            PS = 1'bX;
            MW = 1'b0;
            FS = 4'b1101;
            MB = 1'bX;
            MA = 1'b0;
            CS = 1'bX;
        end
        MOVB: begin
            op = MOVB;
            RW = 1'b1;
            MD = 2'b00;
            BS = 2'b00;
            PS = 1'bX;
            MW = 1'b0;
            FS = 4'b1100;
            MB = 1'b0;
            MA = 1'bX;
            CS = 1'bX;
        end
        SIU: begin
            op = SIU;
            RW = 1'b1;
            MD = 2'b00;
            BS = 2'b00;
            PS = 1'bX;
            MW = 1'b0;
            FS = 4'b0101;
            MB = 1'b1;
            MA = 1'b0;
            CS = 1'b0;
        end
        AIU: begin
            op = AIU;
            RW = 1'b1;
            MD = 2'b00;
            BS = 2'b00;
            PS = 1'bX;
            MW = 1'b0;
            FS = 4'b0010;
            MB = 1'b1;
            MA = 1'b0;
            CS = 1'b0;
        end
        XRI: begin
            op = XRI;
            RW = 1'b1;
            MD = 2'b00;
            BS = 2'b00;
            PS = 1'bX;
            MW = 1'b0;
            FS = 4'b1010;
            MB = 1'b1;
            MA = 1'b0;
            CS = 1'b0;
        end
        ORI: begin
            op = ORI;
            RW = 1'b1;
            MD = 2'b00;
            BS = 2'b00;
            PS = 1'bX;
            MW = 1'b0;
            FS = 4'b1001;
            MB = 1'b1;
            MA = 1'b0;
            CS = 1'b0;
        end
        ANI: begin
            op = ANI;
            RW = 1'b1;
            MD = 2'b00;
            BS = 2'b00;
            PS = 1'bX;
            MW = 1'b0;
            FS = 4'b1000;
            MB = 1'b1;
            MA = 1'b0;
            CS = 1'b0;
        end
        SBI: begin
            op = SBI;
            RW = 1'b1;
            MD = 2'b00;
            BS = 2'b00;
            PS = 1'bX;
            MW = 1'b0;
            FS = 4'b0101;
            MB = 1'b1;
            MA = 1'b0;
            CS = 1'b1;
        end
        ADI: begin
            op = ADI;
            RW = 1'b1;
            MD = 2'b00;
            BS = 2'b00;
            PS = 1'bX;
            MW = 1'b0;
            FS = 4'b0010;
            MB = 1'b1;
            MA = 1'b0;
            CS = 1'b1;
        end
        NOT: begin
            op = NOT;
            RW = 1'b1;
            MD = 2'b00;
            BS = 2'b00;
            PS = 1'bX;
            MW = 1'b0;
            FS = 4'b1011;
            MB = 1'bX;
            MA = 1'b0;
            CS = 1'bX;
        end
        XOR: begin
            op = XOR;
            RW = 1'b1;
            MD = 2'b00;
            BS = 2'b00;
            PS = 1'bX;
            MW = 1'b0;
            FS = 4'b1010;
            MB = 1'b0;
            MA = 1'b0;
            CS = 1'bX;
        end
        OR: begin
            op = OR;
            RW = 1'b1;
            MD = 2'b00;
            BS = 2'b00;
            PS = 1'bX;
            MW = 1'b0;
            FS = 4'b1001;
            MB = 1'b0;
            MA = 1'b0;
            CS = 1'bX;
        end
        AND: begin
            op = AND;
            RW = 1'b1;
            MD = 2'b00;
            BS = 2'b00;
            PS = 1'bX;
            MW = 1'b0;
            FS = 4'b1000;
            MB = 1'b0;
            MA = 1'b0;
            CS = 1'bX;
        end
        SUB: begin
            op = SUB;
            RW = 1'b1;
            MD = 2'b00;
            BS = 2'b00;
            PS = 1'bX;
            MW = 1'b0;
            FS = 4'b0101;
            MB = 1'b0;
            MA = 1'b0;
            CS = 1'bX;
        end
        ADD: begin
            op = ADD;
            RW = 1'b1;
            MD = 2'b00;
            BS = 2'b00;
            PS = 1'bX;
            MW = 1'b0;
            FS = 4'b0010;
            MB = 1'b0;
            MA = 1'b0;
            CS = 1'bX;
        end
        MOVA: begin
            op = MOVA;
            RW = 1'b1;
            MD = 2'b00;
            BS = 2'b00;
            PS = 1'bX;
            MW = 1'b0;
            FS = 4'b0000;
            MB = 1'bX;
            MA = 1'b0;
            CS = 1'bX;
        end
        default: begin
            op = 7'b0000000;
            RW = 1'b0;
            MD = 2'bXX;
            BS = 2'b00;
            PS = 1'bX;
            MW = 1'b0;
            FS = 4'bXXXX;
            MB = 1'bX;
            MA = 1'bX;
            CS = 1'bX;
        end
    endcase
end


endmodule


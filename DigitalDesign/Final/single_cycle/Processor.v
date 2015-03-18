module SingleCycleProcessor (
    output reg [31:0] PC,
    output reg [31:0] datain,
    output reg [31:0] address,
    output reg MW,
    input [31:0] instruction,
    input [31:0] dataout,
    input clk,
    input reset_n
);
reg [31:0] nextPC, counter, nextReg, seIM, zfIM;
reg [31:0] R[0:31];
reg RW;
wire [14:0] IM;
wire [4:0] AA, BA, DA;
wire [6:0] op;
wire [3:0] FS;
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
integer i;
// PC
always @(posedge clk or negedge reset_n) begin
    if (!reset_n) begin
        counter <= 0;
        PC <= 0;
        for (i = 0; i < 32; i = i + 1) begin
            R[i] = 0;
        end
    end else begin
        if (counter == 0) begin
            counter <= counter + 1;
            PC <= nextPC;
        end else begin
            counter <= 0;
            PC <= nextPC;
            if (RW == 1'b1 && DA != 0) begin
                R[DA] = nextReg;
            end
        end
    end
end
// Decoder
assign AA = instruction[19:15];
assign BA = instruction[14:10];
assign DA = instruction[24:20];
assign op = instruction[31:25];
assign IM = instruction[14:0];
assign SH = instruction[4:0];
always @(*) begin
    if (IM[14] == 1'b0) begin
        seIM = {17'd0, IM};
        zfIM = {17'd0, IM};
    end else begin
        seIM = {17'd1, IM};
        zfIM = {17'd0, IM};
    end
end

always @(*) begin
    RW = 1'b0;
    MW = 1'b1;
    nextReg = 0;
    address = 0;
    datain = 0;
    if (counter == 1) begin
        case(op)
            MOVA: begin
                nextReg = R[AA];
                RW = 1'b1;
            end
            ADD: begin
                nextReg = R[AA] + R[BA];
                RW = 1'b1;
            end
            SUB: begin
                nextReg = R[AA] + (~R[BA]) + 1;
                RW = 1'b1;
            end
            AND: begin
                nextReg = R[AA] & R[BA];
                RW = 1'b1;
            end
            OR: begin
                nextReg = R[AA] | R[BA];
                RW = 1'b1;
            end
            XOR: begin
                nextReg = R[AA] ^ R[BA];
                RW = 1'b1;
            end
            NOT: begin
                nextReg = ~R[AA];
                RW = 1'b1;
            end
            ADI: begin
                nextReg = R[AA] + seIM;
                RW = 1'b1;
            end
            SBI: begin
                nextReg = R[AA] + (~seIM) + 1;
                RW = 1'b1;
            end
            ANI: begin
                nextReg = R[AA] & zfIM;
                RW = 1'b1;
            end
            ORI: begin
                nextReg = R[AA] | zfIM;
                RW = 1'b1;
            end
            XRI: begin
                nextReg = R[AA] ^ zfIM;
                RW = 1'b1;
            end
            AIU: begin
                nextReg = R[AA] + zfIM;
                RW = 1'b1;
            end
            SIU: begin
                nextReg = R[AA] + (~zfIM) + 1;
                RW = 1'b1;
            end
            MOVB: begin
                nextReg = R[BA];
                RW = 1'b1;
            end
            LSR: begin
                nextReg = R[AA] >> SH;
                RW = 1'b1;
            end
            LSL: begin
                nextReg = R[AA] << SH;
                RW = 1'b1;
            end
            LD: begin
                nextReg = dataout;
                RW = 1'b1;
            end
            ST: begin
                address = R[AA];
                datain = R[BA];
                MW = 1'b0;
            end
            SLT: begin
                if (R[AA] < R[BA]) begin
                    nextReg = 1;
                    RW = 1'b1;
                end else begin
                    nextReg = 0;
                    RW = 1'b1;
                end
            end
            JMR: begin
                nextPC = R[AA];
            end
            JMP: begin
                nextPC = PC + 1 + seIM;
            end
            JML: begin
                nextPC = PC + 1 + seIM;
            end
            BZ: begin
                if (R[AA] == 0)
                    nextPC = PC + 1 + seIM;
                else
                    nextPC = PC + 1;
            end
            BNZ: begin
                if (R[AA] != 0)
                    nextPC = PC + 1 + seIM;
                else
                    nextPC = PC + 1;
            end
            default: begin
                nextPC = PC + 1;
            end
        endcase
    end else begin
        if (op == LD) begin
            address = R[AA];
            MW = 1'b1;
        end
        nextPC = PC;
    end
end


endmodule

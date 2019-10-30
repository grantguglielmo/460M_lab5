module SegDisplay(Key, CLK, SEGS, Digit);
input CLK;
input[7:0] Key;
output[6:0] SEGS;
output[3:0] Digit;
wire dig;
wire[3:0] S1;
reg start;
reg Select;
reg [18:0] cnt;
reg [3:0] Digit;

initial begin
    start = 0;
    Digit = 4'b1111;
    Select = 0;
    cnt = 0;
end

assign dig = cnt[18];

MUX2 mux(Key[3:0], Key[7:4], Select, S1);
SEG7 seg(S1, CLK, SEGS);

always @(posedge CLK) begin
    cnt <= cnt + 1;
    if(Key != 0) begin
        start <= 1;
    end
    else begin end
    //Display refresh
    if(start) begin
        case(dig)
            2'b0 : begin
                        Digit <= 4'b1110;
                        Select <= 0;
                    end
            2'b1 : begin
                        Digit <= 4'b1101;
                        Select <= 1;
                    end
        endcase
    end
    else begin end
end
endmodule

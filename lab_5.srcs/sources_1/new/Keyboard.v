module Keyboard(PS2Clk, PS2Data, Key, LED);
input PS2Clk, PS2Data;
output LED;
output[7:0] Key;
reg LED;
reg[18:0] cnt;
reg[7:0] NxtKey;
reg[3:0] bits;
reg[10:0] ShiftReg;
reg[7:0] PrevKey;

initial begin
    bits <= 0;
    cnt <= 0;
    LED <= 0;
    NxtKey <= 0;
    ShiftReg <= 0;
end

assign Key = NxtKey;

always@(negedge PS2Clk) begin
    bits = bits + 1;
    ShiftReg = {PS2Data, ShiftReg[10:1]};
    if(bits == 11) begin
        if(PrevKey == 8'hF0) begin
            NxtKey = ShiftReg[8:1];
            LED = 1;
            cnt = 18'b011111111111111111;
        end
        else begin end
        PrevKey = ShiftReg[8:1];
        bits = 0;
    end
    else begin end
    
    if(cnt > 1) begin
        cnt = cnt - 1;
    end
    else if(cnt == 1) begin
        LED = 0;
        cnt = 0;
    end
    else begin end
end

endmodule
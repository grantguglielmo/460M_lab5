module KeyDecode(Key, btns, Pause, Start, Esc, L, R, U, D);
input[7:0] Key;
input[4:0] btns;
output Pause, Start, Esc, L, R, U, D;

assign Pause = Key == 8'h4D;
assign Start = Key == 8'h1B || btns[4];
assign Esc = Key == 8'h76;
assign L = Key == 8'h6B || btns[3];
assign R = Key == 8'h74 || btns[1];
assign U = Key == 8'h75 || btns[0];
assign D = Key == 8'h72 || btns[2];

endmodule

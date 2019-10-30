module KeyDecode(Key, Pause, Start, Esc, L, R, U, D);
input[7:0] Key;
output Pause, Start, Esc, L, R, U, D;

assign Pause = Key == 8'h4D;
assign Start = Key == 8'h1B;
assign Esc = Key == 8'h76;
assign L = Key == 8'h6B;
assign R = Key == 8'h74;
assign U = Key == 8'h75;
assign D = Key == 8'h72;

endmodule

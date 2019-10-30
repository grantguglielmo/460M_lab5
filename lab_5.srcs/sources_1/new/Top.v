module Top(PS2Clk, PS2Data, CLK, sw, LED, SEGS, Digit, hsync, vsync, R, G, B);
input PS2Clk, PS2Data, CLK;
input[7:0] sw;
output LED;
output hsync, vsync;
output[3:0] R, G, B;
output[6:0] SEGS;
output[3:0] Digit;
wire[7:0] Key;
wire pixelClk;
wire drawSnake;
wire[9:0] Xpos, Ypos;

Keyboard kb(PS2Clk, PS2Data, Key, LED);     //Retrieve keyboard input
SegDisplay sd(Key, CLK, SEGS, Digit);       //Display key pressed
ClkDivider cd(CLK, pixelClk);               //Return 25Mhz clock
Snake sk(Key, CLK, pixelClk, Xpos, Ypos, drawSnake);        //Determine if snake at current pixel, and control snake
vgaController vga(pixelClk, sw, drawSnake, hsync, vsync, R, G, B, Xpos, Ypos);      //Draw pixels

endmodule

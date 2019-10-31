/*
 * Clock divider is used for pixel clock
*/
module ClkDivider(clk100Mhz, clk25Mhz, clk5hz);
  input clk100Mhz; //fast clock
  output clk25Mhz; //slow clock
  output clk5hz;

  reg[1:0] counter;
  reg[25:0] cnt2;
  assign clk25Mhz = counter[1];
  assign clk5hz = cnt2 == 0;

  initial begin
    counter = 0;
    cnt2 = 0;
  end

  always @ (posedge clk100Mhz)
  begin
    counter <= counter + 1; //increment the counter every 10ns (1/100 Mhz) cycle.
    cnt2 = cnt2 + 1;
    if(cnt2 == 19999999) begin
        cnt2 = 0;
    end
  end

endmodule
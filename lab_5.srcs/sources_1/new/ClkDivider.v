/*
 * Clock divider is used for pixel clock
*/
module ClkDivider(clk100Mhz, clk25Mhz);
  input clk100Mhz; //fast clock
  output clk25Mhz; //slow clock

  reg[1:0] counter;
  assign clk25Mhz = counter[1];

  initial begin
    counter = 0;
  end

  always @ (posedge clk100Mhz)
  begin
    counter <= counter + 1; //increment the counter every 10ns (1/100 Mhz) cycle.
  end

endmodule
module SEG7(BCD, CLK, OUT);
input CLK;
input [3:0] BCD;
output [6:0] OUT;
reg [6:0] OUT;

always @(posedge CLK) begin
	case(BCD)
		4'b0000 : OUT = 7'b1000000;	//0
		4'b0001 : OUT = 7'b1111001;	//1
		4'b0010 : OUT = 7'b0100100;	//2
		4'b0011 : OUT = 7'b0110000;	//3
		4'b0100 : OUT = 7'b0011001;	//4
		4'b0101 : OUT = 7'b0010010;	//5
		4'b0110 : OUT = 7'b0000010;	//6
		4'b0111 : OUT = 7'b1111000;	//7
		4'b1000 : OUT = 7'b0000000;	//8
		4'b1001 : OUT = 7'b0010000;	//9
		4'b1010 : OUT = 7'b0001000;	//A
		4'b1011 : OUT = 7'b0000011;	//b
		4'b1100 : OUT = 7'b1000110;	//C
		4'b1101 : OUT = 7'b0100001;	//d
		4'b1110 : OUT = 7'b0000110;	//E
		4'b1111 : OUT = 7'b0001110;	//F
	endcase
end
endmodule

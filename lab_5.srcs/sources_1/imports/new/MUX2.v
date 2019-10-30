module MUX2(In1, In2, Sel, OUT);
input [3:0] In1, In2;
input Sel;
output [3:0] OUT;
reg [3:0] OUT;

always @(*) begin
    case(Sel)
        1'b0 : OUT = In1;
        1'b1 : OUT = In2;
    endcase
end
endmodule

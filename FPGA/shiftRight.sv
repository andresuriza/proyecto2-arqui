module shiftRight(a, c);
    input [18:0] a;
    output [18:0] c;

	 assign c = (a == 19'b1) ? 19'b0 : (a >> 1);
endmodule

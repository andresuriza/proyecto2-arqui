module shiftRight(a, c);
    input [15:0] a;
    output [15:0] c;

	 assign c = (a == 16'b1) ? 16'b0 : (a >> 1);
endmodule

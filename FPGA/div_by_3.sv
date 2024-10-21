module div_by_3(a, c);
    input [18:0] a;
    output [18:0] c;

    assign c = (a == 19'd1) ? 19'd0000000000000000 : ((a == 19'd2) ? 19'd1 : (a / 3));
	 
endmodule

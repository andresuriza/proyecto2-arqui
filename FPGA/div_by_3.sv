module div_by_3(
    input logic [15:0] a,
    output logic [15:0] c);

    assign c = (a == 16'd1) ? 16'd0000000000000000 : ((a == 16'd2) ? 16'd1 : (a / 3));
	 
endmodule

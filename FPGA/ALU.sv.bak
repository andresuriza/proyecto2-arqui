module ALU(
    input logic[15:0]A,B,
    input logic[2:0]ALUControl,
    output logic Carry,OverFlow,Zero,Negative,
    output logic[15:0]Result);

    logic [15:0] ResultSub, ResultAdd, ResultMul, ResultDiv, ResultAnd, ResultSLeft, ResultSRight;
	 
	 sub subDut(
		.a(A),
		.b(B),
		.c(ResultSub)
	 );
	 
	 add addDut(
		.a(A),
		.b(B),
		.c(ResultAdd)
	 );
	 
	 mult multDut(
		.a(A),
		.b(B),
		.c(ResultMul)
	 );
	 
	 div_by_3 div_by_3Dut(
		.a(A),
		.c(ResultDiv)
	 );
	 
	 and_ and_Dut(
		.a(A),
		.b(B),
		.c(ResultAnd)
	 );
	 
	 shiftLeft shiftLeftDut(
		.a(A),
		.c(ResultSLeft)
	 );
	 
	 shiftRight shiftRightDut(
		.a(A),
		.c(ResultSRight)
	 );
	 
	 // Hacer b111
    assign Result = (ALUControl == 3'b000) ? ResultSub :
                           (ALUControl == 3'b001) ? ResultAdd :
                           (ALUControl == 3'b010) ? ResultMul :
                           (ALUControl == 3'b011) ? ResultDiv :
									(ALUControl == 3'b100) ? ResultAnd :
                           (ALUControl == 3'b101) ? ResultSLeft:
									(ALUControl == 3'b110) ? ResultSRight:
									16'b0;
   
    assign Zero = &(~Result);

endmodule
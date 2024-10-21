module writeback(input logic clk, rst, ResultSrcW,
							  input logic [31:0] PCPlus4W, ALU_ResultW, ReadDataW,
							  output logic [31:0] ResultW);

// Declaration of Module
Mux result_mux (    
                .a(ALU_ResultW),
                .b(ReadDataW),
                .s(ResultSrcW),
                .c(ResultW)
                );
endmodule
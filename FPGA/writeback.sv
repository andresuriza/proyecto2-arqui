module writeback(input logic clk, rst, ResultSrcW,
							  input logic [31:0] PCPlus4W,
							  input logic [18:0] ALU_ResultW, ReadDataW,
							  output logic [18:0] ResultW);

Mux result_mux (    
                .a(ALU_ResultW),
                .b(ReadDataW),
                .c(ResultSrcW),
                .y(ResultW)
                );
endmodule
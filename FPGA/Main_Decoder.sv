module Main_Decoder(input logic [3:0]Op,
							 output logic RegWrite,ALUSrc,MemWrite,ResultSrc,Branch,
							 output logic [1:0]ImmSrc,ALUOp);

	// Activa escritura de registros
    assign RegWrite = (Op == 4'b0001 | Op == 4'b0111 | Op == 4'b0000
							| Op == 4'b0010 | Op == 4'b0011 | Op == 4'b0100 | Op == 4'b0101
			            | Op == 4'b0110 | Op == 4'b0111 | Op == 4'b1000) ? 1'b1 : 1'b0;
							
	// Si el inmediato es offset o numero                   
    assign ImmSrc = (Op == 4'b1010 | Op == 4'b1001) ? 2'b01 : (Op == 4'1000 | Op == 4'b0111 
	 | Op == 4'b1001 | Op == 4'b1011 | Op == 4'b1100 | Op == 4'b1101 | Op == 4'b1010) ? 2'b00 : 2'b10
	 
	 // Indica si operacion utiliza inmediato o registro
    assign ALUSrc = (Op == 4'1000 | Op == 4'b0111 | Op == 4'b1001 | Op == 4'b1011 
	 | Op == 4'b1100 | Op == 4'b1101 | Op == 4'b1010) ? 1'b1 : 1'b0;
	 
	 // Escribe a memoria
    assign MemWrite = (Op == 4'b1010) ? 1'b1 : 1'b0;
	                  
	// Si es 1 el resultado es de memoria						
    assign ResultSrc = (Op == 4'b1001) ? 1'b1 : 1'b0;
	
	// Si la instruccion es un branch
    assign Branch = (Op == 7'b1100 | Op == 7'b1101) ? 1'b1 : 1'b0;
	 
endmodule
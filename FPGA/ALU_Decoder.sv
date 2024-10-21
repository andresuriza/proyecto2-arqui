module alu_decoder(input logic [1:0]ALUOp,
						 input logic [3:0] op,
						 output logic [2:0]ALUControl);

    assign ALUControl = (op == 4'b0000) ? 3'b000 : // bSub
                        (op == 4'b0001) ? 3'b001 : // bAdd
								(op == 4'b0010) ? 3'b010 : // bMul
								(op == 4'b0011) ? 3'b011 : // bDiv
								(op == 4'b0100) ? 3'b100 : // bAnd
								(op == 4'b0101) ? 3'b101 : // bSLL
								(op == 4'b0110) ? 3'b110 : // 
								(op == 4'b0111)? 3'b001 : // addi
								(op == 4'b1000)? 3'b001 :
								(op == 4'b1100)? 3'b000 :
								(op == 4'b1101)? 3'b111 : 3'b000;
endmodule
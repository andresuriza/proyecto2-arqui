module Control_Unit_Top(input logic [3:0]Op,
								 output logic RegWrite,ALUSrc,MemWrite,ResultSrc,Branch,
								 output logic [1:0]ImmSrc,
								 output logic [2:0]ALUControl);

    logic [1:0]ALUOp;

    Main_Decoder Main_Decoder(
                .Op(Op),
                .RegWrite(RegWrite),
                .ImmSrc(ImmSrc),
                .MemWrite(MemWrite),
                .ResultSrc(ResultSrc),
                .Branch(Branch),
                .ALUSrc(ALUSrc),
                .ALUOp(ALUOp)
    );

    ALU_Decoder ALU_Decoder(
                            .ALUOp(ALUOp),
                            .op(Op),
                            .ALUControl(ALUControl)
    );


endmodule
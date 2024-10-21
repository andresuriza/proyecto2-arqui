module control_unit(input logic [3:0]Op,
								 output logic RegWrite,ALUSrc,MemWrite,ResultSrc,Branch,
								 output logic [1:0]ImmSrc,
								 output logic [2:0]ALUControl);

    logic [1:0]ALUOp;

    control_decoder Main_Decoder(
                .Op(Op),
                .RegWrite(RegWrite),
                .ImmSrc(ImmSrc),
                .MemWrite(MemWrite),
                .ResultSrc(ResultSrc),
                .Branch(Branch),
                .ALUSrc(ALUSrc),
                .ALUOp(ALUOp)
    );

    alu_decoder alu_deco(
                            .ALUOp(ALUOp),
                            .op(Op),
                            .ALUControl(ALUControl)
    );


endmodule
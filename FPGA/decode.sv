module decode(input logic clk, rst, RegWriteW,
							 input logic [4:0] RDW,
							 input logic [31:0] InstrD, PCD, PCPlus4D, ResultW,
							 output logic RegWriteE,ALUSrcE,MemWriteE,ResultSrcE,BranchE,
							 output logic [2:0] ALUControlE,
							 output logic [31:0] RD1_E, RD2_E, Imm_Ext_E,
							 output logic [4:0] RS1_E, RS2_E, RD_E,
							 output logic [31:0] PCE, PCPlus4E);

    logic RegWriteD,ALUSrcD,MemWriteD,ResultSrcD,BranchD;
    logic [1:0] ImmSrcD;
    logic [2:0] ALUControlD;
    logic [31:0] RD1_D, RD2_D, Imm_Ext_D;

    logic RegWriteD_r,ALUSrcD_r,MemWriteD_r,ResultSrcD_r,BranchD_r;
    logic [2:0] ALUControlD_r;
    logic [31:0] RD1_D_r, RD2_D_r, Imm_Ext_D_r;
    logic [4:0] RD_D_r, RS1_D_r, RS2_D_r;
    logic [31:0] PCD_r, PCPlus4D_r;

    control_unit control (
                            .Op(InstrD[3:0]), // Opcode
                            .RegWrite(RegWriteD),
                            .ImmSrc(ImmSrcD),
                            .ALUSrc(ALUSrcD),
                            .MemWrite(MemWriteD),
                            .ResultSrc(ResultSrcD),
                            .Branch(BranchD),
                            .ALUControl(ALUControlD)
                            );
    register_file rf (
                        .clk(clk),
                        .rst(rst),
                        .WE3(RegWriteW),
                        .WD3(ResultW),
                        .A1(InstrD[23:20]),
                        .A2(InstrD[19:16]),
                        .A3(RDW),
                        .RD1(RD1_D),
                        .RD2(RD2_D)
                        );

// Calcula inmediato								
    Sign_Extend extension (
                        .In(InstrD[31:0]),
                        .Imm_Ext(Imm_Ext_D),
                        .ImmSrc(ImmSrcD)
                        );

    // Declaring Register Logic
    always @(posedge clk or negedge rst) begin
        if(rst == 1'b0) begin
            RegWriteD_r <= 1'b0;
            ALUSrcD_r <= 1'b0;
            MemWriteD_r <= 1'b0;
            ResultSrcD_r <= 1'b0;
            BranchD_r <= 1'b0;
            ALUControlD_r <= 3'b000;
            RD1_D_r <= 32'h00000000; 
            RD2_D_r <= 32'h00000000; 
            Imm_Ext_D_r <= 32'h00000000;
            RD_D_r <= 5'h00;
            PCD_r <= 32'h00000000; 
            PCPlus4D_r <= 32'h00000000;
            RS1_D_r <= 5'h00;
            RS2_D_r <= 5'h00;
        end
        else begin
            RegWriteD_r <= RegWriteD;
            ALUSrcD_r <= ALUSrcD;
            MemWriteD_r <= MemWriteD;
            ResultSrcD_r <= ResultSrcD;
            BranchD_r <= BranchD;
            ALUControlD_r <= ALUControlD;
            RD1_D_r <= RD1_D; 
            RD2_D_r <= RD2_D; 
            Imm_Ext_D_r <= Imm_Ext_D;
            RD_D_r <= InstrD[7:4];
            PCD_r <= PCD; 
            PCPlus4D_r <= PCPlus4D;
            RS1_D_r <= InstrD[23:20];
            RS2_D_r <= InstrD[19:16];
        end
    end

    // Output asssign statements
    assign RegWriteE = RegWriteD_r;
    assign ALUSrcE = ALUSrcD_r;
    assign MemWriteE = MemWriteD_r;
    assign ResultSrcE = ResultSrcD_r;
    assign BranchE = BranchD_r;
    assign ALUControlE = ALUControlD_r;
    assign RD1_E = RD1_D_r;
    assign RD2_E = RD2_D_r;
    assign Imm_Ext_E = Imm_Ext_D_r;
    assign RD_E = RD_D_r;
    assign PCE = PCD_r;
    assign PCPlus4E = PCPlus4D_r;
    assign RS1_E = RS1_D_r;
    assign RS2_E = RS2_D_r;

endmodule
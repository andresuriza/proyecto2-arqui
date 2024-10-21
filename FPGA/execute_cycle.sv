module execute_cycle(input logic clk, rst, RegWriteE,ALUSrcE,MemWriteE,ResultSrcE,BranchE,
							input logic [2:0] ALUControlE,
							input logic [31:0] RD1_E, RD2_E, Imm_Ext_E,
							input logic [4:0] RD_E,
							input logic [31:0] PCE, PCPlus4E,
							input logic [31:0] ResultW,
							input logic [1:0] ForwardA_E, ForwardB_E,
							output logic PCSrcE, RegWriteM, MemWriteM, ResultSrcM,
							output logic [4:0] RD_M,
							output logic [31:0] PCPlus4M, WriteDataM, ALU_ResultM,
							output logic [31:0] PCTargetE);

    logic [31:0] Src_A, Src_B_interim, Src_B;
    logic [31:0] ResultE;
    logic ZeroE;

    logic RegWriteE_r, MemWriteE_r, ResultSrcE_r;
    logic [4:0] RD_E_r;
    logic [31:0] PCPlus4E_r, RD2_E_r, ResultE_r;

	 		//INPUTS
    //RegWriteE: si se debe escribir en registro.
	 //ALUSrcE: indica si segundo operando viene de registro o inmediato extendido.
	 //MemWriteE: indica si se debe escribir en memoria, usado en store.
	 //ResultSrcE: establece cuál resultado se usa para escribir en el registro, ya sea el proveniente de la ALU o de la memoria.
	 //BranchE: indica si se debe de tomar un salto de acuerdo a la salida de la ALU.
	 //ALUControlE: determina operación que realiza la ALU.
	 //RD1E: operando 1.
	 //RD2E: operando 2.
	 //Imm_Ext_E: valor inmediato extendido.
	 //RD_E: dirección del registro en el que se anota el resultado.
	 //PCE: valor actual del contador del programa.
	 //PCPlus4E: apunta a la siguiente instrucción, en caso de sin saltos.
	 //ResultW: resultado de la escritura en la etapa anterior.
	 //ForwardA_E, ForwardB_E: señales de control para evitar hazards de datos al enviar los resultados previos de la ALU como
	 //operandos en la nueva etapa.
	 
		//OUTPUTS
	 //PCSrcE: indica si el flujo de control cambia si el resultado de la ALU es cero y BranchE está activo.
	 //RegWriteM: si se debe escribir en registro en la etapa de escritura.
	 //MemWriteM: indica si se debe escribir en memoria, también almacenada en registro.
	 //ResultSrcM: establece cuál resultado se usa para escribir en el registro, ya sea el proveniente de la ALU o de la memoria.
	 //RD_M: dirección del registro en el que se anota el resultado.
	 //PCPlus4M: apunta a la siguiente instrucción, en caso de sin saltos.
	 //WriteDataM: datos que se escribirán en memoria, que son el segundo operando de la ALU.
	 //ALU_ResultM: Resultado de la operación de la ALU.
	 //PCTargetE: Dirección a la que se debe saltar, calculada a partir de PCE y Imm_Ext_E.
	 
		//WIRES
	 //Src_A: Primer operando de la ALU.
	 //Src_B_interim: Segundo operando intermedio antes de pasar a la ALU.
    //Src_B: Segundo operando final para la ALU.
    //ResultE: Resultado de la ALU.
    //ZeroE: Bandera que indica si el resultado de la ALU es cero.
	 
    //SrcA
	 Mux_3_by_1 srca_mux (
                        .a(RD1_E),
                        .b(ResultW),
                        .c(ALU_ResultM),
                        .s(ForwardA_E),
                        .d(Src_A)
                        );

    //SrcB_interim
    Mux_3_by_1 srcb_mux (
                        .a(RD2_E),
                        .b(ResultW),
                        .c(ALU_ResultM),
                        .s(ForwardB_E),
                        .d(Src_B_interim)
                        );
    //srcB
    Mux alu_src_mux (
            .a(Src_B_interim),
            .b(Imm_Ext_E),
            .s(ALUSrcE),
            .c(Src_B)
            );

    // ALU Unit
    ALU alu (
            .A(Src_A),
            .B(Src_B),
            .Result(ResultE),
            .ALUControl(ALUControlE),
            .OverFlow(),
            .Carry(),
            .Zero(ZeroE),
            .Negative()
            );

    // Adder branch
    PC_Adder branch_adder (
            .a(PCE),
            .b(Imm_Ext_E),
            .c(PCTargetE)
            );

    // Register Logic
    always @(posedge clk or negedge rst) begin
        if(rst == 1'b0) begin
            RegWriteE_r <= 1'b0; 
            MemWriteE_r <= 1'b0; 
            ResultSrcE_r <= 1'b0;
            RD_E_r <= 5'h00;
            PCPlus4E_r <= 32'h00000000; 
            RD2_E_r <= 32'h00000000; 
            ResultE_r <= 32'h00000000;
        end
        else begin
            RegWriteE_r <= RegWriteE; 
            MemWriteE_r <= MemWriteE; 
            ResultSrcE_r <= ResultSrcE;
            RD_E_r <= RD_E;
            PCPlus4E_r <= PCPlus4E; 
            RD2_E_r <= Src_B_interim; 
            ResultE_r <= ResultE;
        end
    end

    // Output Assignments
//	 assign PCSrcE = ZeroE &  BranchE;
    assign PCSrcE = (rst == 1'b0) ? 1'b0 : ZeroE &  BranchE;
    assign RegWriteM = RegWriteE_r;
    assign MemWriteM = MemWriteE_r;
    assign ResultSrcM = ResultSrcE_r;
    assign RD_M = RD_E_r;
    assign PCPlus4M = PCPlus4E_r;
    assign WriteDataM = RD2_E_r;
    assign ALU_ResultM = ResultE_r;

endmodule
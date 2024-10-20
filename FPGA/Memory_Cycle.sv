// ciclo de la memoria, 
module memory_cycle(input logic clk, rst, RegWriteM, MemWriteM, ResultSrcM,
						  input logic [4:0] RD_M, 
						  input logic [31:0] PCPlus4M, WriteDataM, ALU_ResultM,
						  output logic RegWriteW, ResultSrcW, 
						  output logic [4:0] RD_W,
						  output logic [31:0] PCPlus4W, ALU_ResultW, ReadDataW);

    // Declaración de señales intermedias
	 
    logic [31:0] ReadDataM;

    // Declaración de registros intermedios
	 
    logic RegWriteM_r, ResultSrcM_r;
    logic [4:0] RD_M_r;
    logic [31:0] PCPlus4M_r, ALU_ResultM_r, ReadDataM_r;


    // Inicialización del modulo de la memoria

    Data_Memory dmem (
                        .clk(clk),    // clock
                        .rst(rst),    // reset
                        .WE(MemWriteM), // write enable
                        .WD(WriteDataM), // write data
                        .A(ALU_ResultM), // resultado de la ali
                        .RD(ReadDataM)  // read data
                    );

    // Logica para los registros
    always @(posedge clk or negedge rst) begin
        if (rst == 1'b0) begin
            RegWriteM_r <= 1'b0; 
            ResultSrcM_r <= 1'b0;
            RD_M_r <= 5'h00;
            PCPlus4M_r <= 32'h00000000; 
            ALU_ResultM_r <= 32'h00000000; 
            ReadDataM_r   <= 32'h00000000;
        end
        else begin
            RegWriteM_r <= RegWriteM; 
            ResultSrcM_r <= ResultSrcM;
            RD_M_r <= RD_M;
            PCPlus4M_r <= PCPlus4M; 
            ALU_ResultM_r <= ALU_ResultM; 
            ReadDataM_r <= ReadDataM;
        end
    end 

    // Declaracón de salidas
    assign RegWriteW = RegWriteM_r;
    assign ResultSrcW = ResultSrcM_r;
    assign RD_W = RD_M_r;
    assign PCPlus4W = PCPlus4M_r;
    assign ALU_ResultW = ALU_ResultM_r;
    assign ReadDataW = ReadDataM_r;

endmodule

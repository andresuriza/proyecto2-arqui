module memory_cycle(input logic clk, rst, RegWriteM, MemWriteM, ResultSrcM,
						  input logic [4:0] RD_M, 
						  input logic [31:0] PCPlus4M,
						  input logic [18:0] WriteDataM, ALU_ResultM,
						  output RegWriteW, ResultSrcW,
						  output [4:0] RD_W,
						  output [31:0] PCPlus4W,
						 output [18:0] ALU_ResultW, ReadDataW);

    logic [18:0] ReadDataM, ReadDataM_r, ALU_ResultM_r;
    logic RegWriteM_r, ResultSrcM_r;
    logic [4:0] RD_M_r;
    logic [31:0] PCPlus4M_r;

    data_memory dmem (
                        .clk(clk),
                        .rst(rst),
                        .WE(MemWriteM),
                        .WD(WriteDataM),
                        .A(ALU_ResultM),
                        .RD(ReadDataM)
                    );

    always @(posedge clk or negedge rst) begin
        if (rst == 1'b0) begin
            RegWriteM_r <= 1'b0; 
            ResultSrcM_r <= 1'b0;
            RD_M_r <= 5'h00;
            PCPlus4M_r <= 32'h00000000; 
            ALU_ResultM_r <= 18'h00000000; 
            ReadDataM_r <= 18'h00000000;
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

    assign RegWriteW = RegWriteM_r;
    assign ResultSrcW = ResultSrcM_r;
    assign RD_W = RD_M_r;
    assign PCPlus4W = PCPlus4M_r;
    assign ALU_ResultW = ALU_ResultM_r;
    assign ReadDataW = ReadDataM_r;

endmodule

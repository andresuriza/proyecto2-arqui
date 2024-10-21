module fetch(input logic clk, rst,
						 input logic PCSrcE,
						 input logic [31:0] PCTargetE,
						 output logic [31:0] InstrD,
						 output logic [31:0] PCD, PCPlus4D);

    logic [31:0] PC_F, PCF, PCPlus4F;
    logic [31:0] InstrF; // Opcode
    logic [31:0] InstrF_reg; // Registro donde se escribe instruccion
    logic [31:0] PCF_reg, PCPlus4F_reg;

    Mux pc_mux (.a(PCPlus4F),
                .b(PCTargetE),
                .c(PCSrcE),
                .y(PC_F)
                );
					 

    pc program_counter (
                .clk(clk),
                .rst(rst),
                .PC(PCF),
                .PC_Next(PC_F)
                );

    instruction_memory inst_mem (
                .rst(rst),
                .A(PCF),
                .RD(InstrF)
                );

    pc_adder pcAdder (
                .a(PCF),
                .b(32'h00000004),
                .c(PCPlus4F)
                );

    always @(posedge clk or negedge rst) begin
        if(rst == 1'b0) begin
            InstrF_reg <= 32'h00000000;
            PCF_reg <= 32'h00000000;
            PCPlus4F_reg <= 32'h00000000;
        end
        else begin
            InstrF_reg <= InstrF;
            PCF_reg <= PCF;
            PCPlus4F_reg <= PCPlus4F;
        end
    end

    assign  InstrD = (rst == 1'b0) ? 32'h00000000 : InstrF_reg;
    assign  PCD = (rst == 1'b0) ? 32'h00000000 : PCF_reg;
    assign  PCPlus4D = (rst == 1'b0) ? 32'h00000000 : PCPlus4F_reg;


endmodule
module fetch_cycle(input logic clk, rst, PCSrcE, 
						 input logic [31:0] PCTargetE, 
						 output logic [31:0] PCD, PCPlus4D);

	logic [31:0] PC_F, PCF, PCPlus4F, InstrF, InstrF_reg, PCF_reg, PCPlus4F_reg;
	
	
	Mux PC_MUX(.a(PCPlus4F),
				  .b(PCTargetE),
				  .s(PCSrcE),
				  .c(PC_F));
				  
	PC_Module Program_Counter(.clk(clk),
									  .rst(rst),
									  .PC(PCF),
									  .PC_Next(PC_F)); 
									  
	Instruction_Memory IMEM(.rst(rst),
									.A(PCF),
									.RD(InstrF));
									
	PC_Adder PC_adder (.a(PCF),
							 .b(32'h4),
							 .c(PCPlus4F));
							 
	always_ff @(posedge clk or negedge rst) begin
		if(rst == 1'b0) begin
			InstrF_reg <= 32'h0;
			PCF_reg <= 32'h0;
			PCPlus4F_reg <= 32'h0;
		end
		
		else begin
			InstrF_reg <= InstrF;
			PCF_reg <= PCF;
			PCPlus4F_reg <= PCPlus4F;
		end
	end
	
	assign InstrD = (rst == 1'b0) ? 32'h0 : InstrF_reg;
	assign PCD = (rst == 1'b0) ? 32'h0 : PCF_reg;
	assign PCPlus4D = (rst == 1'b0) ? 32'h0 : PCPlus4F_reg;
	

endmodule
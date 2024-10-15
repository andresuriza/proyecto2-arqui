module fetch_tb();
	logic clk, rst, PCSrcE; 
	logic [31:0] PCTargetE; 
	logic [31:0] PCD, PCPlus4D;
	
	fetch_cycle fc(clk, rst, PCSrcE, PCTargetE, PCD, PCPlus4D);
	
	always #5 clk = ~clk;
	
	initial begin
		clk = 0;
		rst = 1'b0;
		#200
		rst = 1'b1;
		PCSrcE = 1'b0;
		PCTargetE = 32'h0;
	end
	
endmodule
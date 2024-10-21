module pipeline_tb();
	logic clk, rst;
	
	Pipeline_Top pip(clk, rst);

	always #5 clk = ~clk;

	initial begin
		clk = 0;
		rst <= 1'b0;
		#200
		rst <= 1'b1;
	end
	
	

endmodule
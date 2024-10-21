module PC_Module(input logic clk,rst,
					  input logic [31:0]PC_Next,
					  output logic [31:0]PC);
				
    always @(posedge clk) begin
        if(rst == 1'b0)
            PC <= {32{1'b0}};
        else
            PC <= PC_Next;
    end
endmodule
module data_memory(input logic clk,rst,WE,
						 input logic [18:0]A,WD,
						 output logic [18:0]RD);

    logic [31:0] mem [4096:0];

    always @ (posedge clk)
    begin
        if(WE)
            mem[A] <= WD;
    end

    assign RD = (~rst) ? 32'd0 : mem[A];

    initial begin
        mem[0] = 32'h00000000;
    end


endmodule
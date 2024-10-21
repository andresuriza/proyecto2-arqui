module videoGen #(parameter N = 400) (input logic clk, input logic [9:0] x, y, 
					input logic	[7:0] q,
					output logic [7:0] r, g, b,
					output logic [17:0] address = 0);

logic [8:0] k = 1;
logic [8:0] j = 1;

//localparam IMG_WIDTH = 400;
//localparam IMG_HEIGHT = 400;

    always_ff @(posedge clk) begin
        if (x >= 1 && x <= N && y >= 1 && y <= N) begin
            address <= ((x - 1) * N) + (y - 1);
            r <= q;
            g <= q;
            b <= q;
        end 
		  
		  else begin
            r <= 8'b0;
            g <= 8'b0;
            b <= 8'b0;
        end
    end
endmodule
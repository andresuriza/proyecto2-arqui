module vga_tb();

logic clk;
logic [9:0] x, y;
logic [7:0] r, g, b;

videoGen vg(clk, x, y, r, g, b);
					
endmodule
module top(input logic clk, rst, 
				output logic vgaclk, // 25.175 MHz VGA clock
			  output logic hsync, vsync,
			  output logic sync_b, blank_b, // To monitor 
			  output logic [7:0] r, g, b );
			 
	logic	[7:0] data_a, data_b;
	logic	[17:0]  address_a;
	logic	[17:0]  address_b;
	logic	  wren_a;
	logic	  wren_b;
	logic	[31:0]  q_a;
	logic	[31:0]  q_b;

	cpuram mem(address_a, address_b, vgaclk, data_a, data_b, 0, 0, q_a, q_b);	  
	vga vga_module(clk, q_a, vgaclk, hsync, vsync, sync_b, blank_b, r, g, b, address_a);
	beetlejuice b_p(clk, rst);

endmodule
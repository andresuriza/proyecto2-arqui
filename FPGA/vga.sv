module vga(input logic clk,
				input logic	[7:0] q,
			  output logic vgaclk, // 25.175 MHz VGA clock
			  output logic hsync, vsync,
			  output logic sync_b, blank_b, // To monitor 
			  output logic [7:0] r, g, b,
			  output logic	[18:0] address);
			  
	parameter IMAGE_WIDTH = 400;
	parameter IMAGE_HEIGHT = 400;
	logic [9:0] x, y;

	// Modulo para obtener 25MHz
	pll vgapll(.inclk0(clk), .c0(vgaclk));

	// Generador de señales para el monitor
	vgaController vgaCont(vgaclk, hsync, vsync, sync_b, blank_b, x, y);
	
	// Modulo para pintar la pantalla
	videoGen videoGen(vgaclk, x, y, q, r, g, b, address);
endmodule
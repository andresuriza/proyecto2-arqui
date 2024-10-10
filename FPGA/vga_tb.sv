module vga_tb();

 logic clk;
 logic vgaclk; // 25.175 MHz VGA clock
 logic hsync, vsync;
 logic sync_b, blank_b; // To monitor 
 logic [7:0] r, g, b;

top top_m(clk, vgaclk, hsync, vsync, sync_b, blank_b, r, g, b);
					
endmodule
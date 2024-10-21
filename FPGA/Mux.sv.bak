module Mux (input logic [31:0]a,b,
				input logic y,
				output logic [31:0]c);

    assign c = (~s) ? a : b ;
    
endmodule

module Mux_3_by_1 (a,b,c,y,d);
    input [31:0] a,b,c;
    input [1:0] y;
    output [31:0] d;

    assign d = (y == 2'b00) ? a : (y == 2'b01) ? b : (y == 2'b10) ? c : 32'h00000000;
    
endmodule
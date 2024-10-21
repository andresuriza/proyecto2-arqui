module Mux (input logic [31:0]a,b,
				input logic c,
				output logic [31:0]y);

    assign y = (~c) ? a : b ;
    
endmodule

module mux_3_1 (a,b,c,y,d);
    input [31:0] a,b,c;
    input [1:0] d;
    output [31:0] y;

    assign y = (d == 2'b00) ? a : (d == 2'b01) ? b : (d == 2'b10) ? c : 32'h00000000;
    
endmodule
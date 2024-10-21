`timescale 10ns/1ps

module mult_tb();

    logic [15:0] a, b, c;

    mult dut (
        .a(a),
        .b(b),
        .c(c)
    );

    initial begin
	 
        a = 16'd2; 
        b = 16'd16;
		  
        #1ns;
        a = 16'd16; 
        b = 16'd4;
		  
        #1ns;
        a = 16'd32768; 
        b = 16'd1;
        
        #1ns;
        $stop;
    end
endmodule
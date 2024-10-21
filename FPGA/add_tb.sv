`timescale 10ns/1ps

module add_tb();

    logic [15:0] a, b, c;

    add dut (
        .a(a),
        .b(b),
        .c(c)
    );

    initial begin
	 
        a = 16'd10; 
        b = 16'd5;
		  
        #1ns;
        a = 16'd16; 
        b = 16'd16;
		  
        #1ns;
        a = 16'd65535; 
        b = 16'd1;
        
        #1ns;
        $stop;
    end
endmodule

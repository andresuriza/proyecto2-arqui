`timescale 10ns/1ps

module sub_tb();

    logic [15:0] a, b, c;

    sub dut (
        .a(a),
        .b(b),
        .c(c)
    );

    initial begin
	 
        a = 16'd10; 
        b = 16'd5;
		  
        #1ns;
        a = 16'd20; 
        b = 16'd30;
		  
        #1ns;
        a = 16'd1000; 
        b = 16'd999;
		  
        #1ns;
        a = 16'd32768; 
        b = 16'd1;
        
        #1ns;
        $stop;
    end
endmodule

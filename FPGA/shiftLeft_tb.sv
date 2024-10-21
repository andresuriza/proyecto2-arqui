`timescale 10ns/1ps

module shiftLeft_tb();

    logic [15:0] a, c;

    shiftLeft dut (
        .a(a),
        .c(c)
    );

    initial begin
	 
        a = 16'd3; 
		  
        #1ns;
        a = 16'd21; 
		  
        #1ns;
        a = 16'd8; 
		  
		  #1ns;
        a = 16'd0; 
		  
		  #1ns;
        a = 16'd1; 
        
        #1ns;
        $stop;
    end
endmodule
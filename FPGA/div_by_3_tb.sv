`timescale 10ns/1ps

module div_by_3_tb();

    logic [15:0] a, c;

    div_by_3 dut (
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
        a = 16'd2; 
        
        #1ns;
        $stop;
    end
endmodule
module Sign_Extend (input logic [31:0] In,
						  input logic [1:0] ImmSrc,
						  output logic [31:0] Imm_Ext);

    assign Imm_Ext =  (ImmSrc == 2'b00) ? {{20{In[31]}},In[31:12]} : 
							(ImmSrc == 2'b01) ? {{20{In[31]}},In[31:8]} : 32'h00000000; 

endmodule
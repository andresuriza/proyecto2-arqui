module Register_File(input logic clk,rst, WE3,
							input logic [3:0] A1, A2, A3,
							input logic [18:0] WD3,
							output logic [18:0] RD1, RD2);

    logic [3:0] Register [18:0];

    always @ (posedge clk)
    begin
        if(WE3 & (A3 != 5'h00))
            Register[A3] <= WD3;
    end

    assign RD1 = (rst==1'b0) ? 19'd0 : Register[A1];
    assign RD2 = (rst==1'b0) ? 19'd0 : Register[A2];

    initial begin
        Register[0] = 19'h00000000;
    end

endmodule
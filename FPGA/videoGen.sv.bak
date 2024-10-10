module videoGen(input logic clk, input logic [9:0] x, y, 
					output logic [7:0] r, g, b);

logic	[17:0]  address = 0;
logic	[7:0]  data;
logic	wren;
logic	[7:0] q;
//logic [7:0] memory[0:159999];
logic [8:0] k = 1;
logic [8:0] j = 1;
//logic [8:0] q = 0;

//initial begin
//	$readmemh("mem.hex", memory);
//end

imgmem mem(address, clk, data, 0, q);

localparam IMG_WIDTH = 400;
localparam IMG_HEIGHT = 400;

    always_ff @(posedge clk) begin
        // Check if x and y are within the bounds of the image (1 to 400)
        if (x >= 1 && x <= IMG_WIDTH && y >= 1 && y <= IMG_HEIGHT) begin
            // Adjust x and y to match the memory address (starting from 0)
            address <= ((x - 1) * IMG_WIDTH) + (y - 1);
            
            // Assign the grayscale value to r, g, and b
            r <= q;
            g <= q;
            b <= q;
        end else begin
            // If outside the image, output black
            r <= 8'b0;
            g <= 8'b0;
            b <= 8'b0;
        end
    end

//assign r = ((x<=400) & (y<=400))  ? q : 8'h00;
//assign g = ((x<=400) & (y<=400))  ? q : 8'h00;
//assign b = ((x<=400) & (y<=400))  ? q : 8'h00;

//assign r = ((y = 1) && (x >= 1 && x <= 400)) ? memory[x][7:0] : 8'h00;

endmodule
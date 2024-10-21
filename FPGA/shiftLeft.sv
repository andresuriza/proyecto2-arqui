module shiftLeft(
    input logic [15:0] a,
    output logic [15:0] c);

    assign c = a << 1;
endmodule
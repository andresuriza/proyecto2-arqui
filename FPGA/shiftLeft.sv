module shiftLeft(a, c);
    input [18:0] a;
    output [18:0] c;

    assign c = a << 1;
endmodule
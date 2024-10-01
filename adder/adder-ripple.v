module adder(
    input       [63:0]  a,
    input       [63:0]  b,
    output      [63:0]  sum,
    output              carry
);
    assign {carry, sum} = a + b;
endmodule

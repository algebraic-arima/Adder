module adder(
    input       [31:0]  a,
    input       [31:0]  b,
    output      [31:0]  sum,
	output              carry
);
    assign {carry, sum} = a + b;
endmodule

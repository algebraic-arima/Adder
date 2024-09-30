module adder(
    input       [31:0]  a,
    input       [31:0]  b,
    output reg  [31:0]  sum,
	output reg          carry
);

    reg [32:0] c;
    integer i;

    always @(*) begin
        c[0] = 0;
        for (i = 0; i < 32; i = i + 1) begin
            c[i + 1] = (a[i] & b[i]) | ((a[i] | b[i]) & c[i]);
            sum[i] = a[i] ^ b[i] ^ c[i];
        end
		carry = c[32];
    end
endmodule

module adder(
    input       [31:0]  a,
    input       [31:0]  b,
    output      [31:0]  sum,
    output              carry
);
    wire [31:0] s;
    wire c;
    adder32 adder32_1(.a(a), .b(b), .cin(1'b0), .sum(s), .carry(c));
    assign sum=s;
    assign carry=c;
endmodule

module adder4(
    input       [3:0]  a,
    input       [3:0]  b,
    input              cin,
    output      [3:0]  sum,
    output             carry
);

    wire [3:0] g;
    wire [3:0] p;
    wire [4:0] c;
    assign    g=a&b;
    assign    p=a^b;
    assign    sum=p^c[3:0];
    assign    carry=c[4];
    assign    c[0]=cin;
    assign    c[1]=g[0]|(p[0]&c[0]);
    assign    c[2]=g[1]|(p[1]&g[0])|(p[1]&p[0]&c[0]);
    assign    c[3]=g[2]|(p[2]&g[1])|(p[2]&p[1]&g[0])|(p[2]&p[1]&p[0]&c[0]);
    assign    c[4]=g[3]|(p[3]&g[2])|(p[3]&p[2]&g[1])|(p[3]&p[2]&p[1]&g[0])|(p[3]&p[2]&p[1]&p[0]&c[0]);
    
endmodule

module adder16(
    input       [15:0]  a,
    input       [15:0]  b,
    input               cin,
    output      [15:0]  sum,
    output              carry
);

    wire [3:0] c;
    adder4 adder4_1(.a(a[3:0]), .b(b[3:0]), .cin(cin), .sum(sum[3:0]), .carry(c[0]));
    adder4 adder4_2(.a(a[7:4]), .b(b[7:4]), .cin(c[0]), .sum(sum[7:4]), .carry(c[1]));
    adder4 adder4_3(.a(a[11:8]), .b(b[11:8]), .cin(c[1]), .sum(sum[11:8]), .carry(c[2]));
    adder4 adder4_4(.a(a[15:12]), .b(b[15:12]), .cin(c[2]), .sum(sum[15:12]), .carry(carry));

endmodule

module adder32(
    input       [31:0]  a,
    input       [31:0]  b,
    input               cin,
    output      [31:0]  sum,
    output              carry
);

    wire c;
    adder16 adder16_1(.a(a[15:0]), .b(b[15:0]), .cin(cin), .sum(sum[15:0]), .carry(c));
    adder16 adder16_2(.a(a[31:16]), .b(b[31:16]), .cin(c), .sum(sum[31:16]), .carry(carry));

endmodule

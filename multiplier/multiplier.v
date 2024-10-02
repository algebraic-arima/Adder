module multiplier(
    input [31:0] a,
    input [31:0] b,
    output [63:0] mul
);
// unsigned

    wire [63:0] calc[31:0];
    wire [63:0] calc1[15:0];
    wire [63:0] calc2[7:0];
    wire [63:0] calc3[3:0];
    wire [63:0] calc4[1:0];
    reg [63:0] res;
    genvar i;
    generate
        for(i = 0; i < 32; i = i + 1) begin: resultcalc
            assign calc[i] = (a[i]) ? (b << i) : 0;
        end
        for(i = 0; i < 16; i = i + 1) begin: resultcalc1
            assign calc1[i] = calc[2*i] + calc[2*i+1];
        end
        for(i = 0; i < 8; i = i + 1) begin: resultcalc2
            assign calc2[i] = calc1[2*i] + calc1[2*i+1];
        end
        for(i = 0; i < 4; i = i + 1) begin: resultcalc3
            assign calc3[i] = calc2[2*i] + calc2[2*i+1];
        end
        for(i = 0; i < 2; i = i + 1) begin: resultcalc4
            assign calc4[i] = calc3[2*i] + calc3[2*i+1];
        end
    endgenerate

    assign mul = calc4[0] + calc4[1];

endmodule
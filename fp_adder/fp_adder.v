module fp_adder(
    input [63:0] a,
    input [63:0] b,
    output [63:0] sum
);

    wire a_sgn = a[63];
    wire b_sgn = b[63];
    wire [10:0] a_exp = a[62:52];
    wire [10:0] b_exp = b[62:52];
    wire [63:0] a_tmp = {1'b1, a[51:0], 11'b0};
    wire [63:0] b_tmp = {1'b1, b[51:0], 11'b0};
    reg sum_sgn;
    reg [10:0] sum_exp;
    reg [63:0] sum_tmp;
    reg c;

    always @* begin
        if (a_exp > b_exp) begin
            if (a_sgn ^ b_sgn) begin
                {c, sum_tmp} = a_tmp - (b_tmp>>(a_exp-b_exp)); 
                sum_sgn= a_sgn;
                if(sum_tmp[63]) begin
                    sum_exp = a_exp;
                end else begin
                    sum_exp = a_exp - 1;
                    sum_tmp = sum_tmp<<1;
                end
            end else begin
                {c, sum_tmp} = a_tmp + (b_tmp>>(a_exp-b_exp)); 
                sum_sgn= a_sgn;
                if(c) begin
                    sum_exp = a_exp + 1;
                    sum_tmp={1'b1,sum_tmp[63:1]+sum_tmp[0]};
                end else begin
                    sum_exp = a_exp;
                end
            end
        end else if (b_exp > a_exp) begin
            if (b_sgn ^ a_sgn) begin
                {c, sum_tmp} = b_tmp - (a_tmp>>(b_exp-a_exp)); 
                sum_sgn=b_sgn;
                if(sum_tmp[63]) begin
                    sum_exp = b_exp;
                end else begin
                    sum_exp = b_exp - 1;
                    sum_tmp = sum_tmp<<1;
                end
            end else begin
                {c, sum_tmp} = b_tmp + (a_tmp>>(b_exp-a_exp)); 
                sum_sgn=b_sgn;
                if(c) begin
                    sum_exp = b_exp + 1;
                    sum_tmp={1'b1,sum_tmp[63:1]+sum_tmp[0]};
                end else begin
                    sum_exp = b_exp;
                end
            end
        end else begin
            if (a_sgn ^ b_sgn) begin
                if(a_tmp > b_tmp) begin
                    {c, sum_tmp} = a_tmp - b_tmp; 
                    sum_sgn=a_sgn;
                    if(sum_tmp[63]) begin
                        sum_exp = a_exp;
                    end else begin
                        sum_exp = a_exp - 1;
                        sum_tmp = sum_tmp<<1;
                    end
                end else begin
                    {c, sum_tmp} = b_tmp - a_tmp; 
                    sum_sgn=b_sgn;
                    if(sum_tmp[63]) begin
                        sum_exp = b_exp;
                    end else begin
                        sum_exp = b_exp - 1;
                        sum_tmp = sum_tmp<<1;
                    end
                end
            end else begin
                {c, sum_tmp} = a_tmp + b_tmp; 
                sum_sgn=a_sgn;
                if(c) begin
                    sum_exp = a_exp + 1;
                    sum_tmp={1'b1,sum_tmp[63:1]+sum_tmp[0]};
                end else begin
                    sum_exp = a_exp;
                end
            end
        end
        if(sum_tmp[10])begin
            sum_tmp=sum_tmp+12'b100000000000;
        end
    end

    assign sum = {sum_sgn, sum_exp, sum_tmp[62:11]};

endmodule

`include "fp_adder.v"

module test_fp_adder;

    reg [63:0] a;   
    reg [63:0] b;  
    reg [63:0] a_bin;   
    reg [63:0] b_bin;   
    wire [63:0] sum;
    integer a_int;
    integer b_int;
    real a_real;
    real b_real;
    real sum_real;
    reg [63:0] sum_bin;
    
    fp_adder fa (
        .a(a_bin), 
        .b(b_bin), 
        .sum(sum)
    );
    integer i;
    initial begin

        for (i = 0; i < 100; i = i + 1) begin
            a = $random;
            b = $random;
            a_int = a;
            b_int = b;
            a_real = a_int/1000000000.0;
            b_real = b_int/1000000000.0;
            sum_real = a_real + b_real;
            a_bin = $realtobits(a_real);
            b_bin = $realtobits(b_real);
            sum_bin = $realtobits(sum_real);


            #1;
            // $display("Test %d: a = %f, b = %f, sum = %f, result = %f", i, a_real, b_real, sum_real, $bitstoreal(sum));
            
            if (sum_bin !== sum) begin
				$display("\033[31mWrong Answer!");
                $display("Test %d: a = %h, b = %h, sum = %h, result = %h\033[0m", i, a_bin, b_bin, sum_bin, sum);
            end else begin
                $display("\033[32mAccepted");
                $display("Test %d: a = %h, b = %h, sum = %h, result = %h\033[0m", i, a_bin, b_bin, sum_bin, sum);
            end
        end
        $finish;
    end
    

endmodule

`include "multiplier.v"

module test_multiplier;
    wire [63:0] answer;
    reg  [31:0] a, b;
    reg  [63:0] res;
    reg  [63:0] wa,ac;

    multiplier m (a, b, answer);
    
    integer i;
    initial begin
        wa = 0;
        ac = 0;
        for(i = 1; i <= 100; i = i + 1) begin
            a = $random;
            b = $random;
            res = a * b;
            
            #1;
            if (answer !== res) begin
                $display("\033[31mWrong Answer!");
                $display("TESTCASE %d: %h * %h = %h\033[0m", i, a, b, answer);
                wa = wa + 1;
            end else begin 
                $display("\033[32mAccepted");
                $display("TESTCASE %d: %h * %h = %h\033[0m", i, a, b, answer);
                ac = ac + 1;
            end
        end
        $display("%d/%d", ac, ac+wa);
        $finish;
    end
endmodule

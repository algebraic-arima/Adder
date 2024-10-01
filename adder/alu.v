`include "adder/pcounter.v"

module top_module();
    wire [31:0] pc;
    reg [31:0] br;
    reg clk = 1, rst = 0;
    pcounter pcounter(.clk(clk), .rst(rst), .val(br), .pc(pc));


    always #5 clk = ~clk;
    initial begin
        rst = 0;
        br = 0;
        #5;
        rst = 1;
        #50
        br = 32'h00003b4c;
        #10
        rst = 0;
        #8
        rst = 1;
    end

    initial begin
        $dumpfile("top_module.vcd");
        $dumpvars(0, top_module);
        #100 $finish;
    end
    

endmodule
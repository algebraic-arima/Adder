`include "adder-carry.v"

module pcounter(
    input clk,
    input rst,
    input [63:0] val,
    output [63:0] pc
);

    reg [63:0] pc_reg; // the core register to store pc
    assign pc = pc_reg;
    wire [63:0] p;
    adder adder(.a(pc_reg), .b(64'b100), .sum(p), .carry());
    
    always @(posedge clk) begin
        if(!rst & clk) begin
            pc_reg <= val;
        end else begin
            pc_reg <= p;
        end
    end
endmodule

`timescale 1ns/1ps

module counter_4bit (
    input  wire clk,
    input  wire rst,
    input  wire en,
    output reg  [3:0] q
);

always @(posedge clk or posedge rst) begin
    if (rst)
        q <= 4'b0000;
    else if (en)
        q <= q + 1'b1;
end

endmodule


module counter_4bit_tb;

reg clk;
reg rst;
reg en;
wire [3:0] q;

counter_4bit dut (
    .clk(clk),
    .rst(rst),
    .en(en),
    .q(q)
);

initial clk = 0;
always #5 clk = ~clk;

initial begin
    $dumpfile("dump.vcd");
    $dumpvars(0, counter_4bit_tb);

    rst = 1;
    en  = 0;
    #12;

    rst = 0;
    en  = 1;
    #50;

    en  = 0;
    #20;

    en  = 1;
    #30;

    $finish;
end

initial begin
    $monitor("time=%0t rst=%b en=%b q=%b", $time, rst, en, q);
end

endmodule
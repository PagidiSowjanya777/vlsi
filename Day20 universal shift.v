// Code your design here
module universal_shift_register(
    input clk,
    input rst,
    input [1:0] sel,
    input [3:0] din,
    input sin_left,
    input sin_right,
    output reg [3:0] dout
);

always @(posedge clk or posedge rst) begin
    if (rst)
        dout <= 4'b0000;
    else begin
        case (sel)
            2'b00: dout <= dout;                 // Hold
            2'b01: dout <= {sin_right, dout[3:1]}; // Shift right
            2'b10: dout <= {dout[2:0], sin_left};   // Shift left
            2'b11: dout <= din;                  // Parallel load
            default: dout <= dout;
        endcase
    end
end

endmodule// Code your testbench here
// or browse Examples
`timescale 1ns/1ps

module tb_universal_shift_register;

reg clk;
reg rst;
reg [1:0] sel;
reg [3:0] din;
reg sin_left;
reg sin_right;
wire [3:0] dout;

universal_shift_register uut (
    .clk(clk),
    .rst(rst),
    .sel(sel),
    .din(din),
    .sin_left(sin_left),
    .sin_right(sin_right),
    .dout(dout)
);

always #5 clk = ~clk;

initial begin
    clk = 0;
    rst = 1;
    sel = 2'b00;
    din = 4'b0000;
    sin_left = 0;
    sin_right = 0;

    #10 rst = 0;

    // Parallel load
    #10 sel = 2'b11; din = 4'b1010;

    // Hold
    #10 sel = 2'b00;

    // Shift right
    #10 sel = 2'b01; sin_right = 1'b1;

    // Shift left
    #10 sel = 2'b10; sin_left = 1'b1;

    // Hold
    #10 sel = 2'b00;

    #20 $finish;
end

initial begin
  $dumpfile("dump.vcd");
  $dumpvars;
   $monitor("time=%0t sel=%b din=%b sinL=%b sinR=%b dout=%b",
             $time, sel, din, sin_left, sin_right, dout);
end

endmodule


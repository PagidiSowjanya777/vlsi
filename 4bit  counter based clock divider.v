// Code your design here
module clk_div16(
    input clk,
    input rst,
    output reg clk_out
);

reg [3:0] count;

always @(posedge clk or posedge rst) begin
    if (rst) begin
        count   <= 4'b0000;
        clk_out <= 1'b0;
    end else begin
        count <= count + 1'b1;
        if (count == 4'b1111)
            clk_out <= ~clk_out;
    end
end

endmodule
// Code your testbench here

module tb;
    reg clk, rst;
    wire clk_out;

    clk_div16 dut(
        .clk(clk),
        .rst(rst),
        .clk_out(clk_out)
    );

    always #5 clk = ~clk;

    initial begin
        $dumpfile("dump.vcd");
        $dumpvars(0, tb);

        clk = 0;
        rst = 1;
        #12 rst = 0;

        #500 $finish;
    end
endmodule




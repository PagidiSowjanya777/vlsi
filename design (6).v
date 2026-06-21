/*verilator lint_off ALL*/

// 1-bit D Flip-Flop
module dff_1bit (
    input  wire din,
    input  wire clk,
    input  wire reset,
    output reg  dout
);
    always @(posedge clk) begin
        if (reset) dout <= 0; // Use non-blocking assignment for FFs
        else       dout <= din;
    end
endmodule

// Ripple Counter
module ripple_counter_2bit (
    input  wire clk,
    input  wire reset,
    output wire [1:0] count // Changed from 'reg' to 'wire'
);
    // No 'reg [1:0] count;' here! The registers are inside the DFFs.

    dff_1bit dff0 (.din(~count[0]), .clk(clk),      .reset(reset), .dout(count[0]));
    dff_1bit dff1 (.din(~count[1]), .clk(count[0]), .reset(reset), .dout(count[1]));
endmodule

// Testbench
module tb_dff_counter;
    reg clk, reset;
    wire [1:0] count;

    ripple_counter_2bit uut (.clk(clk), .reset(reset), .count(count));

    always #5 clk = ~clk;

    initial begin
        $dumpfile("dump.vcd");
        $dumpvars(0, tb_dff_counter); 

        clk = 0; reset = 1; #15;
        reset = 0;
        
        $display("Time | clk | count");
        $monitor("%4d | %b   | %b", $time, clk, count);
        
        #100;
        $finish;
    end
endmodule
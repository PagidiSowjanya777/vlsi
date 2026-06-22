module cnt_sync_reset_2bit (
    input  wire clk,
    input  wire reset,
    input  wire enable,
    output reg  [1:0] count
);

    // Use non-blocking assignment (<=) for sequential logic
    always @(posedge clk) begin
        if (reset)
            count <= 2'b00;
        else if (enable)
            count <= count + 1'b1;
    end

endmodule
module tb_cnt_sync_reset;

    reg clk, reset, enable;
    wire [1:0] count;

    // Instantiate the Design Under Test (DUT)
    cnt_sync_reset_2bit uut (
        .clk(clk),
        .reset(reset),
        .enable(enable),
        .count(count)
    );

    // Clock generation: 10 time unit period
    always #5 clk = ~clk;

    initial begin
        // Dump waves for EPWave
        $dumpfile("dump.vcd");
        $dumpvars(0, tb_cnt_sync_reset);
        
        // Initialize signals
        clk = 0; reset = 1; enable = 0; 
        #15;
        
        // Apply stimulus
        reset = 0; enable = 1;
        
        $display("Time | reset | enable | count");
        $monitor("%4d |   %d   |    %d   |   %d", $time, reset, enable, count);
        
        #100;
        reset = 1; #10;
        reset = 0;
        
        #50;
        enable = 0;
        #30;
        
        $finish;
    end

endmodule




output and Schematic:



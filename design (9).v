module async_down_counter_3bit (
    input clk,
    input rst_n, // Active low reset
    output [2:0] count
);
    // Internal signals for flip-flop outputs
    reg q0, q1, q2;

    // First FF: Clocks on main clock
    always @(negedge clk or negedge rst_n) begin
        if (!rst_n) q0 <= 1'b1; // Initialize to 1 for down counting
        else        q0 <= ~q0;
    end

    // Second FF: Clocks on q0 (output of first FF)
    always @(posedge q0 or negedge rst_n) begin
        if (!rst_n) q1 <= 1'b1;
        else        q1 <= ~q1;
    end

    // Third FF: Clocks on q1 (output of second FF)
    always @(posedge q1 or negedge rst_n) begin
        if (!rst_n) q2 <= 1'b1;
        else        q2 <= ~q2;
    end

    assign count = {q2, q1, q0};
endmodule
module tb;
    reg clk;
    reg rst_n;
    wire [2:0] count;

    // Instantiate the design
    async_down_counter_3bit uut (.clk(clk), .rst_n(rst_n), .count(count));

    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    // Dump VCD file for waveform viewing
    initial begin
        $dumpfile("dump.vcd");
        $dumpvars(0, tb);
    end

    // Test sequence
    initial begin
        rst_n = 0;
        #10 rst_n = 1;
        #100 $finish;
    end

    initial begin
        $monitor("Time=%0t | Count=%b", $time, count);
    end
endmodule

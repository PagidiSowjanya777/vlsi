// 1. DESIGN MODULE (Pure logic, no delays/displays)
module adder(
    input [7:0] a, b,
    output [7:0] sum,
    output carry
);
    assign {carry, sum} = a + b;
endmodule

// 2. TESTBENCH (Synthesis tool will skip this if properly isolated)
module tb;
    reg [7:0] a, b;
    wire [7:0] sum;
    wire carry;

    adder uut (.a(a), .b(b), .sum(sum), .carry(carry));

    initial begin
        $dumpfile("dump.vcd");
        $dumpvars(0, tb);
        a = 200; b = 217;
        #5;
        $display("a=%d b=%d carry=%d sum=%d", a, b, carry, sum);
        $finish;
    end
endmodule
//for small inputs 3 values for larger 7  sum is more than 256 than the carry will be generates

 

/*verilator lint_off ALL*/

module kmap_parity3 (
    input  wire a,
    input  wire b,
    input  wire c,
    output wire f
);
    assign f = a ^ b ^ c;
endmodule

module tb_kmap_parity3;
    reg a, b, c;
    wire f;

    kmap_parity3 uut (.a(a), .b(b), .c(c), .f(f));

    initial begin
        $dumpfile("dump.vcd");
        $dumpvars(0, tb_kmap_parity3);

        $display("Time | a b c | f");
        $monitor("%4d | %d %d %d | %d", $time, a, b, c, f);
        
        a = 0; b = 0; c = 0; #5;
        a = 0; b = 0; c = 1; #5;
        a = 0; b = 1; c = 0; #5;
        a = 0; b = 1; c = 1; #5;
        a = 1; b = 0; c = 0; #5;
        a = 1; b = 0; c = 1; #5;
        a = 1; b = 1; c = 0; #5;
        a = 1; b = 1; c = 1; #5;
        $finish;
    end
endmodule
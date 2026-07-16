// Binary to Gray Converter
module bin2gray #(parameter WIDTH = 4) (
    input  [WIDTH-1:0] bin,
    output [WIDTH-1:0] gray
);

    // The Gray code is simply the binary value XORed with itself shifted right by 1
    assign gray = bin ^ (bin >> 1);

endmodule

// Gray to Binary Converter
module gray2bin #(parameter WIDTH = 4) (
    input  [WIDTH-1:0] gray,
    output reg [WIDTH-1:0] bin
);

    integer i;
    
    always @(*) begin
        // MSB stays the same
        bin[WIDTH-1] = gray[WIDTH-1];
        
        // Calculate remaining bits using a for loop
        for (i = WIDTH-2; i >= 0; i = i - 1) begin
            bin[i] = bin[i+1] ^ gray[i];
        end
    end

endmodule
module tb_graycode;
    parameter WIDTH = 4;
    
    reg  [WIDTH-1:0] bin_in;
    wire [WIDTH-1:0] gray_out;
    wire [WIDTH-1:0] bin_out;

    // 1. Instantiate Binary to Gray
    bin2gray #(WIDTH) b2g (
        .bin(bin_in),
        .gray(gray_out)
    );

    // 2. Instantiate Gray to Binary
    gray2bin #(WIDTH) g2b (
        .gray(gray_out),
        .bin(bin_out)
    );

    initial begin
        // --- Commands for EPWave Waveform Viewer ---
        $dumpfile("dump.vcd");
        $dumpvars(0, tb_graycode);
        // -------------------------------------------

        $display("Time | Bin In | Gray | Bin Out");
        $display("------------------------------");
        $monitor("%4t |  %4b  | %4b |  %4b", $time, bin_in, gray_out, bin_out);

        // Test all 4-bit combinations
        for (integer i = 0; i < 16; i = i + 1) begin
            bin_in = i;
            #10;
        end
        
        $finish;
    end
endmodule
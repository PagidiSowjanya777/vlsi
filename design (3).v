// 4-to-1 multiplexer
module mux_4to1 (
    input  wire [1:0] sel,
    input  wire [3:0] data,
    output reg        out // Changed wire to reg
);
    always @(*) begin
        case (sel)
            0: out = data[0];
            1: out = data[1];
            2: out = data[2];
            3: out = data[3];
            default: out = 0;
        endcase
    end
endmodule

// 2-to-4 decoder
module decoder_2to4 (
    input  wire [1:0] in,
    output reg  [3:0] out // Changed wire to reg
);
    always @(*) begin
        case (in)
            0: out = 4'b0001;
            1: out = 4'b0010;
            2: out = 4'b0100;
            3: out = 4'b1000;
            default: out = 4'b0000;
        endcase
    end
endmodule

// Testbench
module tb_mux_decoder;
    reg [1:0] sel_mux, in_dec;
    reg [3:0] data_mux;
    wire out_mux;
    wire [3:0] out_dec; // Must be 4 bits to match the decoder

    mux_4to1   uut_mux (.sel(sel_mux), .data(data_mux), .out(out_mux));
    decoder_2to4 uut_dec (.in(in_dec), .out(out_dec));

    initial begin
        $dumpfile("dump.vcd");
        $dumpvars(0, tb_mux_decoder);

        // Initialize to prevent X states
        sel_mux = 0; in_dec = 0; data_mux = 0;
        #5;

        $display("MUX Test:");
        data_mux = 4'b1010;
        sel_mux = 0; #5;
        sel_mux = 1; #5;
        sel_mux = 2; #5;
        sel_mux = 3; #5;
        
        $display("Decoder Test:");
        in_dec = 0; #5;
        in_dec = 1; #5;
        in_dec = 2; #5;
        in_dec = 3; #5;
        
        $finish;
    end
endmodule
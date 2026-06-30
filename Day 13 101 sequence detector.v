module seq_det_101 (
    input clk,
    input reset,
    input in,
    output reg detected
);
    // Define states
    parameter S0 = 2'b00, S1 = 2'b01, S2 = 2'b10;
    reg [1:0] state, next_state;

    // State transition logic (Sequential)
    always @(posedge clk or posedge reset) begin
        if (reset)
            state <= S0;
        else
            state <= next_state;
    end

    // Next state and output logic (Combinational)
    always @(*) begin
        next_state = state;
        detected = 0;
        
        case (state)
            S0: next_state = (in) ? S1 : S0;
            S1: next_state = (in) ? S1 : S2;
            S2: begin
                if (in) begin
                    detected = 1;
                    next_state = S1; // Go back to S1 for overlapping detection
                end else begin
                    next_state = S0;
                end
            end
            default: next_state = S0;
        endcase
    end
endmodule
module tb;
    reg clk, reset, in;
    wire detected;

    // Instantiate the design
    seq_det_101 uut (
        .clk(clk),
        .reset(reset),
        .in(in),
        .detected(detected)
    );

    // Generate clock (10ns period)
    always #5 clk = ~clk;

    initial begin
        // Setup waveform dumping
        $dumpfile("dump.vcd");
        $dumpvars(0, tb);

        // Initialize signals
        clk = 0; reset = 1; in = 0;
        
        // Apply reset
        #10 reset = 0;
        
        // Test sequence: 1-0-1-0-1
        #10 in = 1; // Time 20
        #10 in = 0; // Time 30
        #10 in = 1; // Time 40 (Detected!)
        #10 in = 0; // Time 50
        #10 in = 1; // Time 60 (Detected!)
        
        #20 $finish;
    end
endmodule



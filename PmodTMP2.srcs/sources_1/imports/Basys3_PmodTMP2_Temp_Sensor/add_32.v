`timescale 1ns / 1ps
// Add a constant value of 32 to obtain the Fahrenheit temperature
//
// Written by David Marion
module add_32(
    input  logic [7:0] x,
    output logic [7:0] y
);

    always_comb begin
        y = x + 8'd32;
    end

endmodule

`timescale 1ns / 1ps
module multiply_by_9(
    input  logic [7:0]  x,
    output logic [15:0] y
);

    always_comb begin
        y = x * 9;
    end

endmodule


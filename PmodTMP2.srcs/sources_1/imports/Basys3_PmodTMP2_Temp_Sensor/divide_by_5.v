`timescale 1ns / 1ps
module divide_by_5(
    input  logic [15:0] x,
    output logic [7:0]  y
);

    always_comb begin
        y = x / 5;
    end

endmodule


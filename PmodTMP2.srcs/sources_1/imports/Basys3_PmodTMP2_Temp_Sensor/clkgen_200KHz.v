`timescale 1ns / 1ps
// Created by David J. Marion
// 200kHz Generator for Basys 3 PmodTMP2 Temperature Sensor I2C Master
// Same 200KHz Generator used with Nexys A7 temp sensor.
// NO CHANGES WERE MADE TO THIS MODULE
module clkgen_200kHz(
    input  logic clk_100MHz,
    output logic clk_200kHz
);

    // 100 x 10^6 / 200 x 10^3 / 2 = 250 <-- 8-bit counter
    logic [7:0] counter = 8'h00;
    logic clk_reg = 1'b1;

    always_ff @(posedge clk_100MHz) begin
        if(counter == 8'd249) begin
            counter <= 8'h00;
            clk_reg <= ~clk_reg;
        end
        else begin
            counter <= counter + 1;
        end
    end

    assign clk_200kHz = clk_reg;  

endmodule

`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: N/A
// Engineer: David J. Marion
// 
// Create Date: 4.27.2023
// Design Name: Basys 3 with PmodTMP2 - Temperature Sensor
// Module Name: seg7
// Project Name: Thermometer
// Target Devices: Basys 3 Artix-7 35T
// Tool Versions: Vivado 2021.2
// Description: 7 Segment Control for the Basys 3 PmodTMP2 Temperature Sensor
//////////////////////////////////////////////////////////////////////////////////

module seg7(
    input  logic         clk_100MHz,   // Basys 3 clock
    input  logic [7:0]   c_data,       // Celsius data from i2c master
    output logic [6:0]   SEG,          // 7 Segments of Displays
    output logic [3:0]   AN            // 4 Anodes of 8 to display Temp
);

    // Binary to BCD conversion of temperature data
    logic [3:0] c_tens, c_ones;
    assign c_tens = c_data / 10;        // tens value of celsius data
    assign c_ones = c_data % 10;        // ones value of celsius data
    
    // Parameters for segment patterns
    parameter logic [6:0] ZERO  = 7'b000_0001;  // 0
    parameter logic [6:0] ONE   = 7'b100_1111;  // 1
    parameter logic [6:0] TWO   = 7'b001_0010;  // 2 
    parameter logic [6:0] THREE = 7'b000_0110;  // 3
    parameter logic [6:0] FOUR  = 7'b100_1100;  // 4
    parameter logic [6:0] FIVE  = 7'b010_0100;  // 5
    parameter logic [6:0] SIX   = 7'b010_0000;  // 6
    parameter logic [6:0] SEVEN = 7'b000_1111;  // 7
    parameter logic [6:0] EIGHT = 7'b000_0000;  // 8
    parameter logic [6:0] NINE  = 7'b000_0100;  // 9
    parameter logic [6:0] DEG   = 7'b001_1100;  // degrees symbol
    parameter logic [6:0] C     = 7'b011_0001;  // C
    
    // To select each digit in turn
    logic [1:0] anode_select;       // 2-bit counter for selecting each of 4 digits
    logic [16:0] anode_timer;       // counter for digit refresh
    
    // Logic for controlling digit select and digit timer
    always_ff @(posedge clk_100MHz) begin
        // 1ms x 4 displays = 4ms refresh period
        if(anode_timer == 99_999) begin
            anode_timer <= 0;
            anode_select <= anode_select + 1;
        end else
            anode_timer <= anode_timer + 1;
    end
    
    // Logic for driving the 4-bit anode output based on digit select
    always_comb begin
        case(anode_select) 
            2'b00 : AN = 4'b1110;   // Turn on ones digit
            2'b01 : AN = 4'b1101;   // Turn on tens digit
            2'b10 : AN = 4'b1011;   // Turn on hundreds digit
            2'b11 : AN = 4'b0111;   // Turn on thousands digit
            default: AN = 4'b1111;
        endcase
    end
    
    // Logic for setting SEG based on the selected digit and the temperature data
    always_comb begin
        case(anode_select)
            2'b00: SEG = C;                     // Display C 
            2'b01: SEG = DEG;                  // Display degrees symbol
            2'b10:                             // Temperature ones digit
                case(c_ones)
                     4'b0000: SEG = ZERO;
                     4'b0001: SEG = ONE;
                     4'b0010: SEG = TWO;
                     4'b0011: SEG = THREE;
                     4'b0100: SEG = FOUR;
                     4'b0101: SEG = FIVE;
                     4'b0110: SEG = SIX;
                     4'b0111: SEG = SEVEN;
                     4'b1000: SEG = EIGHT;
                     4'b1001: SEG = NINE;
                     default: SEG = 7'b111_1111;
                endcase
            2'b11:                             // Temperature tens digit
                case(c_tens)
                     4'b0000: SEG = ZERO;
                     4'b0001: SEG = ONE;
                     4'b0010: SEG = TWO;
                     4'b0011: SEG = THREE;
                     4'b0100: SEG = FOUR;
                     4'b0101: SEG = FIVE;
                     4'b0110: SEG = SIX;
                     4'b0111: SEG = SEVEN;
                     4'b1000: SEG = EIGHT;
                     4'b1001: SEG = NINE;
                     default: SEG = 7'b111_1111;
                endcase 
            default: SEG = 7'b111_1111;        // Blank display for undefined cases
        endcase
    end

endmodule
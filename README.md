# I2C Temperature Sensor Interface on Basys 3 FPGA with PmodTMP2

![Basys 3 and PmodTMP2](https://user-images.githubusercontent.com/your-image)  
> I2C communication project to interface the ADT7420 temperature sensor on the PmodTMP2 module with the Basys 3 FPGA board.

## 📋 Project Overview

This project demonstrates the use of **I2C protocol** for reading temperature data from the **PmodTMP2** module, containing an ADT7420 temperature sensor, and displaying it on the Basys 3 FPGA’s **7-segment display**. The code is structured for simplicity and reliability, implementing a minimal state machine to ensure correct I2C timing and operations.

### Features

- **Temperature Reading in Celsius**
- **I2C Protocol Implementation**
- **7-Segment Display Interface** to show temperature
- **Optional Fahrenheit Conversion can be considered next!**
  
## 🛠️ Hardware and Requirements

- **Basys 3 FPGA Board** (Artix-7 35T)
- **PmodTMP2** Temperature Sensor Module
- **Vivado 2021.2 or later**

## 📂 Project Structure

```plaintext
├── i2c_master.sv         # I2C master module to read temperature from sensor
├── clkgen_200kHz.sv      # Clock divider for 200kHz clock generation
├── seg7.sv               # 7-segment display driver
├── top.sv                # Top module integrating all components
└── README.md             # Project documentation
```

## 🧩 Module Descriptions

### `i2c_master.sv`
This module controls I2C communication with the ADT7420 sensor, implementing a state machine for sending start conditions, reading temperature data, and handling acknowledgments.  
- **Clock**: 10kHz SCL clock is derived from a 200kHz input.
- **Address**: Configured for the ADT7420's default I2C address.
- **Temperature Output**: 8-bit data representing temperature in Celsius.

### `clkgen_200kHz.sv`
Generates a 200kHz clock from the 100MHz FPGA clock to control timing for the I2C state machine.

### `seg7.sv`
Handles 7-segment display for temperature in Celsius (or Fahrenheit), showing tens and units digits. The display is refreshed at a 1ms interval per digit.

### `top.sv`
Integrates all modules, with switches for Celsius/Fahrenheit display modes and LEDs to show temperature in binary.

## ⚙️ Configuration & Setup

1. **Clone the Repository**  
   ```bash
   git clone https://github.com/gambablue/I2C_temp.git
   cd I2C_temp
   ```

2. **Compile & Synthesize in Vivado**  
   - Open Vivado and create a new project.
   - Add the `.sv` files from the project directory.
   - Set up the Basys 3 board constraints file.
   - Synthesize, implement, and generate the bitstream.

3. **Upload the Bitstream**  
   Connect your Basys 3 board to your PC and upload the bitstream through Vivado.

4. **Connect the PmodTMP2**  
   Attach the PmodTMP2 sensor to the Basys 3 via the Pmod connector.

## 🚀 Usage

- **Switch SW0**: Toggles between Celsius and Fahrenheit display - To be completed not included in this version!.
- **7-Segment Display**: Shows the temperature in the selected unit.
- **LEDs**: Display binary representation of temperature in Celsius.

## 📝 Example

For a temperature reading of `25°C`, the **7-segment display** will show `25` and the **LEDs** should show `00011001`.

## 🔍 Detailed Explanation

The ADT7420 provides a 16-bit, two’s complement output, with a resolution of **0.0078125°C** per bit. The data is read in two bytes (MSB and LSB), shifted right by 3 bits, and multiplied by 0.0625 for conversion. The temperature can then be displayed in Celsius or Fahrenheit based on user preference.

### Shifting and Scaling

The temperature data is shifted to discard fractional bits, followed by scaling for display:
- **Shift**: Right-shifted by 3 to remove fractional bits.
- **Multiply**: Multiplied by 0.0625 to get the final temperature.

---

Feel free to modify the README further for more customization. Enjoy your I2C temperature sensor project!

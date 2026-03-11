# 🔢 Linear Feedback Shift Register (LFSR) Counter - FPGA

[![VHDL](https://img.shields.io/badge/Language-VHDL-orange.svg)](https://img.shields.io/badge/Language-VHDL-orange.svg)
[![Vivado](https://img.shields.io/badge/Platform-Vivado-blue.svg)](https://img.shields.io/badge/Platform-Vivado-blue.svg)
[![Hardware](https://img.shields.io/badge/Target-Nexys%20A7--100T-red.svg)](https://img.shields.io/badge/Target-Nexys%20A7--100T-red.svg)

## 📖 Project Overview

This project implements a counting system based on a **Linear Feedback Shift Register (LFSR)**, optimized for FPGA technology. The system generates pseudo-random sequences, offering support for both 4-bit and 5-bit configurations, with real-time decimal visualization on a seven-segment display (SSD).



## 🛠️ System Architecture

The design follows a hierarchical **Top-Level Design** approach, consisting of the following interconnected modules:

* **`LFSR_2SSD`**: The main (Top) module that coordinates the shifting logic and display multiplexing.
* **`Frequency_Divider`**: Responsible for scaling the 100MHz system clock down to a human-readable speed.
* **`SSD_Controller`**: A seven-segment display driver using time-multiplexing to control units and tens digits simultaneously.

## 🌟 Key Features

* ✅ **Dual Configuration**: Support for 4-bit and 5-bit modes, selectable via an external switch (`bit_sel`).
* ✅ **Manual Seed Loading**: Ability to input a custom initial state using physical switches.
* ✅ **Feedback Logic**: Implementation of specific feedback polynomials for 4 and 5-bit lengths using XOR gates.
* ✅ **Decimal Output**: Real-time conversion of binary values to decimal, displayed on two SSD digits.

## 📊 Hardware Mapping (Nexys A7)

1. **Clock Management**: The 100MHz internal oscillator is divided to control the generation speed.
2. **Input Mapping**: 
   - `reset` -> Center Button (BTNC)
   - `load` -> Switch 15
   - `nr_IN` -> Switches 0 to 4
   - `bit_sel` -> Switch 14
3. **Output Interface**: 
   - **LEDs [0-4]**: Real-time binary state visualization.
   - **7-Segment Display**: Decimal value representation.



---

## 📂 Project Structure

* **`src/`**: Contains all VHDL source files (`LFSR_2SSD.vhd`, `divizor_de_frecventa.vhd`).
* **`constr/`**: Xilinx Design Constraints file for physical pin mapping.
* **`documentation/`**: Technical documentation and project reports.

## 🚀 Getting Started in Vivado

1. **Create Project**: Start a new RTL project in Vivado and select the `xc7a100tcsg324-1` part.
2. **Add Sources**: Import the `.vhd` files from the `src` folder.
3. **Add Constraints**: Import the `.xdc` file from the `xdc` folder.
4. **Flow**: Run **Synthesis**, **Implementation**, and generate the **Bitstream**.
5. **Program Hardware**: Use the Hardware Manager to upload the `.bit` file to your Nexys A7 board.

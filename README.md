# RISC-V Processor Implementation

## Overview

This project involves the implementation of a RISC-V processor on the Nexys A7 trainer kit using Verilog. The processor adheres to the RV32I specifications, supporting all 40 user-level instructions. The design incorporates a pipelined architecture with every-other-cycle instruction issuing, and a single byte-addressable and single-ported memory for both data and instructions. The implementation successfully addresses data and control hazards, demonstrating proficiency in digital design and processor architecture.

## Features

- **RISC-V Compliance:**
  - The processor is implemented to comply with the RV32I specifications, supporting all 40 user-level instructions.

- **Pipelined Architecture:**
  - Utilized a pipelined architecture for improved performance and efficiency.
  - Every-other-cycle instruction issuing to optimize instruction throughput.

- **Memory Design:**
  - Implemented a single byte-addressable and single-ported memory for both data and instructions.

- **Hazard Handling:**
  - Successfully addressed data hazards to ensure proper data flow.
  - Implemented mechanisms to handle control hazards for smooth program execution.

## Technologies Used

- **Verilog:**
  - Implemented the RISC-V processor using the Verilog hardware description language.

- **Nexys A7 Trainer Kit:**
  - Utilized the Nexys A7 trainer kit as the hardware platform for the processor implementation.

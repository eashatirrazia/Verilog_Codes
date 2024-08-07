# Verilog_Codes
A collection of fundamental Verilog modules needed for FPGA design in various applications.
All codes have been tested in Vivado Design Suite on the board Diligent Nexus A750T (Xilinx Artix A750TCSG324).

## RAM
### Block RAM
Block RAM (BRAM) is a type of memory block used in FPGAs to store data efficiently. This implementation demonstrates how to create a simple BRAM module in Verilog, which can be instantiated and used in various digital designs. Both read and write operations in BRAM are done synchronously.

**Features**

* Configurable Memory Size: Allows for the adjustment of memory depth and width to meet specific design requirements. Two parameters are provided: DATA_WIDTH and ADDR_WIDTH.
* Simple Read/Write Interface: Easy-to-use read and write operations for storing and retrieving data.
* Synchronous Operation: Supports synchronous read and write operations with a single clock input.


**Code Structure**

![image](https://github.com/eashatirrazia/Verilog_Codes/assets/110398766/e2737f9d-dae2-46fd-8953-8d917bcca544)



### Distributed RAM
Distributed RAM is implemented using the lookup tables (LUTs) within the logic fabric of an FPGA. It is highly flexible and can be used for small to medium-sized RAM blocks, making it suitable for applications where custom memory configurations are required. While write operation in Distributed RAM is done synchronously, read operation is implemented asynchronously.

**Features**

* Flexible Memory Depth and Width: Easily configurable to suit various application needs. Two parameters are provided: DATA_WIDTH and ADDR_WIDTH.
* Low Latency: Provides fast read and write operations due to its implementation within the FPGA fabric.

**Code Structure**ll

![image](https://github.com/eashatirrazia/Verilog_Codes/assets/110398766/154519b8-43c7-4768-9c1e-d5be39a29492)






## BRAM to UART
This project contains two fundamental modules, Read Controller and UART Transmitter integrated with Block Memory IP in Vivado Design Suite to test the retreival of data from the block memory bit by bit using UART transmission. Data is externally given to the BRAM IP in a coe format file. Common clock is given to both the modules and the BRAM IP. Block diagram is shown below to examine pin attachment.

![State_Machine](https://github.com/user-attachments/assets/3bca606d-1f83-4787-ad3e-71402ddd7793)

### Read Controller
This module starts the system and provide BRAM with address and provide UART transmitter with valid signal needed to output the data bits. Its main function is to cater for the read latency, that is 2 clock cycles in our case, and send valid data to the transmitter. A state machine overview of its algorithm is shown below.

![State_Machine_Controller](https://github.com/user-attachments/assets/993a6a27-5fe5-4904-af98-4dd5e79b451d)

### UART Transmitter
The UART Transmitter module is designed to serialize parallel data and transmit it over a serial line in compliance with the UART protocol. This implementation supports configurable baud rate, and clock frequency, making it adaptable for various communication requirements. A state machine overview of its algorithm is shown below.

![State_Machine_Uart](https://github.com/user-attachments/assets/e2009a06-49cd-433f-9c28-724d5fca85bc)






## Radar Config Control
The Radar Controller Configuration Project is designed to control and configure a radar system using a state machine approach. The project uses UART communication to send and receive data, enabling smooth and efficient control of the radar's operations. It handles different states, including initialization, Built-In Self-Test (BIST), RAM loading, and configuration, culminating in a done state that signals the successful setup of the radar controller.

A state machine overview is shown below.

![state_machine_visio](https://github.com/user-attachments/assets/27f3f20f-053f-41a2-824d-e11c880df20b)

The code structure is explained below with a comprehensive block diagram.

![block_dia_visio](https://github.com/user-attachments/assets/30899f34-bcd7-4ff7-9176-87f29d35eb1c)



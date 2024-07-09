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

**Code Structure**

![image](https://github.com/eashatirrazia/Verilog_Codes/assets/110398766/154519b8-43c7-4768-9c1e-d5be39a29492)





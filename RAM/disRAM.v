//Distributed RAM Asynchronous Implementation

module disRAM #(parameter DATA_WIDTH = 8, parameter ADDR_WIDTH = 8)
(
    input wire clk,
    input wire rst,
    input wire [ADDR_WIDTH-1:0] read_addr,
    input wire [ADDR_WIDTH-1:0] write_addr,
    input wire [DATA_WIDTH-1:0] data_in,
    input wire write,
    output [DATA_WIDTH-1:0] data_out
);

reg [DATA_WIDTH-1:0] mem [2**ADDR_WIDTH-1:0];

integer i;
initial 

begin
    for(i = 0; i < 2**ADDR_WIDTH; i = i + 1)
        mem[i] = 0;

end

always @(posedge clk)
begin
    if(write)
        mem[write_addr] <= data_in;

end

assign data_out = rst ? 0 : mem[read_addr];

endmodule
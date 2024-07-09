//Block RAM Synchronous Implementation

module bram #(parameter DATA_WIDTH = 8, parameter ADDR_WIDTH = 8)
(
    input wire clk,
    input wire rst,
    input wire [ADDR_WIDTH-1:0] read_addr,
    input wire [ADDR_WIDTH-1:0] write_addr,
    input wire [DATA_WIDTH-1:0] data_in,
    input wire write,
    output reg [DATA_WIDTH-1:0] data_out
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

if (rst)
    data_out <= 0;


else
    begin
        if(write)
            mem[write_addr] <= data_in;

        else if(~write)
            data_out <= mem[read_addr];

        else
            data_out <= 0;

    end
end
endmodule

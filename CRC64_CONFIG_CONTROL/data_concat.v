// concat 24 bit bram data to 56 bit data
module data_concat(
    input [23:0] data_in,
    output [55:0] data_out
    );
    
    assign data_out = {24'h110101, data_in,8'h01};
endmodule
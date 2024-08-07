//script for asynchronous mux for 4 inputs and 2 outputs

module data_select(
    input [7:0] data_a,
    input [7:0] data_b,
    input valid_a,
    input valid_b,
    input select,
    output reg [7:0] data_out,
    output reg valid_out
    );

always @(*)
begin
    if(select)
    begin
        data_out = data_a;
        valid_out = valid_a;
    end
    else
    begin
        data_out = data_b;
        valid_out = valid_b;
    end
end
endmodule
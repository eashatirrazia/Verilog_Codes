//UART TRANSMITTER

module uart_transmitter
#(parameter baud_rate = 115200,
clock_frequency = 100000000
)
(
input clk,
input [7:0]data,
input valid,
output reg data_bit,
output reg done
);

localparam integer idle = 0;
localparam integer  active = 1;

reg state = 0;

localparam integer clk_per_bit = clock_frequency/baud_rate;

reg [15:0]t_CLOCK=0;
reg [4:0] bit_counter=0;
reg [9:0] data_reg=0;

always @(posedge clk)
begin

case (state)

    idle:begin
            done        <=      0;
            data_bit    <=      1;
            t_CLOCK     <=      0;
            bit_counter <=      0;
        if(valid)
        begin
            data_reg    <=      {1'b1,data,1'b0};//adding start and stop bits       
            state       <=      active;       
        end
        else 
        begin
            data_reg   <=    0;       
            state       <=     idle;
        
        end
       
    end
   
   
    active:begin
       
        if(t_CLOCK  ==  clk_per_bit)
        begin
            t_CLOCK <= 0;
           
            if(bit_counter==9)
            begin
                data_bit    <=  1;
                bit_counter <=  0;
                state       <=  idle;
                done        <=  1;
            end
            else
            begin
                data_bit    <=  data_reg[bit_counter];
                bit_counter <=  bit_counter+1;
            end
        end
       
        else
        begin
            t_CLOCK <=  t_CLOCK +   1;
        end
    end

endcase
end

endmodule
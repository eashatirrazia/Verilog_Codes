//UART RECEIVER

module uart_rx
#(parameter baud_rate = 115200,
clock_frequency = 100000000
)
(
    input clk,
    input data_bit,
    output [7:0] data,
    output reg done
    );

    localparam integer IDLE     =  3'b000;
    localparam integer START    =  3'b001;
    localparam integer DATA     =  3'b010;
    localparam integer STOP     =  3'b100;

    reg [2:0] state     =  0;

    localparam integer clk_per_bit    =  clock_frequency / baud_rate;
    localparam integer sample_bit       =  clk_per_bit / 2;

    

    
    reg [15:0] t_CLOCK = 0;
    reg [3 :0] bit_counter = 0;
    reg [7:0] data_reg     =  0;
    
    always @(posedge clk) 
    begin

    case (state)
        
        IDLE: begin 

                t_CLOCK        <=  0;
                bit_counter    <=  0;
                done           <=  0;
            
            if (data_bit == 0) 
            begin
                state       <=  START;  
            end
            else
            begin
                state       <=  IDLE;
            end
            
        end
        
        START: begin  
            
            if (t_CLOCK == sample_bit) 
            begin

                if (data_bit == 0) 
                begin
                    state           <=  DATA;
                    t_CLOCK         <=  0;
                end 
                else 
                begin
                    state           <=  IDLE;
                end        
            end 
            
            else 
            begin
                t_CLOCK        <=  t_CLOCK + 1;
            end
        end
            
        DATA: begin
            
            if (bit_counter == 8) 
            begin
                state           <=  STOP;
                t_CLOCK         <=  0;
            end 
            
            else 
            begin
                if (t_CLOCK == clk_per_bit - 1) 
                begin
                    data_reg[bit_counter]      <=  data_bit;
                    bit_counter                <=  bit_counter + 1;
                    t_CLOCK                    <=  0;  
                end 
                else 
                begin 
                    t_CLOCK                    <=  t_CLOCK + 1;          
                end
            end
        end
        
        STOP: 
        begin
                    
            if (t_CLOCK == clk_per_bit - 1) 
            begin
                
                if (data_bit) 
                begin   
                    
                    done            <=  1'b1;    
                    state           <=  IDLE;
                    end 
                    else 
                    begin
                    state           <=  IDLE;
                    done            <=  1'b0; 
                    end
            end 
            
            else 
            begin
                t_CLOCK        <=  t_CLOCK + 1;
            end
        
        end
    
    endcase
            
            
        end     
        
    assign data     =  data_reg; 
                
endmodule
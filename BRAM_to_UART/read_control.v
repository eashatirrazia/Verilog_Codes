module read_controll #(parameter max_depth = 16)(
input clk,
input enable,
input tx_done,
output reg [3:0] address,
output reg valid,
output we
    );

//two states for reading data and adress at counter=0 and output data at counter=2
localparam integer start = 2'b00;
localparam integer idle = 2'b01;
localparam integer active = 2'b10;
localparam integer done = 2'b11;

assign we = 0;
reg [1:0]state = 0;
reg [1:0]counter = 0;
reg [4:0]depth_counter=0;

always @(posedge clk)
begin
    case(state)// add to counter as well as go to state active when counter =2 and reset counter
        start:begin
            if(enable)
            begin
                if(counter == 2)
                begin
                    valid <= 1;
                    state <= active;
                    counter <= 0;
                 end
                 else
                 begin
                     address <= 4'b0000;
                     counter <= counter + 1;
                     state <= start;
                     valid <= 0;
                 end
            end
            else
            begin
                counter <= 0;
                state <= start;
            end
        end
        idle:begin
            if(tx_done)
            begin
                valid <= 1;
                depth_counter <= depth_counter + 1;
                state <= active;
            end
            else
            begin
                state <= idle;
                valid <= 0;
            end
        end
        active:begin
            if(depth_counter + 1 == max_depth)
            begin
                 state <= done;
                 valid <= 0;
            end
            else
            begin
                 address <= address + 1;
                 state <= idle;
            end
        end
        done:begin
            state <= done;
            
        end
    endcase
end
endmodule

//configuration control module

module config_control(
    input clk,
    input enable,
    input bist_done,
    input ram_done,
    input config_done,
    input load_done,
    output reg valid_a = 0,
    output reg [7:0] data_a = 0,
    output reg bsg_enable = 0,
    output reg select_signal = 0,
    output reg startup_done = 0
    );

localparam integer idle = 3'b000;
localparam integer bist = 3'b001;
localparam integer ram = 3'b010;
localparam integer configr = 3'b011;
localparam integer load = 3'b100;
localparam integer done = 3'b101;

reg [2:0] state = 0;
reg [7:0] data_reg [2:0];
reg [2:0] counter = 0;

initial begin
    state = idle;
    data_reg[0] = 8'h52;
    data_reg[1] = 8'h53;
    data_reg[2] = 8'h54;
end

always @(posedge clk)
begin
    case(state)
        idle:begin
            
            if(enable)
            begin
                state <= bist;
            end
            else
            begin
                state <= idle;
                valid_a <= 0;
                data_a <= 0;
                bsg_enable <= 0;
                select_signal <= 0;
                startup_done <= 0;
            end
        end
        bist:begin
            
            if(counter == 2)
            begin
                valid_a <= 0;
                if(bist_done)
                begin
                    valid_a <= 0;
                    counter <= 0;
                    state <= ram;
                end
                else
                begin
                    state <= bist;
                end
            end
            else
            begin
                counter <= counter + 1;
                valid_a <= 1;
                data_a <= data_reg[0];
                bsg_enable <= 0;
                select_signal <= 0;
                startup_done <= 0;
            end
        end
        ram:begin
            
            if(ram_done)
                begin
                    state <= configr;
                end
                else
                begin
                    state <= ram;
                    valid_a <= 0;
                    data_a <= data_reg[0];
                    bsg_enable <= 1;
                    select_signal <= 1;
                    startup_done <= 0;
                end
        end
        configr:begin
            
            if(counter == 2)
            begin
                valid_a <= 0;
                if(config_done)
                begin
                    valid_a <= 0;
                    counter <= 0;
                    state <= load;
                end
                else
                begin
                    state <= configr;
                end
            end
            else
            begin
                counter <= counter + 1;
                valid_a <= 1;
                data_a <= data_reg[1];
                bsg_enable <= 0;
                select_signal <= 0;
                startup_done <= 0;
            end
        end
        load:begin
            
            if(counter == 2)
            begin
                valid_a <= 0;
                if(load_done)
                begin
                    valid_a <= 0;
                    counter <= 0;
                    state <= done;
                end
                else
                begin
                    state <= load;
                end
            end
            else
            begin
                counter <= counter + 1;
                valid_a <= 1;
                data_a <= data_reg[2];
                bsg_enable <= 0;
                select_signal <= 0;
                startup_done <= 0;
            end
        end
        done:begin
            
            if(enable)
            begin
                state <= done;
                valid_a <= 0;
                data_a <= 0;
                bsg_enable <= 0;
                select_signal <= 0;
                startup_done <= 1;
            end
            else
            begin
                state <= idle;
                valid_a <= 0;
                data_a <= 0;
                bsg_enable <= 0;
                select_signal <= 0;
                startup_done <= 0;
            end
        end

    endcase
end
endmodule

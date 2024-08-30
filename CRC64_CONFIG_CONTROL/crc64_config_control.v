//configuration control module

module config_control(
    input clk,
    input enable,
    input i_fail,
    input i_pass,
    input i_false,
    output reg ram_fail = 0,
    output reg valid_a = 0,
    output reg [55:0] data_a = 0,
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
localparam integer fail = 3'b110;

reg [2:0] state = 0;
reg [55:0] data_reg [2:0];
reg [2:0] counter = 0;
reg [2:0] fail_counter = 0;

initial begin
    state = idle;
    data_reg[0] = 56'h110100ffeaff01;
    data_reg[1] = 56'h110102ffeaff01;
    data_reg[2] = 56'h110103ffeaff01;
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
                if(fail_counter==2)
                begin
                    state <= fail;
                    fail_counter <= 0;
                    counter <= 0;
                end
                else 
                begin
                    if(i_fail || i_false)
                    begin
                        counter <= 0;
                        state <= bist;
                        fail_counter <= fail_counter + 1;
                    end
                    else if(i_pass)
                    begin
                        valid_a <= 0;
                        counter <= 0;
                        state <= ram;
                        fail_counter <= 0;
                    end
                    else
                    begin
                        state <= bist;
                    end
                end
            end
            else
            begin
                data_a <= data_reg[0];
                counter <= counter + 1;
                valid_a <= 1;
                bsg_enable <= 0;
                select_signal <= 0;
                startup_done <= 0;
                state <= bist;
            end
        end
        ram:begin
            if(counter == 3)
            begin
                bsg_enable <= 0;
                if(fail_counter==2)
                begin
                    state <= fail;
                    fail_counter <= 0;
                    counter <= 0;
                end
                else 
                begin
                    if(i_fail || i_false)
                    begin
                        counter <= 0;
                        state <= ram;
                        fail_counter <= fail_counter + 1;
                        select_signal <= 1;
                        ram_fail <= 1;
                    end
                    else if(i_pass)
                    begin
                        valid_a <= 0;
                        counter <= 0;
                        state <= configr;
                        fail_counter <= 0;
                        bsg_enable <= 0;
                        select_signal <= 0;
                    end
                    else
                    begin
                        state <= ram;
                        ram_fail <= 0;
                        bsg_enable <= 0;
                        select_signal <= 1;
                    end
                end
            end
            else
            begin
                data_a <= data_reg[0];
                counter <= counter + 1;
                valid_a <= 0;
                bsg_enable <= 1;
                select_signal <= 1;
                startup_done <= 0;
                state <= ram;
                ram_fail <= 0;
                end
        end
        configr:begin
            if(counter == 2)
            begin
                valid_a <= 0;
                if(fail_counter==2)
                begin
                    state <= fail;
                    fail_counter <= 0;
                    counter <= 0;
                end
                else 
                begin
                    if(i_fail || i_false)
                    begin
                        counter <= 0;
                        state <= configr;
                        fail_counter <= fail_counter + 1;
                    end
                    else if(i_pass)
                    begin
                        valid_a <= 0;
                        counter <= 0;
                        state <= load;
                        fail_counter <= 0;
                    end
                    else
                    begin
                        state <= configr;
                    end
                end
            end
            else
            begin
                data_a <= data_reg[1];
                counter <= counter + 1;
                valid_a <= 1;
                bsg_enable <= 0;
                select_signal <= 0;
                startup_done <= 0;
                state <= configr;
            end

        end
        load:begin
            if(counter == 2)
            begin
                valid_a <= 0;
                if(fail_counter==2)
                begin
                    state <= fail;
                    fail_counter <= 0;
                    counter <= 0;
                end
                else 
                begin
                    if(i_fail || i_false)
                    begin
                        counter <= 0;
                        state <= load;
                        fail_counter <= fail_counter + 1;
                    end
                    else if(i_pass)
                    begin
                        valid_a <= 0;
                        counter <= 0;
                        state <= done;
                        fail_counter <= 0;
                    end
                    else
                    begin
                        state <= load;
                    end
                end
            end
            else
            begin
                data_a <= data_reg[2];
                counter <= counter + 1;
                valid_a <= 1;
                bsg_enable <= 0;
                select_signal <= 0;
                startup_done <= 0;
                state <= load;
            end
        end
        done:begin
            if(enable)
            begin
                state <= idle;
                valid_a <= 0;
                data_a <= 0;
                bsg_enable <= 0;
                select_signal <= 0;
                startup_done <= 1;
            end
            else
            begin
                state <= done;
                valid_a <= 0;
                data_a <= 0;
                bsg_enable <= 0;
                select_signal <= 0;
                startup_done <= 1;
            end
        end
        fail:begin
            if(enable)
            begin
                state <= idle;
                valid_a <= 0;
                data_a <= 0;
                bsg_enable <= 0;
                select_signal <= 0;
                startup_done <= 0;
            end
            else
            begin
                state <= fail;
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

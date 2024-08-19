module transmit_control(
input clk,
input enable,
input tx_done,
input [63:0]data_in,
output reg valid = 0,
output reg [7:0]data_out = 0,
output reg packet_done=0
    );

localparam integer IDLE = 4'b0000;
localparam integer START = 4'b0001;
localparam integer ID = 4'b0010;
localparam integer FUNC = 4'b0011;
localparam integer PAYLOAD1 = 4'b0100;
localparam integer PAYLOAD2 = 4'b0101;
localparam integer PAYLOAD3 = 4'b0110;
localparam integer ENDING = 4'b0111;
localparam integer CRC = 4'b1000;
localparam integer DONE = 4'b1001;

// assign we = 0;
reg [3:0]state = 0;
reg [1:0]counter = 0;

always @(posedge clk)
begin
    case(state)
        IDLE:begin
            if(enable)
            begin
                valid <= 0;
                state <= START;
                counter <= 0;
                packet_done <= 0;
            end
            else
            begin
                counter <= 0;
                state <= IDLE;
                valid <= 0;
                packet_done <= 1;
            end
        end
        START:begin
            if(counter == 2)
            begin
                valid <= 0;
                state <= ID;
                counter <= 0;
            end
            else
            begin
                data_out <= data_in[63:56];
                counter <= counter + 1;
                state <= START;
                valid <= 1;
            end
        end
        ID:begin
            if(tx_done)
            begin
                valid <= 0;
                state <= FUNC;
                counter <= 0;
            end
            else
            begin
                if(counter == 2)
                begin
                    valid <= 0;
                    counter <= 0;
                end
                else
                begin
                    data_out <= data_in[55:48];
                    counter <= counter + 1;
                    state <= ID;
                    valid <= 1;
                end
            end
        end
        FUNC:begin
            if(tx_done)
            begin
                valid <= 0;
                state <= PAYLOAD1;
                counter <= 0;
            end
            else
            begin
                if(counter == 2)
                begin
                    valid <= 0;
                    counter <= 0;
                end
                else
                begin
                    data_out <= data_in[47:40];
                    counter <= counter + 1;
                    state <= FUNC;
                    valid <= 1;
                end
            end
        end
        PAYLOAD1:begin
            if(tx_done)
            begin
                valid <= 0;
                state <= PAYLOAD2;
                counter <= 0;
            end
            else
            begin
                if(counter == 2)
                begin
                    valid <= 0;
                    counter <= 0;
                end
                else
                begin
                    data_out <= data_in[39:32];
                    counter <= counter + 1;
                    state <= PAYLOAD1;
                    valid <= 1;
                end
            end
        end
        PAYLOAD2:begin
            if(tx_done)
            begin
                valid <= 0;
                state <= PAYLOAD3;
                counter <= 0;
            end
            else
            begin
                if(counter == 2)
                begin
                    valid <= 0;
                    counter <= 0;
                end
                else
                begin
                    data_out <= data_in[31:24];
                    counter <= counter + 1;
                    state <= PAYLOAD2;
                    valid <= 1;
                end
            end
        end
        PAYLOAD3:begin
            if(tx_done)
            begin
                valid <= 0;
                state <= ENDING;
                counter <= 0;
            end
            else
            begin
                if(counter == 2)
                begin
                    valid <= 0;
                    counter <= 0;
                end
                else
                begin
                    data_out <= data_in[23:16];
                    counter <= counter + 1;
                    state <= PAYLOAD3;
                    valid <= 1;
                end
            end
        end
        ENDING:begin
            if(tx_done)
            begin
                valid <= 0;
                state <= CRC;
                counter <= 0;
            end
            else
            begin
                if(counter == 2)
                begin
                    valid <= 0;
                    counter <= 0;
                end
                else
                begin
                    data_out <= data_in[15:8];
                    counter <= counter + 1;
                    state <= ENDING;
                    valid <= 1;
                end
            end
        end
        CRC:begin
            if(tx_done)
            begin
                valid <= 0;
                state <= DONE;
                counter <= 0;
            end
            else
            begin
                if(counter == 2)
                begin
                    valid <= 0;
                    counter <= 0;
                end
                else
                begin
                    data_out <= data_in[7:0];
                    counter <= counter + 1;
                    state <= CRC;
                    valid <= 1;
                end
            end
        end
        DONE:begin
            state <= IDLE;
            packet_done <= 1;
            valid <= 0;
            counter <= 0;
        end

    endcase
end
endmodule

// Tcl console commands to test the module
// add_force {/transmit_controll_wrapper/clk} -radix hex {1 0ns} {0 5000ps} -repeat_every 10000ps
// run 50 ns
// add_force {/transmit_controll_wrapper/data_in} -radix hex {110100ffeaff1152 0ns}
// run 50 ns
// add_force {/transmit_controll_wrapper/enable} -radix hex {1 0ns}
// run 50 ns
// add_force {/transmit_controll_wrapper/enable} -radix hex {0 0ns}
// run 50 ns
// run 500000 ns
// run 50000 ns
// run 50000 ns
// run 50000 ns
// run 50000 ns

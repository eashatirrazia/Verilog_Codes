//done signal generator

module signal_gen(
    input clk,
    input [7:0] data,
    input done,
    output reg bist_done = 0,
    output reg ram_done = 0,
    output reg config_done = 0,
    output reg load_done = 0,
    output reg [15:0]ethernet_input = 0
    );

    always@(posedge clk)
    begin
        if(done == 1)
        begin
            if (data == 8'h52)
            begin
                bist_done <= 1;
                ram_done <= 0;
                config_done <= 0;
                load_done <= 0;
                ethernet_input <= 16'h011A;
            end
            else if (data == 8'h53)
            begin
                bist_done <= 0;
                ram_done <= 1;
                config_done <= 0;
                load_done <= 0;
                ethernet_input <= 16'h012A;
            end
            else if (data == 8'h54)
            begin
                bist_done <= 0;
                ram_done <= 0;
                config_done <= 1;
                load_done <= 0;
                ethernet_input <= 16'h014A;
            end
            else if (data == 8'h55)
            begin
                bist_done <= 0;
                ram_done <= 0;
                config_done <= 0;
                load_done <= 1;
                ethernet_input <= 16'h018A;
            end
            else if (data == 8'h56)
            begin
                bist_done <= 0;
                ram_done <= 0;
                config_done <= 0;
                load_done <= 0;
                ethernet_input <= 16'h0115;
            end
            else if (data == 8'h57)
            begin
                bist_done <= 0;
                ram_done <= 0;
                config_done <= 0;
                load_done <= 0;
                ethernet_input <= 16'h0125;
            end
            else if (data == 8'h58)
            begin
                bist_done <= 0;
                ram_done <= 0;
                config_done <= 0;
                load_done <= 0;
                ethernet_input <= 16'h0145;
            end
            else if (data == 8'h59)
            begin
                bist_done <= 0;
                ram_done <= 0;
                config_done <= 0;
                load_done <= 0;
                ethernet_input <= 16'h0185;
            end
            else
            begin
                bist_done <= 0;
                ram_done <= 0;
                config_done <= 0;
                load_done <= 0;
                ethernet_input <= 16'h0105;
            end
        end
        else
        begin
            bist_done <= 0;
            ram_done <= 0;
            config_done <= 0;
            load_done <= 0;
            ethernet_input <= 16'h0105;
        end
    end

endmodule

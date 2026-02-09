# traffic_monitor
### python 코드

```v
module tra(
    input wire clk, 
    input wire rst_n, 
    input wire mode_number, 
    output reg [1:0] car_light, 
    output reg [1:0] hmn_light
);
    localparam CAR_RED = 2'b00, CAR_GREEN = 2'b01, CAR_YELLOW = 2'b10, CAR_LEFT = 2'b11;
    localparam HMN_RED = 2'b00, HMN_GREEN = 2'b01, HMN_BLINK  = 2'b10;

    reg [6:0] cycle;

    always @(posedge clk) begin
        if (!rst_n) begin
            cycle <= 0;
        end
        else begin
            if (cycle >= 68) 
                cycle <= 0;
            else
                cycle <= cycle + 1;
        end
    end

    always @(*) begin
        car_light = 2'b00;
        hmn_light = 2'b00;

        if (cycle >= 1 && cycle <= 14) begin
            if (mode_number == 1'b0) begin
                car_light = CAR_GREEN; hmn_light = HMN_RED;
            end
            else begin
                car_light = CAR_RED; hmn_light = HMN_GREEN;
            end
        end
        else if (cycle >= 15 && cycle <= 20) begin
            if (mode_number == 1'b0) begin
                car_light = CAR_GREEN; hmn_light = HMN_RED;
            end
            else begin
                car_light = CAR_RED; hmn_light = HMN_BLINK;
            end
        end
        else if (cycle >= 21 && cycle <= 22) begin
            if (mode_number == 1'b0) begin
                car_light = CAR_YELLOW; hmn_light = HMN_RED;
            end
            else begin
                car_light = CAR_RED; hmn_light = HMN_RED;
            end
        end
        else if (cycle >= 23 && cycle <= 32) begin
            if (mode_number == 1'b0) begin
                car_light = CAR_LEFT; hmn_light = HMN_RED;
            end
            else begin
                car_light = CAR_RED; hmn_light = HMN_RED;
            end
        end
        else if (cycle >= 33 && cycle <= 34) begin
            if (mode_number == 1'b0) begin
                car_light = CAR_YELLOW; hmn_light = HMN_RED;
            end
            else begin
                car_light = CAR_RED; hmn_light = HMN_RED;
            end
        end
        else if (cycle >= 35 && cycle <= 48) begin
            if (mode_number == 1'b0) begin
                car_light = CAR_RED; hmn_light = HMN_GREEN;
            end
            else begin
                car_light = CAR_GREEN; hmn_light = HMN_RED;
            end
        end
        else if (cycle >= 49 && cycle <= 54) begin
            if (mode_number == 1'b0) begin
                car_light = CAR_RED; hmn_light = HMN_BLINK;
            end
            else begin
                car_light = CAR_GREEN; hmn_light = HMN_RED;
            end
        end
        else if (cycle >= 55 && cycle <= 56) begin
            if (mode_number == 1'b0) begin
                car_light = CAR_RED; hmn_light = HMN_RED;
            end
            else begin
                car_light = CAR_YELLOW; hmn_light = HMN_RED;
            end
        end
        else if (cycle >= 57 && cycle <= 66) begin
            if (mode_number == 1'b0) begin
                car_light = CAR_RED; hmn_light = HMN_RED;
            end
            else begin
                car_light = CAR_LEFT; hmn_light = HMN_RED;
            end
        end
        else if (cycle >= 67 && cycle <= 68) begin
            if (mode_number == 1'b0) begin
                car_light = CAR_RED; hmn_light = HMN_RED;
            end
            else begin
                car_light = CAR_YELLOW; hmn_light = HMN_RED;
            end
        end
    end
endmodule 

module top (
    input wire clk, 
    input wire rst_n, 
    output wire [1:0] n_car, n_ped, s_car, s_ped, e_car, e_ped, w_car, w_ped
);
    tra u_north (.clk(clk), .rst_n(rst_n), .mode_number(1'b0), .car_light(n_car), .hmn_light(n_ped));
    tra u_south (.clk(clk), .rst_n(rst_n), .mode_number(1'b0), .car_light(s_car), .hmn_light(s_ped));
    tra u_east  (.clk(clk), .rst_n(rst_n), .mode_number(1'b1), .car_light(e_car), .hmn_light(e_ped));
    tra u_west  (.clk(clk), .rst_n(rst_n), .mode_number(1'b1), .car_light(w_car), .hmn_light(w_ped));
endmodule

module top (
    input wire clk, 
    input wire rst_n, 
    output wire [1:0] n_car, n_ped, s_car, s_ped, e_car, e_ped, w_car, w_ped
);
    tra u_north (.clk(clk), .rst_n(rst_n), .mode_number(1'b0), .car_light(n_car), .hmn_light(n_ped));
    tra u_south (.clk(clk), .rst_n(rst_n), .mode_number(1'b0), .car_light(s_car), .hmn_light(s_ped));
    tra u_east  (.clk(clk), .rst_n(rst_n), .mode_number(1'b1), .car_light(e_car), .hmn_light(e_ped));
    tra u_west  (.clk(clk), .rst_n(rst_n), .mode_number(1'b1), .car_light(w_car), .hmn_light(w_ped));
endmodule

`timescale 1ns / 1ps

module tb_top_normal;
    reg clk;
    reg rst_n;

    wire [1:0] n_car, n_ped, s_car, s_ped, e_car, e_ped, w_car, w_ped;

    initial clk = 0;
    always #5 clk = ~clk;

    top u_traffic_system (
        .clk(clk), .rst_n(rst_n),
        .n_car(n_car), .n_ped(n_ped), .s_car(s_car), .s_ped(s_ped),
        .e_car(e_car), .e_ped(e_ped), .w_car(w_car), .w_ped(w_ped)
    );

    initial begin
        $display("===== [NORMAL MODE] 사거리 전체 흐름 시뮬레이션 시작 =====");
        rst_n = 0; #20; rst_n = 1;

        $monitor(" Cycle:%3d | N_Car:%b | E_Car:%b", 
                 $time, u_traffic_system.u_north.cycle, n_car, e_car);

        #1500;
        
        $display("===== [NORMAL MODE] 시뮬레이션 종료 =====");
        $finish;
    end
endmodule
```

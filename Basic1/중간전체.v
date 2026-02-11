`timescale 1ns / 1ps

module tra(
    input wire clk, 
    input wire rst_n, 
    input wire mode_number, 
    output reg [1:0] car_light, 
    output reg [1:0] hmn_light,
    output wire [6:0] current_cycle
);
    localparam CAR_RED = 2'b00, CAR_GREEN = 2'b01, CAR_YELLOW = 2'b10, CAR_LEFT = 2'b11;
    localparam HMN_RED = 2'b00, HMN_GREEN = 2'b01, HMN_BLINK  = 2'b10;

    reg [6:0] cycle;
    assign current_cycle=cycle;

    always @(posedge clk) begin
        if (!rst_n) 
            cycle <= 1;
        else if (cycle >= 68) 
                cycle <= 1;
            else cycle <= cycle + 1;
        end

    always @(*) begin
        car_light = CAR_RED;
        hmn_light = HMN_RED;

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
    output wire [1:0] n_car, n_ped, s_car, s_ped, e_car, e_ped, w_car, w_ped,
    output wire [6:0] current_cycle
);
    tra u_north (.clk(clk), .rst_n(rst_n), .mode_number(1'b0), .car_light(n_car), .hmn_light(n_ped),.current_cycle(current_cycle));
    tra u_south (.clk(clk), .rst_n(rst_n), .mode_number(1'b0), .car_light(s_car), .hmn_light(s_ped));
    tra u_east  (.clk(clk), .rst_n(rst_n), .mode_number(1'b1), .car_light(e_car), .hmn_light(e_ped));
    tra u_west  (.clk(clk), .rst_n(rst_n), .mode_number(1'b1), .car_light(w_car), .hmn_light(w_ped));
endmodule

module tb_tra_normal;
    reg clk;
    reg rst_n;

    wire [1:0] n_car, n_ped, s_car, s_ped, e_car, e_ped, w_car, w_ped;
    wire [6:0] current_cycle;

    initial clk = 0;
    always #5 clk = ~clk;

    top u_traffic_system (
        .clk(clk), .rst_n(rst_n),
        .n_car(n_car), .n_ped(n_ped), .s_car(s_car), .s_ped(s_ped),
        .e_car(e_car), .e_ped(e_ped), .w_car(w_car), .w_ped(w_ped),
        .current_cycle(current_cycle)
    );

    initial begin
        $display("[NORMAL MODE]");
        rst_n = 0; #10; rst_n = 1;

        $monitor(" Cycle:%2d | 북쪽: 차도 신호등:%b | 인도 신호등:%b | 남쪽: 차도 신호등:%b | 인도 신호등:%b | 동쪽: 차도 신호등:%b | 인도 신호등:%b | 서쪽: 차도 신호등:%b | 인도 신호등:%b", 
                 current_cycle, n_car, n_ped, s_car, s_ped, e_car, e_ped, w_car, w_ped);
                 rst_n=0; #20; rst_n=1;
        #670;
        $finish;


    end
endmodule

module tb_tra_monitor();
    reg clk;
    reg rst_n;
    
    wire [1:0] n_car, n_ped, s_car, s_ped, e_car, e_ped, w_car, w_ped;
    wire [6:0] current_cycle;

    integer target_cycle = 21;
    
    initial clk =0;
    always #5 clk=~clk;

    top u_traffic_system (
      .clk(clk), .rst_n(rst_n),
      .n_car(n_car), .n_ped(n_ped), .s_car(s_car), .s_ped(s_ped),
      .e_car(e_car), .e_ped(e_ped), .w_car(w_car), .w_ped(w_ped),
      .current_cycle(current_cycle)
      );

    initial begin
      rst_n=0; #20; rst_n=1;

      wait(current_cycle == target_cycle);
      #2;

      $display(" MONITOR MODE cycle: %d ", target_cycle);
      $display(" Cycle:%2d | 북쪽: 차도 신호등:%b | 인도 신호등:%b | 남쪽: 차도 신호등:%b | 인도 신호등:%b | 동쪽: 차도 신호등:%b | 인도 신호등:%b | 서쪽: 차도 신호등:%b | 인도 신호등:%b", 
                 current_cycle, n_car, n_ped, s_car, s_ped, e_car, e_ped, w_car, w_ped);
                 rst_n=0; #20; rst_n=1;
`
      $finish;

    end

endmodule

      

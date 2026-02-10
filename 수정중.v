`timescale 1ns / 1ps
module traffic(
    input wire clk, 
    input wire rst_n, 
    input wire i_mode, 
    output reg [1:0] o_car,
    output reg [1:0] o_ped, 
    output wire [6:0] o_cycle
    );

    localparam CAR_RED = 2'b00, CAR_GREEN = 2'b01, 
    CAR_YELLOW = 2'b10, CAR_LEFT = 2'b11;
    localparam PED_RED = 2'b00, PED_GREEN = 2'b01, PED_BLINK = 2'b10;

    reg [6:0] r_cycle;
    assign o_cycle = cycle;

    always @(posedge clk) begin
        if(!rst_n) begin
            cycle <=1;
        end
        else if (rst_n >=68 ) begin
            r_cycle <=1;
        end
        else begin
            r_cycle<=r_cycle+1;
        end
    end

    always @ (*) begin
        o_car = CAR_RED;
        o_ped = PED_RED;
        
        if(cycle >= 1 && cycle <= 14) begin
            if (i_mode == 1'b00) begin
                o_car = CAR_GREEN; o_ped = PED_RED;
            end
            else begin
                o_car = CAR_RED; o_ped = PED=GREEN;
            end
        end

        else if (cycle >= 15 && cycle <= 20) begin
            if (i_mode = 1'b0) begin
                o_car = CAR_GREEN; o_ped = PED_RED;
            end
            else begin
                o_car = CAR_YELLOW; o_ped = PED_BLINK
            end
        end

        else if (cycle >= 21 && cycle <= 22) begin
            if (i_mode = 1'b0) begin
                o_car = CAR_GREEN; o_ped = PED_RED;
            end
            else begin
                o_car = CAR_RED; o_ped = PED_BLINK;
            end
        end

        if(cycle >= 23 && cycle <= 32) begin
            if (i_mode == 1'b00) begin
                o_car = CAR_LEFT; o_ped = PED_RED;
            end
            else begin
                o_car = CAR_RED; o_ped = PED_RED;
            end
        end

        else if (cycle >= 33 && cycle <= 34) begin
            if (i_mode = 1'b0) begin
                o_car = CAR_YELLOW; o_ped = PED_RED;
            end
            else begin
                o_car = CAR_RED; o_ped = PED_RED;
            end
        end

        else if (cycle >= 35 && cycle <= 48) begin
            if (i_mode = 1'b0) begin
                o_car = CAR_RED; o_ped = PED_GREEN;
            end
            else begin
                o_car = CAR_GREEN; o_ped = PED_RED;
            end
        end

        else if (cycle >= 49 && cycle <= 54) begin
            if (i_mode = 1'b0) begin
                o_car = CAR_RED; o_ped = PED_BLINK;
            end
            else begin
                o_car = CAR_GREEN; o_ped = PED_RED;
            end
        end

        else if (cycle >= 55 && cycle <= 56) begin
            if (i_mode = 1'b0) begin
                o_car = CAR_RED; o_ped = PED_RED;
            end
            else begin
                o_car = CAR_YELLOW; o_ped = PED_RED;
            end
        end

        else if (cycle >= 57 && cycle <= 66) begin
            if (i_mode = 1'b0) begin
                o_car = CAR_RED; o_ped = PED_RED;
            end
            else begin
                o_car = CAR_LEFT; o_ped = PED_RED;
            end
        end

        else if (cycle >= 67 && cycle <= 68) begin
            if (i_mode = 1'b0) begin
                o_car = CAR_RED; o_ped = PED_RED;
            end
            else begin
                o_car = CAR_YELLOW; o_ped = PED_RED;
            end
        end
    end

endmodule

module top (
    input wire clk,
    input wire rst_n,
    output wire [1:0] n_car, n_ped, s_car, s_ped, e_car, e_ped, w_car, w_ped,
    output wire [6:0] o_cycle
);

    traffic u_north(.clk(clk),.rst_n(rst_n),.i_mode(1'b0),.i_car(n_car),.i_ped(n_ped),.o_cycle(o_cycle));
    traffic u_south(.clk(clk),.rst_n(rst_n),.i_mode(1'b0),.s_car(s_car),.s_ped(s_ped));
    traffic u_east(.clk(clk),.rst_n(rst_n),.i_mode(1'b0),.e_car(e_car),.e_ped(e_ped));
    traffic u_west(.clk(clk),.rst_n(rst_n),.i_mode(1'b0),.w_car(w_car),.w_ped(w_ped));

endmodule

module tb_traffic_nomal;
    reg clk;
    reg rst_n;

    wire [1:0] n_car, n_ped, s_car, s_ped, e_car, e_ped, w_car, w_ped;
    wire [6:0] o_cycle;

    top u_traffic_system (
        .clk(clk), .rst_n(rst_n),
        .n_car(n_car), .n_ped(n_ped), .s_car(s_car), .s_ped(s_ped),
        .e_car(e_car), .e_ped(e_ped), .w_car(w_car), .w_ped(w_ped),
        .o_cycle(o_cycle)
    );

    initial begin
        $display("[NORMAL MODE]");
        rst_n = 0; #10; rst_n = 1;

        $monitor(" Cycle:%2d | 북쪽: 차도 신호등:%b | 인도 신호등:%b | 남쪽: 차도 신호등:%b | 인도 신호등:%b | 동쪽: 차도 신호등:%b | 인도 신호등:%b | 서쪽: 차도 신호등:%b | 인도 신호등:%b", 
                 o_cycle, n_car, n_ped, s_car, s_ped, e_car, e_ped, w_car, w_ped);
                 rst_n=0; #20; rst_n=1;
        #670;
        $finish;

    end

endmodule

module tb_traffic_monitor

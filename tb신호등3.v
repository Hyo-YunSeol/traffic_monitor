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

        $monitor("Time:%t | Cycle:%3d | N_Car:%b | E_Car:%b", 
                 $time, u_traffic_system.u_north.cycle, n_car, e_car);

        #1500;
        
        $display("===== [NORMAL MODE] 시뮬레이션 종료 =====");
        $finish;
    end
endmodule

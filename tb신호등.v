`timescale 1ns / 1ps

module tb_tra;
    reg clk;
    reg rst_n;
    
    wire [1:0] ns_car, ns_hmn; // 남북 신호선
    wire [1:0] ew_car, ew_hmn; // 동서 신호선
    
    initial clk = 0;
    always #5 clk = ~clk;
    
    tra #( .MODE(0) ) u_ns (
        .clk(clk),
        .rst_n(rst_n),
        .car_light(ns_car), 
        .hmn_light(ns_hmn)
    );
    
    tra #( .MODE(1) ) u_ew (
        .clk(clk),
        .rst_n(rst_n),
        .car_light(ew_car), 
        .hmn_light(ew_hmn)
    );
    
    initial begin
    rst_n = 0;
        #20;
        rst_n = 1;

        $monitor("Time: %t | Cycle: %d | NS_Car: %b | EW_Car: %b", 
                 $time, u_ns.cycle, ns_car, ew_car);
                 
        #1500;
        $finish;
    end

endmodule
    

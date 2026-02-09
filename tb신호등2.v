
`timescale 1ns / 1ps

module tb_tra;
	reg clk;
	reg rst_n;
	reg [1:0] tb_mode;
	reg[6:0] target_cycle;

    
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
	
	tb_mode = 2;
	target_cycle=25;
	
	if (tb_mode == 1) begin

	#2000;
	end

	else if (tb_mode == 2) begin
		wait (u_ns.cycle == target_cycle);
		$display("[Monitor MODE] Cycle %d" target_cycle);
		$display("NS car Light: %b, EW car Light: %b", ns_car, ew_car);
		$display("NS ped Light: %b, EW ped Light: %b", ns_hmn, ew_hmn);

	end

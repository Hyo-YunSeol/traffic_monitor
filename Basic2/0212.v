`timescale 1ns / 1ps

module traffic(
    input wire clk, rst_n, i_mode, i_start,
    output reg [1:0] o_car, o_ped, 
    output wire [6:0] o_cycle
);

    reg [6:0] cnt; 
    reg [5:0] t;   
    reg on;        

    assign o_cycle = cnt;

    always @(posedge clk or negedge rst_n) begin
      if (!rst_n) cnt <= 1;
      else if (i_start) cnt <= (cnt == 68) ? 1 : cnt + 1;
    end

    always @(*) begin
        t = (cnt >= 34) ? cnt - 34 : cnt;
        on = (i_mode == (cnt >= 34));

        if (on) begin
          if      (t <= 20) o_car = 2'b01; 
          else if (t <= 22) o_car = 2'b10; 
          else if (t <= 32) o_car = 2'b11; 
            else              o_car = 2'b10;
            o_ped = 2'b00;
        end
        else begin
            o_car = 2'b00;
          if      (t <= 14) o_ped = 2'b01; 
          else if (t <= 20) o_ped = {1'b0, cnt[0]}; 
            else              o_ped = 2'b00;
        end
    end

endmodule

module top (
    input wire clk, rst_n, i_start,
    output wire [1:0] n_car, n_ped, 
    output wire [1:0] s_car, s_ped, 
    output wire [1:0] e_car, e_ped, 
    output wire [1:0] w_car, w_ped, 
    output wire [6:0] o_cycle
);
    traffic u_n (.clk(clk), .rst_n(rst_n), .i_mode(0), .i_start(i_start), .o_car(n_car), .o_ped(n_ped), .o_cycle(o_cycle));
    traffic u_s (.clk(clk), .rst_n(rst_n), .i_mode(0), .i_start(i_start), .o_car(s_car), .o_ped(s_ped), .o_cycle()); 
    
    traffic u_e (.clk(clk), .rst_n(rst_n), .i_mode(1), .i_start(i_start), .o_car(e_car), .o_ped(e_ped), .o_cycle());
    traffic u_w (.clk(clk), .rst_n(rst_n), .i_mode(1), .i_start(i_start), .o_car(w_car), .o_ped(w_ped), .o_cycle());

endmodule

`timescale 1ns / 1ps
module tb_traffic_nomal;
    reg clk, rst_n, i_start;
    wire [1:0] n_c, n_p, s_c, s_p, e_c, e_p, w_c, w_p;
    wire [6:0] cycle;

    initial clk = 0;
    always #5 clk = ~clk;

    top u_traffic_system (
        .clk(clk), .rst_n(rst_n), .i_start(i_start),
        .n_car(n_c), .n_ped(n_p), .s_car(s_c), .s_ped(s_p),
        .e_car(e_c), .e_ped(e_p), .w_car(w_c), .w_ped(w_p),
        .o_cycle(cycle)
    );

    initial begin
        rst_n = 0; i_start = 0; #20; 
        rst_n = 1; i_start = 1;
        
      wait(cycle == 68); 
        #20;
        $finish;
    end

    always @(posedge clk) begin
        if (rst_n && i_start)
    end

endmodule 

module tb_traffic_monitor;
    reg clk, rst_n, i_start;
    wire [1:0] n_c, n_p, s_c, s_p, e_c, e_p, w_c, w_p;
    wire [6:0] cycle;
    integer target_cycle = 21; 

    initial clk = 0;
    always #5 clk = ~clk;

    top u_traffic_system (
        .clk(clk), .rst_n(rst_n), .i_start(i_start),
        .n_car(n_c), .n_ped(n_p), .s_car(s_c), .s_ped(s_p),
        .e_car(e_c), .e_ped(e_p), .w_car(w_c), .w_ped(w_p),
        .o_cycle(cycle)
    );

    initial begin
        rst_n = 0; i_start = 0; #20; 
        rst_n = 1; i_start = 1;
        
        wait(cycle == target_cycle);
        
        rst_n = 0; #20; rst_n = 1; 
        $finish;
    end

endmodule

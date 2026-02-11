`timescale 1ns / 1ps

module traffic(
  input wire clk, 
  input wire rst_n, 
  input wire i_mode, 
  output reg [1:0] o_car, 
  output reg [1:0] o_ped, 
  output wire [6:0] o_cycle
  );
  localparam CAR_RED = 2'b00, CAR_GREEN = 2'b01, CAR_YELLOW = 2'b10, CAR_LEFT = 2'b11;
  localparam PED_RED = 2'b00, PED_GREEN = 2'b01, PED_BLINK = 2'b10;
  
  reg [6:0] r_cycle;

  assign o_cycle = r_cycle;

  always @(posedge clk) begin
    if (!rst_n) begin
      r_cycle<= 7'd1;
    end
    else if (r_cycle >= 7'd68) begin
      r_cycle <= 7'd1;
    end
    else begin
      r_cycle <= r_cycle + 7'd1;
    end
  end
  always @ (*) begin
    o_car = CAR_RED;
    o_ped = PED_RED;
    if (r_cycle >= 7'd1 && r_cycle <= 7'd14) begin
      if (i_mode == 1'b0) begin
        o_car = CAR_GREEN; o_ped = PED_RED;
      end
      else begin
        o_car = CAR_RED; o_ped = PED_GREEN;
      end
    end
    else if (r_cycle >= 7'd15 && r_cycle <= 7'd20) begin
      if (i_mode == 1'b0) begin
        o_car = CAR_GREEN; o_ped = PED_RED;
      end
      else begin
        o_car = CAR_RED; o_ped = PED_BLINK;
      end
    end
    else if (r_cycle >= 7'd21 && r_cycle <= 7'd22) begin
      if (i_mode == 1'b0) begin
        o_car = CAR_YELLOW; o_ped = PED_RED;
      end
      else begin
        o_car = CAR_RED; o_ped = PED_RED;
      end
    end
    else if (r_cycle >= 7'd23 && r_cycle <= 7'd32) begin
      if (i_mode == 1'b0) begin
        o_car = CAR_LEFT; o_ped = PED_RED;
      end
      else begin
        o_car = CAR_RED; o_ped = PED_RED;
      end
    end
    else if (r_cycle >= 7'd33 && r_cycle <= 7'd34) begin
      if (i_mode == 1'b0) begin
        o_car = CAR_YELLOW; o_ped = PED_RED;
      end
      else begin
        o_car = CAR_RED; o_ped = PED_RED;
      end
    end
    else if (r_cycle >= 7'd35 && r_cycle <= 7'd48) begin
      if (i_mode == 1'b0) begin
        o_car = CAR_RED; o_ped = PED_GREEN;
      end
      else begin
        o_car = CAR_GREEN; o_ped = PED_RED;
      end
    end
    else if (r_cycle >= 7'd49 && r_cycle <= 7'd54) begin
      if (i_mode == 1'b0) begin
        o_car = CAR_RED; o_ped = PED_BLINK;
      end
      else begin
        o_car = CAR_GREEN; o_ped = PED_RED;
      end
    end
    else if (r_cycle >= 7'd55 && r_cycle <= 7'd56) begin
      if (i_mode == 1'b0) begin
        o_car = CAR_RED; o_ped = PED_RED;
      end
      else begin
        o_car = CAR_YELLOW; o_ped = PED_RED;
      end
    end
    else if (r_cycle >= 7'd57 && r_cycle <= 7'd66) begin
      if (i_mode == 1'b0) begin
        o_car = CAR_RED; o_ped = PED_RED;
      end
      else begin
        o_car = CAR_LEFT; o_ped = PED_RED;
      end
    end
    else if (r_cycle >= 7'd67 && r_cycle <= 7'd68) begin
      if (i_mode == 1'b0) begin
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
  traffic u_north(.clk(clk), .rst_n(rst_n), .i_mode(1'b0), .o_car(n_car), .o_ped(n_ped), .o_cycle(o_cycle));
  traffic u_south(.clk(clk), .rst_n(rst_n), .i_mode(1'b0), .o_car(s_car), .o_ped(s_ped), .o_cycle());
  traffic u_east(.clk(clk), .rst_n(rst_n), .i_mode(1'b1), .o_car(e_car), .o_ped(e_ped), .o_cycle());
  traffic u_west(.clk(clk), .rst_n(rst_n), .i_mode(1'b1), .o_car(w_car), .o_ped(w_ped), .o_cycle());

endmodule 
module tb_traffic_nomal;
  reg clk;
  reg rst_n;
  wire [1:0] n_car, n_ped, s_car, s_ped, e_car, e_ped, w_car, w_ped;
  wire [6:0] o_cycle;
  
  initial clk = 0;
  always #5 clk = ~clk;
  
  top u_traffic_system (
  .clk(clk), .rst_n(rst_n), 
  .n_car(n_car), .n_ped(n_ped), .s_car(s_car), .s_ped(s_ped), 
  .e_car(e_car), .e_ped(e_ped), .w_car(w_car), .w_ped(w_ped), 
  .o_cycle(o_cycle)
  );
  initial begin
    $display("[NORMAL MODE]");
    rst_n = 0; #20; rst_n = 1;
    $monitor(" Cycle:%2d | 북쪽: 차도 신호등:%b | 인도 신호등:%b | 남쪽: 차도 신호등:%b | 인도 신호등:%b | 동쪽: 차도 신호등:%b | 인도 신호등:%b | 서쪽: 차도 신호등:%b | 인도 신호등:%b", 
    o_cycle, n_car, n_ped, s_car, s_ped, e_car, e_ped, w_car, w_ped);
    rst_n = 0; #20; rst_n = 1;
    #670;
    $finish;
  end

endmodule 

module tb_traffic_monitor();
  reg clk;
  reg rst_n;
  wire [1:0] n_car, n_ped, s_car, s_ped, e_car, e_ped, w_car, w_ped;
  wire [6:0] o_cycle;
  integer target_cycle = 21;
  
  initial clk = 0;
  always #5 clk = ~clk;
  
  top u_traffic_system (
  .clk(clk), .rst_n(rst_n), 
  .n_car(n_car), .n_ped(n_ped), .s_car(s_car), .s_ped(s_ped), 
  .e_car(e_car), .e_ped(e_ped), .w_car(w_car), .w_ped(w_ped), 
  .o_cycle(o_cycle)
  );
  initial begin
    rst_n = 0; #20; rst_n = 1;
    wait(o_cycle == target_cycle);
    $display("[MONITOR] Target Cycle: %0d", target_cycle);
    $display(" Cycle:%2d | 북쪽: 차도 신호등:%b | 인도 신호등:%b | 남쪽: 차도 신호등:%b | 인도 신호등:%b | 동쪽: 차도 신호등:%b | 인도 신호등:%b | 서쪽: 차도 신호등:%b | 인도 신호등:%b", 
    o_cycle, n_car, n_ped, s_car, s_ped, e_car, e_ped, w_car, w_ped);
    rst_n = 0; #20; rst_n = 1;
    $finish;
  end

endmodule 

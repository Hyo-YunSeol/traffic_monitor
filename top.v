smodule top (
    input wire clk, 
    input wire rst_n, 
    output wire [1:0] n_car, n_ped, s_car, s_ped, e_car, e_ped, w_car, w_ped
);
    tra u_north (.clk(clk), .rst_n(rst_n), .mode_number(1'b0), .car_light(n_car), .hmn_light(n_ped));
    tra u_south (.clk(clk), .rst_n(rst_n), .mode_number(1'b0), .car_light(s_car), .hmn_light(s_ped));
    tra u_east  (.clk(clk), .rst_n(rst_n), .mode_number(1'b1), .car_light(e_car), .hmn_light(e_ped));
    tra u_west  (.clk(clk), .rst_n(rst_n), .mode_number(1'b1), .car_light(w_car), .hmn_light(w_ped));
endmodule

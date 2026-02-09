module tra(
input wire clk, 
input wire rst_n,
output reg [1:0] car_light,
output reg [1:0] hmn_light
);

localparam CAR_RED = 2'b00;
localparam CAR_GREEN = 2'b01;
localparam CAR_YELLOW = 2'b10;
localparam CAR_LEFT = 2'b11;

localparam HMN_RED = 2'b00;
localparam HMN_GREEN = 2'b01;
localparam HMN_BLINK = 2'b10;

parameter MODE=0;
reg [6:0] cycle;

always @(posedge clk) begin
	if (!rst_n) begin
		cycle <= 0;
	end
	else begin
		if(cycle >= 68) begin
			cycle <= 0;
		end
		else begin
			cycle <= cycle + 1;
		end
	end
end

always @(*) begin
	car_light=0;
	hmn_light=0;
	
	if (cycle >= 1 && cycle <= 14) begin
		if (MODE == 0) begin
			car_light = CAR_GREEN;
			hmn_light = HMN_RED;
		end
		else begin
			car_light = CAR_RED;
			hmn_light = HMN_GREEN;
		end
	end
	
	else if (cycle >= 15 && cycle <= 20) begin
		if (MODE == 0) begin
			car_light = CAR_GREEN;
			hmn_light = HMN_RED;
		end
		else begin
			car_light = CAR_RED;
			hmn_light = HMN_BLINK;
		end
	end

	else if (cycle >= 21 && cycle <= 22) begin
		if (MODE == 0) begin
			car_light = CAR_YELLOW;
			hmn_light = HMN_RED;
		end
		else begin
			car_light = CAR_RED;
			hmn_light = HMN_RED;
		end
	end
	
	else if (cycle >= 23 && cycle <= 32) begin
		if(MODE == 0) begin
			car_light = CAR_LEFT;
			hmn_light = HMN_RED;
		end
		else begin
			car_light = CAR_RED;
			hmn_light = HMN_RED;
		end
	end

	else if (cycle >= 33 && cycle <= 34) begin
		if(MODE == 0) begin
			car_light = CAR_YELLOW;
			hmn_light = HMN_RED;
		end
		else begin
			car_light = CAR_RED;
			hmn_light = HMN_RED;
		end
	end

	else if (cycle >= 35 && cycle <= 48) begin
		if(MODE == 0) begin
			car_light = CAR_RED;
			hmn_light = HMN_GREEN;
		end
		else begin
			car_light = CAR_GREEN;
			hmn_light = HMN_RED;
		end
	end

	else if (cycle >= 49 && cycle <= 54) begin
		if(MODE == 0) begin
			car_light = CAR_RED;
			hmn_light = HMN_BLINK;
		end
		else begin
			car_light = CAR_GREEN;
			hmn_light = HMN_RED;
		end
	end

	else if (cycle >= 55 && cycle <= 56) begin
		if(MODE == 0) begin
			car_light = CAR_RED;
			hmn_light = HMN_RED;
		end
		else begin
			car_light = CAR_YELLOW;
			hmn_light = HMN_RED;
		end
	end

	else if (cycle >= 57 && cycle <= 66) begin
		if(MODE == 0) begin
			car_light = CAR_RED;
			hmn_light = HMN_RED;
		end
		else begin
			car_light = CAR_LEFT;
			hmn_light = HMN_RED;
		end
	end

	else if (cycle >= 67 && cycle <= 68) begin
		if(MODE == 0) begin
			car_light = CAR_RED;
			hmn_light = HMN_RED;
		end
		else begin
			car_light = CAR_YELLOW;
			hmn_light = HMN_RED;
		end
	end
end

endmodule

module led (
    input sys_clk,          // clk input
    input sys_rst_n,        // reset input
    output reg [4:0] led,    // 6 LEDS pin
    output clk_blink
);

reg [23:0] counter;
reg counter_one;
//using 27M OSC
always @(posedge sys_clk or negedge sys_rst_n) begin
    if (!sys_rst_n) begin 
        counter     <= 24'd0;
        counter_one <= 1'b0;
    end
    else if (counter < 24'd1349_9999)  begin     // 0.5s delay
        counter <= counter + 1'b1;
        counter_one <= counter_one ;
    end
    else begin 
        counter <= 24'd0;
        counter_one <= ~counter_one ;
    end
end

assign clk_blink = counter_one;
//assign led = {5'b11111,counter_one};

//1 s toggle
always @(posedge sys_clk or negedge sys_rst_n) begin
    if (!sys_rst_n)
        led <= 5'b11110;
    else if (counter == 24'd1349_9999)       // 0.5s delay
        led[4:0] <= {led[3:0],led[4]};
    else
        led <= led;
end

endmodule

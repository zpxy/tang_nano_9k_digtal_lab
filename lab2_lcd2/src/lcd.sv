module lcd(
	input clk, // 27M
	input resetn,
    
    output led_blink,

	output lcd_resetn,
	output lcd_clk,
	output lcd_cs,
	output lcd_rs,
	output lcd_data
);

localparam MAX_CMDS = 69;
wire [8:0] init_cmd[MAX_CMDS:0];
//0 for cmd;
//1 for data;
//36 : 70
assign init_cmd[ 0] = 9'h036;
assign init_cmd[ 1] = 9'h1a0;
//3a : 05
assign init_cmd[ 2] = 9'h03A;
assign init_cmd[ 3] = 9'h105;
// b2: 0c0c 0033 33
assign init_cmd[ 4] = 9'h0B2;
assign init_cmd[ 5] = 9'h10C;
assign init_cmd[ 6] = 9'h10C;
assign init_cmd[ 7] = 9'h100;
assign init_cmd[ 8] = 9'h133;
assign init_cmd[ 9] = 9'h133;
// b7 : 35
assign init_cmd[10] = 9'h0B7;
assign init_cmd[11] = 9'h135;
// bb:19
assign init_cmd[12] = 9'h0BB;
assign init_cmd[13] = 9'h119;
// c0: 2c
assign init_cmd[14] = 9'h0C0;
assign init_cmd[15] = 9'h12C;
// c2: 02
assign init_cmd[16] = 9'h0C2;
assign init_cmd[17] = 9'h101;
// c3: 12
assign init_cmd[18] = 9'h0C3;
assign init_cmd[19] = 9'h112;
// c4: 20  
assign init_cmd[20] = 9'h0C4;
assign init_cmd[21] = 9'h120;
// c6: 0f
assign init_cmd[22] = 9'h0C6;
assign init_cmd[23] = 9'h10F;
// d0: a4 a1
assign init_cmd[24] = 9'h0D0;
assign init_cmd[25] = 9'h1A4;
assign init_cmd[26] = 9'h1A1;
// e0
assign init_cmd[27] = 9'h0E0;
assign init_cmd[28] = 9'h1D0;
assign init_cmd[29] = 9'h104;
assign init_cmd[30] = 9'h10D;
assign init_cmd[31] = 9'h111;
assign init_cmd[32] = 9'h113;
assign init_cmd[33] = 9'h12B;
assign init_cmd[34] = 9'h13F;
assign init_cmd[35] = 9'h154;
assign init_cmd[36] = 9'h14C;
assign init_cmd[37] = 9'h118;
assign init_cmd[38] = 9'h10D;
assign init_cmd[39] = 9'h10B;
assign init_cmd[40] = 9'h11F;
assign init_cmd[41] = 9'h123;
//e1
assign init_cmd[42] = 9'h0E1;
assign init_cmd[43] = 9'h1D0;
assign init_cmd[44] = 9'h104;
assign init_cmd[45] = 9'h10C;
assign init_cmd[46] = 9'h111;
assign init_cmd[47] = 9'h113;
assign init_cmd[48] = 9'h12C;
assign init_cmd[49] = 9'h13F;
assign init_cmd[50] = 9'h144;
assign init_cmd[51] = 9'h151;
assign init_cmd[52] = 9'h12F;
assign init_cmd[53] = 9'h11F;
assign init_cmd[54] = 9'h11F;
assign init_cmd[55] = 9'h120;
assign init_cmd[56] = 9'h123;
//21
assign init_cmd[57] = 9'h021;
//29
assign init_cmd[58] = 9'h029;

//2a: 0028 0117
assign init_cmd[59] = 9'h02A; // column
assign init_cmd[60] = 9'h100;
assign init_cmd[61] = 9'h128;
assign init_cmd[62] = 9'h100;
assign init_cmd[63] = 9'h137;

//2b : 0035 00bb
assign init_cmd[64] = 9'h02B; // row
assign init_cmd[65] = 9'h100;
assign init_cmd[66] = 9'h134;
assign init_cmd[67] = 9'h100;
assign init_cmd[68] = 9'h142;
//2c
assign init_cmd[69] = 9'h02C; // start
//--------------------------------------------------------
//呼吸灯：指示
reg [23:0] blink_cnt;
reg blink;

always @(posedge clk or negedge resetn) begin
    if (~resetn) begin 
        blink_cnt <= 0;
        blink     <= 0;
    end
    else begin 
        if(blink_cnt < 24'd1349_9999) begin 
            
            blink_cnt <= blink_cnt + 1'b1; 
            blink     <= blink; 
        end else begin 
            blink_cnt <= 0;
            blink     <= ~blink; 
        end
    end
end 

assign led_blink = blink;

//-----------------------------------------------------------
//localparam state_idle       = 5'd0;
//localparam state_wait_10ms  = 5'd1;
//localparam state_wait_100ms = 5'd2;
//localparam state_wait_120ms = 5'd3;
//localparam state_wait_200ms = 5'd4;
//localparam state_init       = 5'd5;
//localparam state_cmd_nxtword    = 5'd6;
//localparam state_dat_nxtword    = 5'd7;

wire [7:0]  word_column;
wire [7:0]  word_row   ;
wire [7:0]  pixel_char;
wire [15:0] pixel_cnt;
wire [15:0] x_start;
wire [15:0] x_end;
wire [15:0] y_start;
wire [15:0] y_end;
wire [15:0] pixel;

font u_font(
    .word_column(word_column),
    .word_row(word_row),
    .pixel_char(pixel_char),
    .pixel_cnt(pixel_cnt),
 
    .x_start(x_start),
    .x_end(x_end),
    .y_start(y_start),
    .y_end(y_end),
    .pixel(pixel) );

//--------------------------------------------

localparam INIT_RESET   = 4'b0000; // delay 100ms while reset
localparam INIT_PREPARE = 4'b0001; // delay 200ms after reset
localparam INIT_WAKEUP  = 4'b0010; // write cmd 0x11 MIPI_DCS_EXIT_SLEEP_MODE
localparam INIT_SNOOZE  = 4'b0011; // delay 120ms after wakeup
localparam INIT_WORKING = 4'b0100; // write command & data
localparam INIT_DONE    = 4'b0101; // all done

localparam INIT_10MS      = 4'b0111;
localparam INIT_NEXT_WORD = 4'b1001;
localparam INIT_PIXEL     = 4'b1011;

localparam CNT_10MS  = 32'd270000;
localparam CNT_100MS = 32'd2700000;
localparam CNT_120MS = 32'd3240000;
localparam CNT_200MS = 32'd5400000;

//初始化状态机使用
reg [ 3:0] init_state;
reg [ 6:0] cmd_index;
reg [31:0] clk_cnt;
reg [ 4:0] bit_loop;

reg lcd_cs_r;
reg lcd_rs_r;
reg lcd_reset_r;
reg [ 7:0] spi_data;

reg [ 7:0] word_column1;
reg [ 7:0] word_row1   ;
reg [ 7:0] pixel_char1;
reg [15:0] pixel_cnt1;
reg if_init_done;

//后续状态机使用
reg lcd_cs_r2;
reg lcd_rs_r2;
reg lcd_reset_r2;
reg [7:0] spi_data2;

reg [7:0]  word_column2;
reg [7:0]  word_row2   ;
reg [7:0]  pixel_char2;
reg [15:0] pixel_cnt2;

reg [31:0] printcmd;
reg [31:0] printcmd_r;
//写入后cmd_en_wr要置0
reg cmd_en_wr;

always @(posedge clk) begin
    if(~resetn) begin 
        printcmd_r <= 0;
    end
    else begin 
        if(cmd_en_wr) begin
            printcmd_r       <= printcmd;
        end
        else begin  
            printcmd_r[31:24] <= 8'd0;
        end
   end

end


reg [31:0] printcmd_2r;// 
//[7:0] en [7:0] word_column2 [7:0] word_row2 [7:0] pixel_char2;   

assign lcd_clk    = ~clk;

assign lcd_resetn = (~if_init_done) ? lcd_reset_r : lcd_reset_r2;
assign lcd_cs     = (~if_init_done) ? lcd_cs_r    : lcd_cs_r2;
assign lcd_rs     = (~if_init_done) ? lcd_rs_r    : lcd_rs_r2;
assign lcd_data   = (~if_init_done) ? spi_data[7] : spi_data2[7]; // MSB

assign  word_column = (~if_init_done) ? word_column1 : word_column2;
assign  word_row    = (~if_init_done) ? word_row1    : word_row2;
assign  pixel_char  = (~if_init_done) ? pixel_char1  : pixel_char2;
assign  pixel_cnt   = (~if_init_done) ? pixel_cnt1   : pixel_cnt2; 

reg [7:0] cmd_cnt;
reg [2:0] char_cnt;
always@(posedge clk or negedge resetn) begin 
	if (~resetn) begin
		clk_cnt <= 0;
		cmd_index <= 0;
		init_state <= INIT_RESET;

		lcd_cs_r <= 1;
		lcd_rs_r <= 1;
		lcd_reset_r <= 0;
		spi_data <= 8'hFF;
		bit_loop <= 0;

		char_cnt <= 0;
        cmd_cnt <= 0;

        word_column1 <= 0;
        word_row1    <= 0;
        pixel_char1  <= 8'h30;
        pixel_cnt1   <= 0;    
  
        if_init_done <= 0;

 	end else begin
		case (init_state)
			INIT_RESET : begin
				if (clk_cnt == CNT_100MS) begin
					clk_cnt <= 0;
					init_state <= INIT_PREPARE;
					lcd_reset_r <= 1;
				end else begin
					clk_cnt <= clk_cnt + 1;
				end
			end
			INIT_PREPARE : begin
				if (clk_cnt == CNT_200MS) begin
					clk_cnt <= 0;
					init_state <= INIT_WAKEUP;
				end else begin
					clk_cnt <= clk_cnt + 1;
				end
			end
			INIT_WAKEUP : begin
				if (bit_loop == 0) begin
					// start
					lcd_cs_r <= 0;
					lcd_rs_r <= 0;
					spi_data <= 8'h11; // exit sleep
					bit_loop <= bit_loop + 1;
				end else if (bit_loop == 8) begin
					// end
					lcd_cs_r <= 1;
					lcd_rs_r <= 1;
					bit_loop <= 0;
					init_state <= INIT_SNOOZE;
				end else begin
					// loop
					spi_data <= { spi_data[6:0], 1'b1 };
					bit_loop <= bit_loop + 1;
				end
			end

			INIT_SNOOZE : begin
				if (clk_cnt == CNT_120MS) begin
					clk_cnt <= 0;
					init_state <= INIT_WORKING;
				end else begin
					clk_cnt <= clk_cnt + 1;
				end
			end

			INIT_WORKING : begin
				if (cmd_index == MAX_CMDS + 1) begin
					init_state <= INIT_DONE;
				end else begin
					if (bit_loop == 0) begin
						// start
						lcd_cs_r <= 0;
						lcd_rs_r <= init_cmd[cmd_index][8];
						spi_data <= init_cmd[cmd_index][7:0];
						bit_loop <= bit_loop + 1;
					end else if (bit_loop == 8) begin
						// end
						lcd_cs_r <= 1;
						lcd_rs_r <= 1;
						bit_loop <= 0;
						cmd_index <= cmd_index + 1; // next command
					end else begin
						// loop
						spi_data <= { spi_data[6:0], 1'b1 };
						bit_loop <= bit_loop + 1;
					end
				end
			end

			INIT_DONE : begin
				if (pixel_cnt == 240) begin
					init_state <= INIT_10MS; // stop
                    clk_cnt    <= 0;

                    word_column1<= 1;
                    char_cnt   <= 1;
                    pixel_cnt1  <= 0;
				end else begin
					if (bit_loop == 0) begin
						// start
						lcd_cs_r <= 0;
						lcd_rs_r <= 1;
						spi_data <= pixel[15:8];
						bit_loop <= bit_loop + 1;
					end else if (bit_loop == 8) begin
						// next byte
						spi_data <= pixel[7:0];
						bit_loop <= bit_loop + 1;
					end else if (bit_loop == 16) begin
						// end
						lcd_cs_r <= 1;
						lcd_rs_r <= 1;
						bit_loop <= 0;
						pixel_cnt1 <= pixel_cnt1 + 1; // next pixel
					end 
                    else begin
						// loop
						spi_data <= { spi_data[6:0], 1'b1 };
						bit_loop <= bit_loop + 1;
					end
				end
			end

            INIT_10MS : begin 
                if (clk_cnt == CNT_10MS) begin
					clk_cnt <= 0;
                    cmd_cnt <= 0;
					init_state <= INIT_NEXT_WORD;

              
				end else begin
					clk_cnt <= clk_cnt + 1;
				end
            end

           INIT_NEXT_WORD : begin 
                if (cmd_cnt ==  11) begin
					init_state <= INIT_PIXEL;
				end else begin
					if (bit_loop == 0) begin
						// start
                        lcd_cs_r <= 0;
                        case (cmd_cnt)
                            0:begin 
                                lcd_rs_r <= 0;
                                spi_data <= 8'h2a;
                            end
                            1:begin 
                                lcd_rs_r <= 1;
                                spi_data <= x_start[15:8];
                            end
                            2:begin 
                                lcd_rs_r <= 1;
                                spi_data <= x_start[7:0];
                            end
                            3:begin 
                                lcd_rs_r <= 1;
                                spi_data <= x_end[15:8];
                            end                 
                            4:begin 
                                lcd_rs_r <= 1;
                                spi_data <= x_end[7:0];
                            end

                            5:begin 
                                lcd_rs_r <= 0;
                                spi_data <= 8'h2b;
                            end
                            6:begin 
                                lcd_rs_r <= 1;
                                spi_data <= y_start[15:8];
                            end
                            7:begin 
                                lcd_rs_r <= 1;
                                spi_data <= y_start[7:0];
                            end
                            8:begin 
                                lcd_rs_r <= 1;
                                spi_data <= y_end[15:8];
                            end
                            9:begin 
                                lcd_rs_r <= 1;
                                spi_data <= y_end[7:0];
                            end
                
                            10:begin 
                                lcd_rs_r <= 0;
                                spi_data <= 8'h2c;
                            end
                            default:begin 
                                ;
                            end
                        endcase
						bit_loop <= bit_loop + 1;
					end else if (bit_loop == 8) begin
						// end
						lcd_cs_r <= 1;
						lcd_rs_r <= 1;
						bit_loop <= 0;
						cmd_cnt <= cmd_cnt + 1; // next command
					end else begin
						// loop
						spi_data <= { spi_data[6:0], 1'b1 };
						bit_loop <= bit_loop + 1;
					end
				end                
           end

           INIT_PIXEL : begin
                if (pixel_cnt == 240) begin
                    if( word_row1 <= 8 && word_column1 < 15) begin
                        char_cnt   <= char_cnt +1;
                        init_state <= INIT_10MS;
                        pixel_cnt1  <= 0;
                        clk_cnt    <= 0;
                        word_column1 <= word_column1+1;
                       
                        if ( pixel_char1 == 8'h5b) begin 
                             pixel_char1 <= 8'h30;
                        end else begin 
                             pixel_char1 <= pixel_char1+1;
                        end
                    end
                    else if ( word_row1 <= 8 && word_column1 == 15 )begin
                          char_cnt   <= char_cnt +1;
                          init_state <= INIT_10MS;
                          pixel_cnt1  <= 0;
                          clk_cnt    <= 0; 
                          word_column1 <= 0;
                          word_row1   <= word_row1+1;
                          //pixel_char1 <= pixel_char1+1;
                          if ( pixel_char1 == 8'h5b) begin 
                             pixel_char1 <= 8'h30;
                           end else begin 
                             pixel_char1 <= pixel_char1+1;
                           end
                            
                    end
                    else if ( word_row1 > 8)begin
                          init_state <= init_state;
                          if_init_done <= 1;
                    end
                    else begin
                          init_state <= init_state;
                          if_init_done <= 1;
                    end

				end else begin
					if (bit_loop == 0) begin
						// start
						lcd_cs_r <= 0;
						lcd_rs_r <= 1;
						spi_data <= pixel[15:8];
						bit_loop <= bit_loop + 1;
					end else if (bit_loop == 8) begin
						//next byte
						spi_data <= pixel[7:0];
						bit_loop <= bit_loop + 1;
					end else if (bit_loop == 16) begin
						//end
						lcd_cs_r <= 1;
						lcd_rs_r <= 1;
						bit_loop <= 0;
						pixel_cnt1 <= pixel_cnt1 + 1; // next pixel
					end 
                    else begin
						//loop
						spi_data <= { spi_data[6:0], 1'b1 };
						bit_loop <= bit_loop + 1;
					end
				end
           end
		endcase
	end
end

//初始化之后，可以接受指令，在指定的地方写字
reg [3:0] state;
reg [ 7:0] cmd_cnt2;
reg [ 2:0] char_cnt2;
reg [31:0] clk_cnt2;
reg [ 4:0] bit_loop2;

always@(posedge clk or negedge resetn) begin 
    if (~resetn) begin
       	lcd_cs_r2 <= 1;
		lcd_rs_r2 <= 1;
		lcd_reset_r2 <= 1;
		spi_data2 <= 8'hFF;
 
        word_column2 <= 0;
        word_row2    <= 0;
        pixel_char2  <= 8'h41;
        pixel_cnt2   <= 0;

        state     <= 4'd0;
        char_cnt2 <= 0;
        cmd_cnt2  <= 0;
        bit_loop2 <= 0;
        //blink <= 0;
    end 
    else begin
// if (if_init_done )begin 
//            lcd_cs_r2 <= 1;
//            lcd_rs_r2 <= 1;
//            lcd_reset_r2 <= 1;
//            spi_data2 <= 8'hFF;
//            word_column2 <= 0;
//            word_row2    <= 0;
//            pixel_char2  <= 8'h41;
//            pixel_cnt2   <= 0;    
// end   
//        lcd_cs_r2 <= 0;
        //blink <= ~if_init_done;
        case (state) 
            4'd0 :begin 
                if( printcmd_r[31:24] == 8'h01 ) begin 
                      state        <= 4'd1;
                      word_column2 <= printcmd_r[23:16];
                      word_row2    <= printcmd_r[15:8];
                      pixel_char2  <= printcmd_r[7:0];
                      //blink <= ~blink;
                end
                else begin 
                    state <= state;
                end
            end
            4'd1 : begin 
                if (clk_cnt2 == CNT_10MS) begin
					clk_cnt2 <= 0;
                    cmd_cnt2 <= 0;
					state    <= 4'd2;
				end else begin
					clk_cnt2 <= clk_cnt2 + 1;
				end
            end

           4'd2 : begin 
                if (cmd_cnt2 ==  11) begin
					state <= 4'd3;
				end else begin
					if (bit_loop2 == 0) begin
						// start
                        lcd_cs_r2 <= 0;
                        case (cmd_cnt2)
                            0:begin 
                                lcd_rs_r2 <= 0;
                                spi_data2 <= 8'h2a;
                            end
                            1:begin 
                                lcd_rs_r2 <= 1;
                                spi_data2 <= x_start[15:8];
                            end
                            2:begin 
                                lcd_rs_r2 <= 1;
                                spi_data2 <= x_start[7:0];
                            end
                            3:begin 
                                lcd_rs_r2 <= 1;
                                spi_data2 <= x_end[15:8];
                            end                 
                            4:begin 
                                lcd_rs_r2 <= 1;
                                spi_data2 <= x_end[7:0];
                            end

                            5:begin 
                                lcd_rs_r2 <= 0;
                                spi_data2 <= 8'h2b;
                            end
                            6:begin 
                                lcd_rs_r2 <= 1;
                                spi_data2 <= y_start[15:8];
                            end
                            7:begin 
                                lcd_rs_r2 <= 1;
                                spi_data2 <= y_start[7:0];
                            end
                            8:begin 
                                lcd_rs_r2 <= 1;
                                spi_data2 <= y_end[15:8];
                            end
                            9:begin 
                                lcd_rs_r2 <= 1;
                                spi_data2 <= y_end[7:0];
                            end
                
                            10:begin 
                                lcd_rs_r2 <= 0;
                                spi_data2 <= 8'h2c;
                            end
                            default:begin 
                                ;
                            end
                        endcase
						bit_loop2 <= bit_loop2 + 1;
					end else if (bit_loop2 == 8) begin
						// end
						lcd_cs_r2 <= 1;
						lcd_rs_r2 <= 1;
						bit_loop2 <= 0;
						cmd_cnt2 <= cmd_cnt2 + 1; // next command
					end else begin
						// loop
						spi_data2 <= { spi_data2[6:0], 1'b1 };
						bit_loop2 <= bit_loop2 + 1;
					end
				end                
           end

           4'd3 : begin
                if (pixel_cnt2 == 240) begin
                    state <= 4'd0;
                    pixel_cnt2 <= 0;
                    bit_loop2  <= 0;
                    spi_data2  <= 0;
                    lcd_cs_r2 <= 1'b1;
                    clk_cnt2 <= 0;
                    cmd_cnt2 <= 0;

				end else begin
					if (bit_loop2 == 0) begin
						// start
						lcd_cs_r2 <= 1'b0;
						lcd_rs_r2 <= 1'b1;
						spi_data2 <= pixel[15:8];
						bit_loop2 <= bit_loop2 + 1'b1;
					end else if (bit_loop2 == 8) begin
						//next byte
						spi_data2 <= pixel[7:0];
						bit_loop2 <= bit_loop2 + 1'b1;
					end else if (bit_loop == 16) begin
						//end
						lcd_cs_r2 <= 1;
						lcd_rs_r2 <= 1;
						bit_loop2 <= 0;
						pixel_cnt2 <= pixel_cnt2 + 1'b1; // next pixel
					end 
                    else begin
						//loop
						spi_data2 <= { spi_data2[6:0], 1'b1 };
						bit_loop2 <= bit_loop2 + 1'b1;
					end
				end
           end
           default: begin 
                ;
           end
        endcase
        
    end

end

//--------------------------------------------------------------------------------
//测试任务
reg [31:0] clk_cnt3;
always@(posedge clk or negedge resetn) begin 
    if(~resetn) begin 
        cmd_en_wr <= 0;
        printcmd  <= 32'd0;
        clk_cnt3  <= 0;
        
    end
    else begin 
        if(if_init_done) begin
              clk_cnt3 <= clk_cnt3 +1'b1;
        end
        if(clk_cnt3     == CNT_100MS*1 ) begin
            cmd_en_wr <= 1;
            printcmd  <= {8'h01,8'd0,8'd0,8'h00};
        end
        else if(clk_cnt3 == CNT_100MS*3 ) begin
            cmd_en_wr <= 1;
            printcmd  <= {8'h01,8'd6,8'd6,8'h45};
        end
        else if(clk_cnt3 == CNT_100MS*5 ) begin
            cmd_en_wr <= 1;
            printcmd  <= {8'h01,8'd14,8'd7,8'h41};
        end
        else if(clk_cnt3 == CNT_100MS*7 ) begin
            cmd_en_wr <= 1;
            printcmd  <= {8'h01,8'd10,8'd8,8'h42};
        end
        else begin 
            cmd_en_wr <= 0;
        end
    end
end




endmodule
module lcd(
	input clk, // 27M
	input resetn,
    
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
assign init_cmd[ 1] = 9'h170;
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
assign init_cmd[66] = 9'h135;
assign init_cmd[67] = 9'h100;
assign init_cmd[68] = 9'h144;
//2c
assign init_cmd[69] = 9'h02C; // start

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

reg [ 3:0] init_state;
reg [ 6:0] cmd_index;
reg [31:0] clk_cnt;
reg [ 4:0] bit_loop;

reg [15:0] pixel_cnt;

reg [7:0] word_column;
reg [7:0] word_row;


reg lcd_cs_r;
reg lcd_rs_r;
reg lcd_reset_r;

reg [7:0] spi_data;

assign lcd_resetn = lcd_reset_r;
assign lcd_clk    = ~clk;
assign lcd_cs     = lcd_cs_r;
assign lcd_rs     = lcd_rs_r;
assign lcd_data   = spi_data[7]; // MSB

// gen color bar
// wire [15:0] pixel = (pixel_cnt >= 21600) ? 16'h0000 :
//					(pixel_cnt >= 10800) ? 16'hF800 : 16'h07e0;



wire [15:0] symbol_A [15:0];
wire [15:0] symbol_B [15:0];
wire [15:0] symbol_C [15:0];
wire [15:0] symbol_D [15:0];
wire [15:0] symbol_E [15:0];
wire [15:0] symbol_F [15:0];
wire [15:0] symbol_G [15:0];

wire [15:0] symbol_H [15:0];
wire [15:0] symbol_I [15:0];
wire [15:0] symbol_J [15:0];
wire [15:0] symbol_K [15:0];
wire [15:0] symbol_L [15:0];
wire [15:0] symbol_M [15:0];
wire [15:0] symbol_N [15:0];

wire [15:0] symbol_O [15:0];
wire [15:0] symbol_P [15:0];
wire [15:0] symbol_Q [15:0];
wire [15:0] symbol_R [15:0];
wire [15:0] symbol_S [15:0];
wire [15:0] symbol_T [15:0];

wire [15:0] symbol_U [15:0];
wire [15:0] symbol_V [15:0];
wire [15:0] symbol_W [15:0];
wire [15:0] symbol_X [15:0];
wire [15:0] symbol_Y [15:0];
wire [15:0] symbol_Z [15:0];

wire [15:0] number_0 [15:0];
wire [15:0] number_1 [15:0];
wire [15:0] number_2 [15:0];
wire [15:0] number_3 [15:0];
wire [15:0] number_4 [15:0];
wire [15:0] number_5 [15:0];
wire [15:0] number_6 [15:0];
wire [15:0] number_7 [15:0];
wire [15:0] number_8 [15:0];
wire [15:0] number_9 [15:0];
  
wire [15:0] _space = 16'h0000;

assign symbol_A[0]  = 16'h0000;
assign symbol_A[1]  = 16'h0600;
assign symbol_A[2]  = 16'h0e00;
assign symbol_A[3]  = 16'h0f00;
assign symbol_A[4]  = 16'h1f00;
assign symbol_A[5]  = 16'h1b00;
assign symbol_A[6]  = 16'h1380;
assign symbol_A[7]  = 16'h3f80;
assign symbol_A[8]  = 16'h31c0;
assign symbol_A[9]  = 16'h61c0;
assign symbol_A[10] = 16'h60e0;
assign symbol_A[11] = 16'hf1f0;
assign symbol_A[12] = 16'h0000;
assign symbol_A[13] = 16'h0000;
assign symbol_A[14] = 16'h0000;
assign symbol_A[15] = 16'h0000;

assign symbol_B[0]  = 16'h0000;
assign symbol_B[1]  = 16'hff80;
assign symbol_B[2]  = 16'h73c0;
assign symbol_B[3]  = 16'h71c0;
assign symbol_B[4]  = 16'h71c0;
assign symbol_B[5]  = 16'h7380;
assign symbol_B[6]  = 16'h7f80;
assign symbol_B[7]  = 16'h73c0;
assign symbol_B[8]  = 16'h71c0;
assign symbol_B[9]  = 16'h71c0;
assign symbol_B[10] = 16'h73c0;
assign symbol_B[11] = 16'hff80;
assign symbol_B[12] = 16'h0000;
assign symbol_B[13] = 16'h0000;
assign symbol_B[14] = 16'h0000;
assign symbol_B[15] = 16'h0000;

assign symbol_C[0]  = 16'h0000;
assign symbol_C[1]  = 16'h3fC0;
assign symbol_C[2]  = 16'h79C0;
assign symbol_C[3]  = 16'h70C0;
assign symbol_C[4]  = 16'hE040;
assign symbol_C[5]  = 16'hE000;
assign symbol_C[6]  = 16'hE000;
assign symbol_C[7]  = 16'hE000;
assign symbol_C[8]  = 16'hE000;
assign symbol_C[9]  = 16'h7060;
assign symbol_C[10] = 16'h79C0;
assign symbol_C[11] = 16'h3F80;
assign symbol_C[12] = 16'h0000;
assign symbol_C[13] = 16'h0000;
assign symbol_C[14] = 16'h0000;
assign symbol_C[15] = 16'h0000;

assign symbol_D[0]  = 16'h0000;
assign symbol_D[1]  = 16'hFF80;
assign symbol_D[2]  = 16'h73C0;
assign symbol_D[3]  = 16'h70E0;
assign symbol_D[4]  = 16'h70E0;
assign symbol_D[5]  = 16'h7060;
assign symbol_D[6]  = 16'h7060;
assign symbol_D[7]  = 16'h7060;
assign symbol_D[8]  = 16'h70E0;
assign symbol_D[9]  = 16'h70E0;
assign symbol_D[10] = 16'h73c0;
assign symbol_D[11] = 16'hff80;
assign symbol_D[12] = 16'h0000;
assign symbol_D[13] = 16'h0000;
assign symbol_D[14] = 16'h0000;
assign symbol_D[15] = 16'h0000;

assign symbol_E[0]  = 16'h0000;
assign symbol_E[1]  = 16'hff80;
assign symbol_E[2]  = 16'h7180;
assign symbol_E[3]  = 16'h7080;
assign symbol_E[4]  = 16'h7300;
assign symbol_E[5]  = 16'h7F00;
assign symbol_E[6]  = 16'h7300;
assign symbol_E[7]  = 16'h7100;
assign symbol_E[8]  = 16'h7000;
assign symbol_E[9]  = 16'h70C0;
assign symbol_E[10] = 16'h71C0;
assign symbol_E[11] = 16'hff80;
assign symbol_E[12] = 16'h0000;
assign symbol_E[13] = 16'h0000;
assign symbol_E[14] = 16'h0000;
assign symbol_E[15] = 16'h0000;

//assign symbol_A[0] = 16'h0001;
//assign symbol_A[1] = 16'h0001;
//assign symbol_A[2] = 16'h0001;
//assign symbol_A[3] = 16'h0001;
//assign symbol_A[4] = 16'h0001;
//assign symbol_A[5] = 16'h0001;
//assign symbol_A[6] = 16'h0001;
//assign symbol_A[7] = 16'h0001;
//assign symbol_A[8] = 16'h0001;
//assign symbol_A[9] = 16'h0001;
//assign symbol_A[10] = 16'h0001;
//assign symbol_A[11] = 16'h0001;
//assign symbol_A[12] = 16'h0001;
//assign symbol_A[13] = 16'h0001;
//assign symbol_A[14] = 16'h0001;
//assign symbol_A[15] = 16'h0001;

wire [15:0] pixel_a   = (symbol_A[pixel_cnt/16][15-(pixel_cnt%16)]) ? 16'h07e0:16'h0000;
wire [15:0] pixel_b   = (symbol_B[pixel_cnt/16][15-(pixel_cnt%16)]) ? 16'h07e0:16'h0000;
wire [15:0] pixel_c   = (symbol_C[pixel_cnt/16][15-(pixel_cnt%16)]) ? 16'h07e0:16'h0000;
wire [15:0] pixel_d   = (symbol_D[pixel_cnt/16][15-(pixel_cnt%16)]) ? 16'h07e0:16'h0000;
wire [15:0] pixel_e   = (symbol_E[pixel_cnt/16][15-(pixel_cnt%16)]) ? 16'h07e0:16'h0000;


reg [7:0] cmd_cnt;
reg [2:0] char_cnt;
//wire [15:0] 
//wire [15:0] 

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

		pixel_cnt <= 0;
        cmd_cnt <= 0;
        word_column <= 0;
        char_cnt <= 0;

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
				if (pixel_cnt == 256) begin
					init_state <= INIT_10MS; // stop
                    pixel_cnt  <= 0;
                    clk_cnt    <= 0;
                    word_column<= 1;
                    char_cnt   <= 1;
				end else begin
					if (bit_loop == 0) begin
						// start
						lcd_cs_r <= 0;
						lcd_rs_r <= 1;
//						spi_data <= 8'hF8; // RED
						spi_data <= pixel_a[15:8];
						bit_loop <= bit_loop + 1;
					end else if (bit_loop == 8) begin
						// next byte
//						spi_data <= 8'h00; // RED
						spi_data <= pixel_a[7:0];
						bit_loop <= bit_loop + 1;
					end else if (bit_loop == 16) begin
						// end
						lcd_cs_r <= 1;
						lcd_rs_r <= 1;
						bit_loop <= 0;
						pixel_cnt <= pixel_cnt + 1; // next pixel
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
                                spi_data <= 8'h00;
                            end
                            2:begin 
                                lcd_rs_r <= 1;
                                spi_data <= (8'h28+word_column*16);
                            end
                            3:begin 
                                lcd_rs_r <= 1;
                                spi_data <= 8'h00;
                            end                 
                            4:begin 
                                lcd_rs_r <= 1;
                                spi_data <= (8'h37+word_column*16);
                            end

                            5:begin 
                                lcd_rs_r <= 0;
                                spi_data <= 8'h2b;
                            end
                            6:begin 
                                lcd_rs_r <= 1;
                                spi_data <= 8'h00;
                            end
                            7:begin 
                                lcd_rs_r <= 1;
                                spi_data <= 8'h35;
                            end
                            8:begin 
                                lcd_rs_r <= 1;
                                spi_data <= 8'h00;
                            end
                            9:begin 
                                lcd_rs_r <= 1;
                                spi_data <= 8'h44;
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
                if (pixel_cnt == 256) begin
                    if(word_column < 15) begin
                        char_cnt   <= char_cnt +1;
                        init_state <= INIT_10MS;
                        pixel_cnt  <= 0;
                        clk_cnt    <= 0;
                        word_column<= word_column+1;
                    end
                    else begin 
                            ;
//                         init_state <= INIT_10MS;
//                         pixel_cnt  <= 0;
//                         clk_cnt    <= 0;
//                         word_column<= word_column+1;
                    end
				end else begin
					if (bit_loop == 0) begin
						// start
						lcd_cs_r <= 0;
						lcd_rs_r <= 1;
//						spi_data <= 8'hF8; // RED
                        case (word_column)
                            1:spi_data <= pixel_b[15:8];
                            2:spi_data <= pixel_c[15:8];
                            3:spi_data <= pixel_d[15:8];
                            4:spi_data <= pixel_e[15:8];
                            default: spi_data <= 16'h0000;
                        endcase
						
						bit_loop <= bit_loop + 1;
					end else if (bit_loop == 8) begin
						// next byte
//						spi_data <= 8'h00; // RED
						//spi_data <= pixel_b[7:0];
                         case (word_column)
                            1:spi_data <= pixel_b[7:0];
                            2:spi_data <= pixel_c[7:0];
                            3:spi_data <= pixel_d[7:0];
                            4:spi_data <= pixel_e[7:0];
                            default: spi_data <= 16'h0000;
                        endcase
						bit_loop <= bit_loop + 1;
					end else if (bit_loop == 16) begin
						// end
						lcd_cs_r <= 1;
						lcd_rs_r <= 1;
						bit_loop <= 0;
						pixel_cnt <= pixel_cnt + 1; // next pixel
					end 
                    else begin
						// loop
						spi_data <= { spi_data[6:0], 1'b1 };
						bit_loop <= bit_loop + 1;
					end
				end
           end
		endcase
	end
end

endmodule
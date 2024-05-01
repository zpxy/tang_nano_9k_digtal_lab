module font(
    input [7:0]  word_column,
    input [7:0]  word_row,

    input [7:0]  pixel_char,
    input [15:0] pixel_cnt,
 
    output [15:0] x_start,
    output [15:0] x_end,
    output [15:0] y_start,
    output [15:0] y_end,

    output [15:0] pixel    
);

//在线点阵生成器 https://www.zhetao.com/fontarray.html

//font 16x16 36h:a0
//assign x_start = 8'h28 + word_column*16;
//assign x_end   = 8'h37 + word_column*16;
//assign y_start = 8'h34 + word_row*16;
//assign y_end   = 8'h43 + word_row*16;

//font 16x15 36h:a0，一共有9行，每行15个字，可以输出中文
assign x_start = 8'h28 + word_column*16;
assign x_end   = 8'h37 + word_column*16;
assign y_start = 8'h34 + word_row*15;
assign y_end   = 8'h42 + word_row*15;


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

wire [15:0] _n0 [15:0];
wire [15:0] _n1 [15:0];
wire [15:0] _n2 [15:0];
wire [15:0] _n3 [15:0];
wire [15:0] _n4 [15:0];
wire [15:0] _n5 [15:0];
wire [15:0] _n6 [15:0];
wire [15:0] _n7 [15:0];
wire [15:0] _n8 [15:0];
wire [15:0] _n9 [15:0];

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

assign symbol_F[0]  = 16'hff80;
assign symbol_F[1]  = 16'hff80;
assign symbol_F[2]  = 16'h7180;
assign symbol_F[3]  = 16'h7380;
assign symbol_F[4]  = 16'h7600;
assign symbol_F[5]  = 16'h7e00;
assign symbol_F[6]  = 16'h7e00;
assign symbol_F[7]  = 16'h7200;
assign symbol_F[8]  = 16'h7000;
assign symbol_F[9]  = 16'h7000;
assign symbol_F[10] = 16'hf800;
assign symbol_F[11] = 16'hf800;
assign symbol_F[12] = 16'h0000;
assign symbol_F[13] = 16'h0000;
assign symbol_F[14] = 16'h0000;
assign symbol_F[15] = 16'h0000;

assign symbol_G[0]  = 16'h1fc0;
assign symbol_G[1]  = 16'h3fc0;
assign symbol_G[2]  = 16'h78e0;
assign symbol_G[3]  = 16'hf060;
assign symbol_G[4]  = 16'he1f0;
assign symbol_G[5]  = 16'he1f0;
assign symbol_G[6]  = 16'he0e0;
assign symbol_G[7]  = 16'he0e0;
assign symbol_G[8]  = 16'hf0e0;
assign symbol_G[9]  = 16'h78e0;
assign symbol_G[10] = 16'h7fe0;
assign symbol_G[11] = 16'h1fc0;
assign symbol_G[12] = 16'h0000;
assign symbol_G[13] = 16'h0000;
assign symbol_G[14] = 16'h0000;
assign symbol_G[15] = 16'h0000;


assign symbol_H[0]  = 16'h70e0;
assign symbol_H[1]  = 16'h70e0;
assign symbol_H[2]  = 16'h70e0;
assign symbol_H[3]  = 16'h7f30;
assign symbol_H[4]  = 16'h7fe0;
assign symbol_H[5]  = 16'h7fe0;
assign symbol_H[6]  = 16'h7fe0;
assign symbol_H[7]  = 16'h7fe0;
assign symbol_H[8]  = 16'h70e0;
assign symbol_H[9]  = 16'h70e0;
assign symbol_H[10] = 16'h70e0;
assign symbol_H[11] = 16'h70e0;
assign symbol_H[12] = 16'h70e0;
assign symbol_H[13] = 16'h0000;
assign symbol_H[14] = 16'h0000;
assign symbol_H[15] = 16'h0000;


assign symbol_I[0]  = 16'h7c00;
assign symbol_I[1]  = 16'h7c00;
assign symbol_I[2]  = 16'h7c00;
assign symbol_I[3]  = 16'h3800;
assign symbol_I[4]  = 16'h3800;
assign symbol_I[5]  = 16'h3800;
assign symbol_I[6]  = 16'h3800;
assign symbol_I[7]  = 16'h3800;
assign symbol_I[8]  = 16'h3800;
assign symbol_I[9]  = 16'h3800;
assign symbol_I[10] = 16'h7c00;
assign symbol_I[11] = 16'h7c00;
assign symbol_I[12] = 16'h7c00;
assign symbol_I[13] = 16'h0000;
assign symbol_I[14] = 16'h0000;
assign symbol_I[15] = 16'h0000;


assign symbol_J[0]  = 16'h7c00;
assign symbol_J[1]  = 16'h7e00;
assign symbol_J[2]  = 16'h1800;
assign symbol_J[3]  = 16'h1800;
assign symbol_J[4]  = 16'h1800;
assign symbol_J[5]  = 16'h1800;
assign symbol_J[6]  = 16'h1800;
assign symbol_J[7]  = 16'h1800;
assign symbol_J[8]  = 16'h5800;
assign symbol_J[9]  = 16'hf800;
assign symbol_J[10] = 16'hf800;
assign symbol_J[11] = 16'hf000;
assign symbol_J[12] = 16'h0000;
assign symbol_J[13] = 16'h0000;
assign symbol_J[14] = 16'h0000;
assign symbol_J[15] = 16'h0000;


assign symbol_K[0]  = 16'hfbe0;
assign symbol_K[1]  = 16'hfbe0;
assign symbol_K[2]  = 16'h7780;
assign symbol_K[3]  = 16'h7f00;
assign symbol_K[4]  = 16'h7e00;
assign symbol_K[5]  = 16'h7c00;
assign symbol_K[6]  = 16'h7e00;
assign symbol_K[7]  = 16'h7f00;
assign symbol_K[8]  = 16'h7f80;
assign symbol_K[9]  = 16'h77c0;
assign symbol_K[10] = 16'hfbf0;
assign symbol_K[11] = 16'hfbf0;
assign symbol_K[12] = 16'h0000;
assign symbol_K[13] = 16'h0000;
assign symbol_K[14] = 16'h0000;
assign symbol_K[15] = 16'h0000;


assign symbol_L[0]  = 16'hf800;
assign symbol_L[1]  = 16'hfc00;
assign symbol_L[2]  = 16'h7000;
assign symbol_L[3]  = 16'h7000;
assign symbol_L[4]  = 16'h7000;
assign symbol_L[5]  = 16'h7000;
assign symbol_L[6]  = 16'h7000;
assign symbol_L[7]  = 16'h7040;
assign symbol_L[8]  = 16'h70c0;
assign symbol_L[9]  = 16'h71c0;
assign symbol_L[10] = 16'hffc0;
assign symbol_L[11] = 16'hff80;
assign symbol_L[12] = 16'h0000;
assign symbol_L[13] = 16'h0000;
assign symbol_L[14] = 16'h0000;
assign symbol_L[15] = 16'h0000;

assign symbol_M[0]  = 16'hf03c;
assign symbol_M[1]  = 16'hf83c;
assign symbol_M[2]  = 16'h7878;
assign symbol_M[3]  = 16'h7878;
assign symbol_M[4]  = 16'h7cf8;
assign symbol_M[5]  = 16'h7cf8;
assign symbol_M[6]  = 16'h7ff8;
assign symbol_M[7]  = 16'h6fb8;
assign symbol_M[8]  = 16'h6fb8;
assign symbol_M[9]  = 16'h67b8;
assign symbol_M[10] = 16'hf77c;
assign symbol_M[11] = 16'hf37c;
assign symbol_M[12] = 16'h0000;
assign symbol_M[13] = 16'h0000;
assign symbol_M[14] = 16'h0000;
assign symbol_M[15] = 16'h0000;

assign symbol_N[0]  = 16'hf1f0;
assign symbol_N[1]  = 16'hf9f0;
assign symbol_N[2]  = 16'h7840;
assign symbol_N[3]  = 16'h7c40;
assign symbol_N[4]  = 16'h7e40;
assign symbol_N[5]  = 16'h7f40;
assign symbol_N[6]  = 16'h6fc0;
assign symbol_N[7]  = 16'h67c0;
assign symbol_N[8]  = 16'h63c0;
assign symbol_N[9]  = 16'h61c0;
assign symbol_N[10] = 16'hf8c0;
assign symbol_N[11] = 16'hf8c0;
assign symbol_N[12] = 16'h0000;
assign symbol_N[13] = 16'h0000;
assign symbol_N[14] = 16'h0000;
assign symbol_N[15] = 16'h0000;

assign symbol_O[0]  = 16'h1f80;
assign symbol_O[1]  = 16'h7fc0;
assign symbol_O[2]  = 16'h79e0;
assign symbol_O[3]  = 16'hf0e0;
assign symbol_O[4]  = 16'he0e0;
assign symbol_O[5]  = 16'he060;
assign symbol_O[6]  = 16'he060;
assign symbol_O[7]  = 16'he0e0;
assign symbol_O[8]  = 16'hf0e0;
assign symbol_O[9]  = 16'h79e0;
assign symbol_O[10] = 16'h7fc0;
assign symbol_O[11] = 16'h3f80;
assign symbol_O[12] = 16'h0000;
assign symbol_O[13] = 16'h0000;
assign symbol_O[14] = 16'h0000;
assign symbol_O[15] = 16'h0000;

assign symbol_P[0]  = 16'hff00;
assign symbol_P[1]  = 16'hff80;
assign symbol_P[2]  = 16'h7780;
assign symbol_P[3]  = 16'h7380;
assign symbol_P[4]  = 16'h7780;
assign symbol_P[5]  = 16'h7f80;
assign symbol_P[6]  = 16'h7f00;
assign symbol_P[7]  = 16'h7000;
assign symbol_P[8]  = 16'h7000;
assign symbol_P[9]  = 16'h7000;
assign symbol_P[10] = 16'hf800;
assign symbol_P[11] = 16'hf800;
assign symbol_P[12] = 16'h0000;
assign symbol_P[13] = 16'h0000;
assign symbol_P[14] = 16'h0000;
assign symbol_P[15] = 16'h0000;

assign symbol_Q[0]  = 16'h0000;
assign symbol_Q[1]  = 16'h0000;
assign symbol_Q[2]  = 16'h0000;
assign symbol_Q[3]  = 16'h7e00;

assign symbol_Q[4]  = 16'h6600;
assign symbol_Q[5]  = 16'he600;
assign symbol_Q[6]  = 16'hc600;
assign symbol_Q[7]  = 16'hc600;

assign symbol_Q[8]  = 16'he600;
assign symbol_Q[9]  = 16'hfe00;
assign symbol_Q[10] = 16'h7e00;
assign symbol_Q[11] = 16'h0600;

assign symbol_Q[12] = 16'h0600;
assign symbol_Q[13] = 16'h0600;
assign symbol_Q[14] = 16'h0700;
assign symbol_Q[15] = 16'h0000;
//assign symbol_Q[0]  = 16'h1f80;
//assign symbol_Q[1]  = 16'h3fc0;
//assign symbol_Q[2]  = 16'h79e0;
//assign symbol_Q[3]  = 16'hf0e0;
//assign symbol_Q[4]  = 16'he0e0;
//assign symbol_Q[5]  = 16'he0e0;
//assign symbol_Q[6]  = 16'he060;
//assign symbol_Q[7]  = 16'he060;
//assign symbol_Q[8]  = 16'he0e0;
//assign symbol_Q[9]  = 16'hf0e0;
//assign symbol_Q[10] = 16'h79e0;
//assign symbol_Q[11] = 16'h3fc0;
//assign symbol_Q[12] = 16'h0000;
//assign symbol_Q[13] = 16'h0000;
//assign symbol_Q[14] = 16'h0000;
//assign symbol_Q[15] = 16'h0000;

assign symbol_R[0]  = 16'hff00;
assign symbol_R[1]  = 16'hff80;
assign symbol_R[2]  = 16'h7780;
assign symbol_R[3]  = 16'h7380;
assign symbol_R[4]  = 16'h7780;
assign symbol_R[5]  = 16'h7f80;
assign symbol_R[6]  = 16'h7f00;
assign symbol_R[7]  = 16'h7f00;
assign symbol_R[8]  = 16'h7780;
assign symbol_R[9]  = 16'h73c0;
assign symbol_R[10] = 16'hfbe0;
assign symbol_R[11] = 16'hf9e0;
assign symbol_R[12] = 16'h0000;
assign symbol_R[13] = 16'h0000;
assign symbol_R[14] = 16'h0000;
assign symbol_R[15] = 16'h0000;

assign symbol_S[0]  = 16'h3f00;
assign symbol_S[1]  = 16'h7f00;
assign symbol_S[2]  = 16'h6700;
assign symbol_S[3]  = 16'h7300;
assign symbol_S[4]  = 16'h7f00;
assign symbol_S[5]  = 16'h7e00;
assign symbol_S[6]  = 16'h3f00;
assign symbol_S[7]  = 16'h4f00;
assign symbol_S[8]  = 16'h4780;
assign symbol_S[9]  = 16'h6780;
assign symbol_S[10] = 16'h7f00;
assign symbol_S[11] = 16'h7f00;
assign symbol_S[12] = 16'h0000;
assign symbol_S[13] = 16'h0000;
assign symbol_S[14] = 16'h0000;
assign symbol_S[15] = 16'h0000;
   
assign symbol_T[0]  = 16'hffc0;
assign symbol_T[1]  = 16'hffc0;
assign symbol_T[2]  = 16'hccc0;
assign symbol_T[3]  = 16'h8c40;
assign symbol_T[4]  = 16'h0c00;
assign symbol_T[5]  = 16'h0c00;
assign symbol_T[6]  = 16'h0c00;
assign symbol_T[7]  = 16'h0c00;
assign symbol_T[8]  = 16'h0c00;
assign symbol_T[9]  = 16'h0c00;
assign symbol_T[10] = 16'h3f00;
assign symbol_T[11] = 16'h3f00;
assign symbol_T[12] = 16'h0000;
assign symbol_T[13] = 16'h0000;
assign symbol_T[14] = 16'h0000;
assign symbol_T[15] = 16'h0000;

assign symbol_U[0]  = 16'hf9f0;
assign symbol_U[1]  = 16'hf9f0;
assign symbol_U[2]  = 16'h7040;
assign symbol_U[3]  = 16'h7040;
assign symbol_U[4]  = 16'h7040;
assign symbol_U[5]  = 16'h7040;
assign symbol_U[6]  = 16'h7040;
assign symbol_U[7]  = 16'h7040;
assign symbol_U[8]  = 16'h70c0;
assign symbol_U[9]  = 16'h79c0;
assign symbol_U[10] = 16'h3fc0;
assign symbol_U[11] = 16'h3f80;
assign symbol_U[12] = 16'h0000;
assign symbol_U[13] = 16'h0000;
assign symbol_U[14] = 16'h0000;
assign symbol_U[15] = 16'h0000;

assign symbol_V[0]  = 16'hf8f0;
assign symbol_V[1]  = 16'hf8f0;
assign symbol_V[2]  = 16'h70e0;
assign symbol_V[3]  = 16'h78c0;
assign symbol_V[4]  = 16'h39c0;
assign symbol_V[5]  = 16'h3d80;
assign symbol_V[6]  = 16'h1d80;
assign symbol_V[7]  = 16'h1f80;
assign symbol_V[8]  = 16'h0f00;
assign symbol_V[9]  = 16'h0f00;
assign symbol_V[10] = 16'h0600;
assign symbol_V[11] = 16'h0600;
assign symbol_V[12] = 16'h0000;
assign symbol_V[13] = 16'h0000;
assign symbol_V[14] = 16'h0000;
assign symbol_V[15] = 16'h0000;

assign symbol_W[0]  = 16'hf7de;
assign symbol_W[1]  = 16'hffde;
assign symbol_W[2]  = 16'h738c;
assign symbol_W[3]  = 16'h73cc;
assign symbol_W[4]  = 16'h3bdc;
assign symbol_W[5]  = 16'h3bd8;
assign symbol_W[6]  = 16'h3ff8;
assign symbol_W[7]  = 16'h1ef8;
assign symbol_W[8]  = 16'h1ef0;
assign symbol_W[9]  = 16'h1e70;
assign symbol_W[10] = 16'h0c60;
assign symbol_W[11] = 16'h0c60;
assign symbol_W[12] = 16'h0000;
assign symbol_W[13] = 16'h0000;
assign symbol_W[14] = 16'h0000;
assign symbol_W[15] = 16'h0000;

assign symbol_X[0]  = 16'h0000;
assign symbol_X[1]  = 16'hfdf0;
assign symbol_X[2]  = 16'h3dc0;
assign symbol_X[3]  = 16'h3f80;
assign symbol_X[4]  = 16'h1f00;
assign symbol_X[5]  = 16'h0f00;
assign symbol_X[6]  = 16'h0f00;
assign symbol_X[7]  = 16'h1f80;
assign symbol_X[8]  = 16'h3bc0;
assign symbol_X[9]  = 16'h7bc0;
assign symbol_X[10] = 16'h73f0;
assign symbol_X[11] = 16'hf3f0;
assign symbol_X[12] = 16'h0000;
assign symbol_X[13] = 16'h0000;
assign symbol_X[14] = 16'h0000;
assign symbol_X[15] = 16'h0000;


assign symbol_Y[0]  = 16'h0000;
assign symbol_Y[1]  = 16'hf9f0;
assign symbol_Y[2]  = 16'h79c0;
assign symbol_Y[3]  = 16'h39c0;
assign symbol_Y[4]  = 16'h3f80;
assign symbol_Y[5]  = 16'h1f00;
assign symbol_Y[6]  = 16'h0f00;
assign symbol_Y[7]  = 16'h0e00;
assign symbol_Y[8]  = 16'h0e00;
assign symbol_Y[9]  = 16'h0e00;
assign symbol_Y[10] = 16'h1f00;
assign symbol_Y[11] = 16'h1f00;
assign symbol_Y[12] = 16'h0000;
assign symbol_Y[13] = 16'h0000;
assign symbol_Y[14] = 16'h0000;
assign symbol_Y[15] = 16'h0000;


assign symbol_Z[0]  = 16'h0000;
assign symbol_Z[1]  = 16'h7fc0;
assign symbol_Z[2]  = 16'h6780;
assign symbol_Z[3]  = 16'h4f00;
assign symbol_Z[4]  = 16'h0f00;
assign symbol_Z[5]  = 16'h1e00;
assign symbol_Z[6]  = 16'h3c00;
assign symbol_Z[7]  = 16'h3c00;
assign symbol_Z[8]  = 16'h78c0;
assign symbol_Z[9]  = 16'hf0c0;
assign symbol_Z[10] = 16'hffc0;
assign symbol_Z[11] = 16'hff80;
assign symbol_Z[12] = 16'h0000;
assign symbol_Z[13] = 16'h0000;
assign symbol_Z[14] = 16'h0000;
assign symbol_Z[15] = 16'h0000;

assign _n0[0]  = 16'h0000;
assign _n0[1]  = 16'h7e00;
assign _n0[2]  = 16'h7600;
assign _n0[3]  = 16'h7600;
assign _n0[4]  = 16'he700;
assign _n0[5]  = 16'he700;
assign _n0[6]  = 16'he700;
assign _n0[7]  = 16'he700;
assign _n0[8]  = 16'he700;
assign _n0[9]  = 16'h6600;
assign _n0[10] = 16'h7e00;
assign _n0[11] = 16'h3c00;
assign _n0[12] = 16'h0000;
assign _n0[13] = 16'h0000;
assign _n0[14] = 16'h0000;
assign _n0[15] = 16'h0000;

assign _n1[0]  = 16'h0000;
assign _n1[1]  = 16'h1e00;
assign _n1[2]  = 16'h3e00;
assign _n1[3]  = 16'h3e00;
assign _n1[4]  = 16'h3e00;
assign _n1[5]  = 16'h0e00;
assign _n1[6]  = 16'h0e00;
assign _n1[7]  = 16'h0e00;
assign _n1[8]  = 16'h0e00;
assign _n1[9]  = 16'h0e00;
assign _n1[10] = 16'h0e00;
assign _n1[11] = 16'h3f80;
assign _n1[12] = 16'h3f80;
assign _n1[13] = 16'h0000;
assign _n1[14] = 16'h0000;
assign _n1[15] = 16'h0000;

assign _n2[0]  = 16'h0000;
assign _n2[1]  = 16'h7f80;
assign _n2[2]  = 16'h7f80;
assign _n2[3]  = 16'h6380;
assign _n2[4]  = 16'h0380;
assign _n2[5]  = 16'h0380;
assign _n2[6]  = 16'h0780;
assign _n2[7]  = 16'h0f00;
assign _n2[8]  = 16'h3e00;
assign _n2[9]  = 16'h7c00;
assign _n2[10] = 16'h7fc0;
assign _n2[11] = 16'h7fc0;
assign _n2[12] = 16'h7fc0;
assign _n2[13] = 16'h0000;
assign _n2[14] = 16'h0000;
assign _n2[15] = 16'h0000;

assign _n3[0]  = 16'h0000;
assign _n3[1]  = 16'h7f80;
assign _n3[2]  = 16'h7f80;
assign _n3[3]  = 16'h6380;
assign _n3[4]  = 16'h0f80;
assign _n3[5]  = 16'h0f80;
assign _n3[6]  = 16'h0f80;
assign _n3[7]  = 16'h0f80;
assign _n3[8]  = 16'h0180;
assign _n3[9]  = 16'h4380;
assign _n3[10] = 16'h7f80;
assign _n3[11] = 16'h7f80;
assign _n3[12] = 16'h7f00;
assign _n3[13] = 16'h0000;
assign _n3[14] = 16'h0000;
assign _n3[15] = 16'h0000;

assign _n4[0]  = 16'h0000;
assign _n4[1]  = 16'h0f00;
assign _n4[2]  = 16'h1f00;
assign _n4[3]  = 16'h3f00;
assign _n4[4]  = 16'h3f00;
assign _n4[5]  = 16'h7b00;
assign _n4[6]  = 16'hffc0;
assign _n4[7]  = 16'hffc0;
assign _n4[8]  = 16'hffc0;
assign _n4[9]  = 16'hffc0;
assign _n4[10] = 16'h0300;
assign _n4[11] = 16'h0300;
assign _n4[12] = 16'h0300;
assign _n4[13] = 16'h0000;
assign _n4[14] = 16'h0000;
assign _n4[15] = 16'h0000;

assign _n5[0]  = 16'h0000;
assign _n5[1]  = 16'h7f80;
assign _n5[2]  = 16'h7f80;
assign _n5[3]  = 16'h7000;
assign _n5[4]  = 16'h7800;
assign _n5[5]  = 16'h7f00;
assign _n5[6]  = 16'h7f80;
assign _n5[7]  = 16'h7f80;
assign _n5[8]  = 16'h01c0;
assign _n5[9]  = 16'h43c0;
assign _n5[10] = 16'h7f80;
assign _n5[11] = 16'h7f80;
assign _n5[12] = 16'h7f00;
assign _n5[13] = 16'h0000;
assign _n5[14] = 16'h0000;
assign _n5[15] = 16'h0000;
   
assign _n6[0]  = 16'h0000;
assign _n6[1]  = 16'h3f80;
assign _n6[2]  = 16'h7f80;
assign _n6[3]  = 16'h7800;
assign _n6[4]  = 16'h7f80;
assign _n6[5]  = 16'h7f80;
assign _n6[6]  = 16'h7fc0;
assign _n6[7]  = 16'h61c0;
assign _n6[8]  = 16'h61c0;
assign _n6[9]  = 16'h71c0;
assign _n6[10] = 16'h7fc0;
assign _n6[11] = 16'h7f80;
assign _n6[12] = 16'h3f00;
assign _n6[13] = 16'h0000;
assign _n6[14] = 16'h0000;
assign _n6[15] = 16'h0000;
    
assign _n7[0]  = 16'h0000;
assign _n7[1]  = 16'h7fc0;
assign _n7[2]  = 16'h7fc0;
assign _n7[3]  = 16'h0380;
assign _n7[4]  = 16'h0380;
assign _n7[5]  = 16'h0700;
assign _n7[6]  = 16'h0f00;
assign _n7[7]  = 16'h0e00;
assign _n7[8]  = 16'h1e00;
assign _n7[9]  = 16'h1c00;
assign _n7[10] = 16'h3c00;
assign _n7[11] = 16'h3800;
assign _n7[12] = 16'h3800;
assign _n7[13] = 16'h0000;
assign _n7[14] = 16'h0000;
assign _n7[15] = 16'h0000;

assign _n8[0]  = 16'h0000;
assign _n8[1]  = 16'h7f80;
assign _n8[2]  = 16'h7f80;
assign _n8[3]  = 16'h7180;
assign _n8[4]  = 16'h7b80;
assign _n8[5]  = 16'h7f80;
assign _n8[6]  = 16'h7f80;
assign _n8[7]  = 16'h7fc0;
assign _n8[8]  = 16'he3c0;
assign _n8[9]  = 16'hf1c0;
assign _n8[10] = 16'h7fc0;
assign _n8[11] = 16'h7f80;
assign _n8[12] = 16'h3f00;
assign _n8[13] = 16'h0000;
assign _n8[14] = 16'h0000;
assign _n8[15] = 16'h0000;

assign _n9[0]  = 16'h0000;
assign _n9[1]  = 16'h7f80;
assign _n9[2]  = 16'h7f80;
assign _n9[3]  = 16'he380;
assign _n9[4]  = 16'he1c0;
assign _n9[5]  = 16'hffc0;
assign _n9[6]  = 16'h7fc0;
assign _n9[7]  = 16'h7fc0;
assign _n9[8]  = 16'h1f80;
assign _n9[9]  = 16'h0780;
assign _n9[10] = 16'h3f80;
assign _n9[11] = 16'h3f00;
assign _n9[12] = 16'h3e00;
assign _n9[13] = 16'h0000;
assign _n9[14] = 16'h0000;
assign _n9[15] = 16'h0000;


wire [15:0] pixel_a   = (symbol_A[pixel_cnt/16][15-(pixel_cnt%16)]) ? 16'h07e0:16'h0000;
wire [15:0] pixel_b   = (symbol_B[pixel_cnt/16][15-(pixel_cnt%16)]) ? 16'h07e0:16'h0000;
wire [15:0] pixel_c   = (symbol_C[pixel_cnt/16][15-(pixel_cnt%16)]) ? 16'h07e0:16'h0000;
wire [15:0] pixel_d   = (symbol_D[pixel_cnt/16][15-(pixel_cnt%16)]) ? 16'h07e0:16'h0000;
wire [15:0] pixel_e   = (symbol_E[pixel_cnt/16][15-(pixel_cnt%16)]) ? 16'h07e0:16'h0000;
wire [15:0] pixel_f   = (symbol_F[pixel_cnt/16][15-(pixel_cnt%16)]) ? 16'h07e0:16'h0000;
wire [15:0] pixel_g   = (symbol_G[pixel_cnt/16][15-(pixel_cnt%16)]) ? 16'h07e0:16'h0000;

wire [15:0] pixel_h   = (symbol_H[pixel_cnt/16][15-(pixel_cnt%16)]) ? 16'h07e0:16'h0000;
wire [15:0] pixel_i   = (symbol_I[pixel_cnt/16][15-(pixel_cnt%16)]) ? 16'h07e0:16'h0000;
wire [15:0] pixel_j   = (symbol_J[pixel_cnt/16][15-(pixel_cnt%16)]) ? 16'h07e0:16'h0000;
wire [15:0] pixel_k   = (symbol_K[pixel_cnt/16][15-(pixel_cnt%16)]) ? 16'h07e0:16'h0000;
wire [15:0] pixel_l   = (symbol_L[pixel_cnt/16][15-(pixel_cnt%16)]) ? 16'h07e0:16'h0000;
wire [15:0] pixel_m   = (symbol_M[pixel_cnt/16][15-(pixel_cnt%16)]) ? 16'h07e0:16'h0000;
wire [15:0] pixel_n   = (symbol_N[pixel_cnt/16][15-(pixel_cnt%16)]) ? 16'h07e0:16'h0000;

wire [15:0] pixel_o   = (symbol_O[pixel_cnt/16][15-(pixel_cnt%16)]) ? 16'h07e0:16'h0000;
wire [15:0] pixel_p   = (symbol_P[pixel_cnt/16][15-(pixel_cnt%16)]) ? 16'h07e0:16'h0000;
wire [15:0] pixel_q   = (symbol_Q[pixel_cnt/16][15-(pixel_cnt%16)]) ? 16'h07e0:16'h0000;
wire [15:0] pixel_r   = (symbol_R[pixel_cnt/16][15-(pixel_cnt%16)]) ? 16'h07e0:16'h0000;
wire [15:0] pixel_s   = (symbol_S[pixel_cnt/16][15-(pixel_cnt%16)]) ? 16'h07e0:16'h0000;
wire [15:0] pixel_t   = (symbol_T[pixel_cnt/16][15-(pixel_cnt%16)]) ? 16'h07e0:16'h0000;
wire [15:0] pixel_u   = (symbol_U[pixel_cnt/16][15-(pixel_cnt%16)]) ? 16'h07e0:16'h0000;
wire [15:0] pixel_v   = (symbol_V[pixel_cnt/16][15-(pixel_cnt%16)]) ? 16'h07e0:16'h0000;
wire [15:0] pixel_w   = (symbol_W[pixel_cnt/16][15-(pixel_cnt%16)]) ? 16'h07e0:16'h0000;
wire [15:0] pixel_x   = (symbol_X[pixel_cnt/16][15-(pixel_cnt%16)]) ? 16'h07e0:16'h0000;
wire [15:0] pixel_y   = (symbol_Y[pixel_cnt/16][15-(pixel_cnt%16)]) ? 16'h07e0:16'h0000;
wire [15:0] pixel_z   = (symbol_Z[pixel_cnt/16][15-(pixel_cnt%16)]) ? 16'h07e0:16'h0000;

wire [15:0] pixel_n0   = (_n0[pixel_cnt/16][15-(pixel_cnt%16)]) ? 16'h07e0:16'h0000;
wire [15:0] pixel_n1   = (_n1[pixel_cnt/16][15-(pixel_cnt%16)]) ? 16'h07e0:16'h0000;
wire [15:0] pixel_n2   = (_n2[pixel_cnt/16][15-(pixel_cnt%16)]) ? 16'h07e0:16'h0000;
wire [15:0] pixel_n3   = (_n3[pixel_cnt/16][15-(pixel_cnt%16)]) ? 16'h07e0:16'h0000;
wire [15:0] pixel_n4   = (_n4[pixel_cnt/16][15-(pixel_cnt%16)]) ? 16'h07e0:16'h0000;
wire [15:0] pixel_n5   = (_n5[pixel_cnt/16][15-(pixel_cnt%16)]) ? 16'h07e0:16'h0000;
wire [15:0] pixel_n6   = (_n6[pixel_cnt/16][15-(pixel_cnt%16)]) ? 16'h07e0:16'h0000;
wire [15:0] pixel_n7   = (_n7[pixel_cnt/16][15-(pixel_cnt%16)]) ? 16'h07e0:16'h0000;
wire [15:0] pixel_n8   = (_n8[pixel_cnt/16][15-(pixel_cnt%16)]) ? 16'h07e0:16'h0000;
wire [15:0] pixel_n9   = (_n9[pixel_cnt/16][15-(pixel_cnt%16)]) ? 16'h07e0:16'h0000;


//assign pixel = ( pixel_char == 8'h41)? pixel_a : 
//               ((pixel_char == 8'h42)? pixel_b :  
//               ((pixel_char == 8'h43)? pixel_c :  
//               ((pixel_char == 8'h44)? pixel_d : 
//               ((pixel_char == 8'h45)? pixel_e : 
//               ((pixel_char == 8'h46)? pixel_f :
//               ((pixel_char == 8'h47)? pixel_g :
//               ((pixel_char == 8'h48)? pixel_h : _space)))))));

wire [15:0] ch_z  = ( pixel_char == 8'h5a)? pixel_z : 16'h0000;
wire [15:0] ch_y  = ( pixel_char == 8'h59)? pixel_y : ch_z;
wire [15:0] ch_x  = ( pixel_char == 8'h58)? pixel_x : ch_y;
wire [15:0] ch_w  = ( pixel_char == 8'h57)? pixel_w : ch_x;
wire [15:0] ch_v  = ( pixel_char == 8'h56)? pixel_v : ch_w;
wire [15:0] ch_u  = ( pixel_char == 8'h55)? pixel_u : ch_v;

wire [15:0] ch_t  = ( pixel_char == 8'h54)? pixel_t : ch_u;
wire [15:0] ch_s  = ( pixel_char == 8'h53)? pixel_s : ch_t;
wire [15:0] ch_r  = ( pixel_char == 8'h52)? pixel_r : ch_s;
wire [15:0] ch_q  = ( pixel_char == 8'h51)? pixel_q : ch_r;
wire [15:0] ch_p  = ( pixel_char == 8'h50)? pixel_p : ch_q;
wire [15:0] ch_o  = ( pixel_char == 8'h4f)? pixel_o : ch_p;

wire [15:0] ch_n  = ( pixel_char == 8'h4e)? pixel_n : ch_o;
wire [15:0] ch_m  = ( pixel_char == 8'h4d)? pixel_m : ch_n;
wire [15:0] ch_l  = ( pixel_char == 8'h4c)? pixel_l : ch_m;
wire [15:0] ch_k  = ( pixel_char == 8'h4b)? pixel_k : ch_l;
wire [15:0] ch_j  = ( pixel_char == 8'h4a)? pixel_j : ch_k;
wire [15:0] ch_i  = ( pixel_char == 8'h49)? pixel_i : ch_j;
wire [15:0] ch_h  = ( pixel_char == 8'h48)? pixel_h : ch_i;

wire [15:0] ch_g  = ( pixel_char == 8'h47)? pixel_g : ch_h;
wire [15:0] ch_f  = ( pixel_char == 8'h46)? pixel_f : ch_g;
wire [15:0] ch_e  = ( pixel_char == 8'h45)? pixel_e : ch_f;
wire [15:0] ch_d  = ( pixel_char == 8'h44)? pixel_d : ch_e;
wire [15:0] ch_c  = ( pixel_char == 8'h43)? pixel_c : ch_d;
wire [15:0] ch_b  = ( pixel_char == 8'h42)? pixel_b : ch_c;
wire [15:0] ch_a  = ( pixel_char == 8'h41)? pixel_a : ch_b;
wire [15:0] ch_n9 = ( pixel_char == 8'h39)? pixel_n9 : ch_a;

wire [15:0] ch_n8 = ( pixel_char == 8'h38)? pixel_n8 : ch_n9;
wire [15:0] ch_n7 = ( pixel_char == 8'h37)? pixel_n7 : ch_n8;
wire [15:0] ch_n6 = ( pixel_char == 8'h36)? pixel_n6 : ch_n7;
wire [15:0] ch_n5 = ( pixel_char == 8'h35)? pixel_n5 : ch_n6;
wire [15:0] ch_n4 = ( pixel_char == 8'h34)? pixel_n4 : ch_n5;
wire [15:0] ch_n3 = ( pixel_char == 8'h33)? pixel_n3 : ch_n4;
wire [15:0] ch_n2 = ( pixel_char == 8'h32)? pixel_n2 : ch_n3;
wire [15:0] ch_n1 = ( pixel_char == 8'h31)? pixel_n1 : ch_n2;
wire [15:0] ch    = ( pixel_char == 8'h30)? pixel_n0 : ch_n1;

assign pixel = ch;

//下面这个写法将导致出现问题

//assign pixel = ( pixel_char == 8'h30)? pixel_n0 :
//               ((pixel_char == 8'h31)? pixel_n1 :
//               ((pixel_char == 8'h32)? pixel_n2 :
//               ((pixel_char == 8'h33)? pixel_n3 :
//               ((pixel_char == 8'h34)? pixel_n4 :
//               ((pixel_char == 8'h35)? pixel_n5 :
//               ((pixel_char == 8'h36)? pixel_n6 :
//               ((pixel_char == 8'h37)? pixel_n7 :
//               ((pixel_char == 8'h38)? pixel_n8 :
//               ((pixel_char == 8'h39)? pixel_n9 :
//               ((pixel_char == 8'h41)? pixel_a : 
//               ((pixel_char == 8'h42)? pixel_b :  
//               ((pixel_char == 8'h43)? pixel_c :  
//               ((pixel_char == 8'h44)? pixel_d : 
//               ((pixel_char == 8'h45)? pixel_e : 
//               ((pixel_char == 8'h46)? pixel_f :
//               ((pixel_char == 8'h47)? pixel_g :
//               ((pixel_char == 8'h48)? pixel_h :
//               ((pixel_char == 8'h49)? pixel_i :
//               ((pixel_char == 8'h4a)? pixel_j :
//               ((pixel_char == 8'h4b)? pixel_k :
//               ((pixel_char == 8'h4c)? pixel_l :
//               ((pixel_char == 8'h4d)? pixel_m : _space))))))))))))))))))))));
//               ((pixel_char == 8'h4e)? pixel_n :
//               ((pixel_char == 8'h4f)? pixel_o : 
//               ((pixel_char == 8'h50)? pixel_p :
//               ((pixel_char == 8'h51)? pixel_q :
//               ((pixel_char == 8'h52)? pixel_r :
//               ((pixel_char == 8'h53)? pixel_s :
//               ((pixel_char == 8'h54)? pixel_t :
//               ((pixel_char == 8'h55)? pixel_u :
//               ((pixel_char == 8'h56)? pixel_v :
//               ((pixel_char == 8'h57)? pixel_w :
//               ((pixel_char == 8'h58)? pixel_x :
//               ((pixel_char == 8'h59)? pixel_y :
//               ((pixel_char == 8'h5a)? pixel_z : _space)))))))))))))))))))))))))))))))))));
               
endmodule
module top(
    input clk,
    input n_rst,

    input signed [7:0] xn,

    output reg signed [7:0] yn
);

reg signed [7:0] d_xn;
always @(posedge clk or negedge n_rst)
    if(!n_rst)
        d_xn <= 8'h0;
    else
        d_xn <= xn;

//##깁스 있는 param => tb_yes
localparam signed [7:0] B0  = 8'd6;
localparam signed [7:0] B1  = 8'd0;
localparam signed [7:0] B2  = -8'd8;
localparam signed [7:0] B3  = -8'd14;
localparam signed [7:0] B4  = -8'd12;
localparam signed [7:0] B5  = 8'd0;
localparam signed [7:0] B6  = 8'd19;
localparam signed [7:0] B7  = 8'd41;
localparam signed [7:0] B8  = 8'd58;
localparam signed [7:0] B9  = 8'd64; //정중앙 최고값

wire signed [7:0] xn1, xn2, xn3, xn4, xn5, xn6, xn7, xn8, xn9, xn10;
wire signed [7:0] xn11, xn12, xn13, xn14, xn15, xn16, xn17, xn18;

// 🚨 adder10도 다른 adder들과 동일하게 9비트로 통일
wire signed [8:0] adder10, p_adder10;

wire signed [8:0] adder1,adder2,adder3,adder4,adder5,adder6,adder7,adder8,adder9;
wire signed [8:0] p_adder1,p_adder2,p_adder3,p_adder4,p_adder5,p_adder6,p_adder7,p_adder8,p_adder9;

// 🚨 product 출력들이 모두 17비트로 확장됨
wire signed [16:0] product1,product2, product3, product4, product5, product6, product7, product8, product9, product10;

d_ff u_dff_1(
    .clk(clk),
    .n_rst(n_rst),
    .d(d_xn),
    .q(xn1)
);

d_ff u_dff_2(
    .clk(clk),
    .n_rst(n_rst),
    .d(xn1),
    .q(xn2)
);

d_ff u_dff_3(
    .clk(clk),
    .n_rst(n_rst),
    .d(xn2),
    .q(xn3)
);

d_ff u_dff_4(
    .clk(clk),
    .n_rst(n_rst),
    .d(xn3),
    .q(xn4)
);

d_ff u_dff_5(
    .clk(clk),
    .n_rst(n_rst),
    .d(xn4),
    .q(xn5)
);

d_ff u_dff_6(
    .clk(clk),
    .n_rst(n_rst),
    .d(xn5),
    .q(xn6)
);

d_ff u_dff_7(
    .clk(clk),
    .n_rst(n_rst),
    .d(xn6),
    .q(xn7)
);

d_ff u_dff_8(
    .clk(clk),
    .n_rst(n_rst),
    .d(xn7),
    .q(xn8)
);

d_ff u_dff_9(
    .clk(clk),
    .n_rst(n_rst),
    .d(xn8),
    .q(xn9)
);

d_ff u_dff_10(
    .clk(clk),
    .n_rst(n_rst),
    .d(xn9),
    .q(xn10)
);

d_ff u_dff_11(
    .clk(clk),
    .n_rst(n_rst),
    .d(xn10),
    .q(xn11)
);

d_ff u_dff_12(
    .clk(clk),
    .n_rst(n_rst),
    .d(xn11),
    .q(xn12)
);

d_ff u_dff_13(
    .clk(clk),
    .n_rst(n_rst),
    .d(xn12),
    .q(xn13)
);

d_ff u_dff_14(
    .clk(clk),
    .n_rst(n_rst),
    .d(xn13),
    .q(xn14)
);

d_ff u_dff_15(
    .clk(clk),
    .n_rst(n_rst),
    .d(xn14),
    .q(xn15)
);

d_ff u_dff_16(
    .clk(clk),
    .n_rst(n_rst),
    .d(xn15),
    .q(xn16)
);

d_ff u_dff_17(
    .clk(clk),
    .n_rst(n_rst),
    .d(xn16),
    .q(xn17)
);

d_ff u_dff_18(
    .clk(clk),
    .n_rst(n_rst),
    .d(xn17),
    .q(xn18)
);

assign adder1 = d_xn  + xn18;
assign adder2 = xn1 + xn17;
assign adder3 = xn2 + xn16;
assign adder4 = xn3 + xn15;
assign adder5 = xn4 + xn14;
assign adder6 = xn5 + xn13;
assign adder7 = xn6 + xn12;
assign adder8 = xn7 + xn11;
assign adder9 = xn8 + xn10;
assign adder10 = xn9; // 8비트 xn9가 9비트 adder10에 들어가며 자동 부호 확장됨

pipe_1 u_pipe1(
    .clk(clk),
    .n_rst(n_rst),

    .adder1(adder1),
    .adder2(adder2),
    .adder3(adder3),
    .adder4(adder4),
    .adder5(adder5),
    .adder6(adder6),
    .adder7(adder7),
    .adder8(adder8),
    .adder9(adder9),
    .adder10(adder10),

    .p_adder1(p_adder1),
    .p_adder2(p_adder2),
    .p_adder3(p_adder3),
    .p_adder4(p_adder4),
    .p_adder5(p_adder5),
    .p_adder6(p_adder6),
    .p_adder7(p_adder7),
    .p_adder8(p_adder8),
    .p_adder9(p_adder9),
    .p_adder10(p_adder10)
);

// 🚨 비트 자르기([8:1]) 모두 삭제! p_adder 9비트 전체를 다이렉트로 곱셈기에 입력
product #(.COEF(B0)) u_product_1(
    .clk(clk),
    .n_rst(n_rst),
    .da(p_adder1), 
    .product(product1)
);

product #(.COEF(B1)) u_product_2(
    .clk(clk),
    .n_rst(n_rst),
    .da(p_adder2),
    .product(product2)
);

product #(.COEF(B2)) u_product_3(
    .clk(clk),
    .n_rst(n_rst),
    .da(p_adder3),
    .product(product3)
);

product #(.COEF(B3)) u_product_4(
    .clk(clk),
    .n_rst(n_rst),
    .da(p_adder4),
    .product(product4)
);

product #(.COEF(B4)) u_product_5(
    .clk(clk),
    .n_rst(n_rst),
    .da(p_adder5),
    .product(product5)
);

product #(.COEF(B5)) u_product_6(
    .clk(clk),
    .n_rst(n_rst),
    .da(p_adder6),
    .product(product6)
);

product #(.COEF(B6)) u_product_7(
    .clk(clk),
    .n_rst(n_rst),
    .da(p_adder7),
    .product(product7)
);

product #(.COEF(B7)) u_product_8(
    .clk(clk),
    .n_rst(n_rst),
    .da(p_adder8),
    .product(product8)
);

product #(.COEF(B8)) u_product_9(
    .clk(clk),
    .n_rst(n_rst),
    .da(p_adder9),
    .product(product9)
);

product #(.COEF(B9)) u_product_10(
    .clk(clk),
    .n_rst(n_rst),
    .da(p_adder10), 
    .product(product10)
);
//################################################################곱셈기 끝

// 🚨 덧셈 트리도 비트 수 증가에 맞춰서 확장
wire signed [17:0] product_add1, product_add2, product_add3, product_add4, product_add5;

// 파이프 2 출력들도 모두 17비트로 확장됨
wire signed [16:0] p_product1,p_product2,p_product3,p_product4,p_product5,p_product6,p_product7,p_product8,p_product9,p_product10;

pipe_2 u_pipe2(
    .clk(clk),
    .n_rst(n_rst),

    .product1(product1),
    .product2(product2),
    .product3(product3),
    .product4(product4),
    .product5(product5),
    .product6(product6),
    .product7(product7),
    .product8(product8),
    .product9(product9),
    .product10(product10),    

    .p_product1(p_product1),
    .p_product2(p_product2),
    .p_product3(p_product3),
    .p_product4(p_product4),
    .p_product5(p_product5),
    .p_product6(p_product6),
    .p_product7(p_product7),
    .p_product8(p_product8),
    .p_product9(p_product9),
    .p_product10(p_product10)

);

assign product_add1 = p_product1;
assign product_add2 = p_product3 + p_product4;
assign product_add3 = p_product5;
assign product_add4 = p_product7 + p_product8;
assign product_add5 = p_product9 + p_product10;

//덧셈기 2번 (19비트로 확장)
wire signed [18:0] product_add_add1, product_add_add2;

assign product_add_add1 = product_add1 + product_add2;
assign product_add_add2 = product_add3 + product_add4;

//덧셈기 3번 (20비트로 확장)
wire signed [19:0] product_add_add_add1;

assign product_add_add_add1 = product_add_add1 + product_add5;

//덧셈기 4번 (21비트로 확장)
wire signed [20:0] product_add_add_add_add2;

assign product_add_add_add_add2 = product_add_add_add1 + product_add_add2;

//shift연산
wire signed [12:0] shift_product_add; // 21비트에서 8자리를 깎아내므로 13비트가 됨

// 🚨 곱셈기 입력 전 나누기 2를 없앴으므로, 여기서 한 번에 나누기 256을 수행
// 반올림을 위해 256의 절반인 128을 더함
wire signed [20:0] rounded_product_add;
assign rounded_product_add = product_add_add_add_add2 + 21'sd128; 
assign shift_product_add = rounded_product_add[20:8]; // 나누기 256 (>> 8)

// 클리핑 로직 (13비트 조건에 맞게 업데이트)
wire signed [7:0] clipped_result;
assign clipped_result = (shift_product_add[12:7] == 6'b000000 || shift_product_add[12:7] == 6'b111111) ? shift_product_add[7:0] : 
                        (shift_product_add[12] == 1'b0) ? 8'd127 : 
                                                         -8'd128; // 부호 있는 8비트 최솟값은 -128

always @(posedge clk or negedge n_rst)
    if(!n_rst)
        yn <= 8'h0;
    else
        yn <= clipped_result;

endmodule
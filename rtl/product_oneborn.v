module product #(
    parameter signed [7:0] COEF = 8'sd0 
)(
    input clk,
    input n_rst,

    input signed [8:0] da,        // 🚨 8비트 -> 9비트로 확장 (자르지 않은 값 입력)
    output signed [16:0] product  // 🚨 15비트 -> 17비트로 확장 (9 + 8 = 17)
);

// 입력 데이터 플립플롭 
reg signed [8:0] da_reg;          // 🚨 레지스터도 9비트로 확장

always @(posedge clk or negedge n_rst) begin
    if(!n_rst)
        da_reg <= 9'd0;
    else
        da_reg <= da;
end

// 내부적으로 17비트 signed 곱셈 수행
wire signed [16:0] full_product;
assign full_product = da_reg * COEF;

// 🚨 비트를 잘라내지 않고 17비트 풀 정밀도를 그대로 출력
assign product = full_product;

endmodule
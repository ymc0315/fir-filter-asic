
module pipe_2(
    input clk,
    input n_rst,
    
    input [16:0] product1,
    // input [16:0] product2,
    input [16:0] product3,
    input [16:0] product4,
    input [16:0] product5,
    // input [16:0] product6,
    input [16:0] product7,
    input [16:0] product8,
    input [16:0] product9,
    input [16:0] product10,

    output reg [16:0] p_product1,
    // output reg [16:0] p_product2,
    output reg [16:0] p_product3,
    output reg [16:0] p_product4,
    output reg [16:0] p_product5,
    // output reg [16:0] p_product6,
    output reg [16:0] p_product7,
    output reg [16:0] p_product8,
    output reg [16:0] p_product9,
    output reg [16:0] p_product10
);

always @(posedge clk or negedge n_rst)
    if(!n_rst) begin
        p_product1 <= 17'h0;
        // p_product2 <= 17'h0;
        p_product3 <= 17'h0;
        p_product4 <= 17'h0;
        p_product5 <= 17'h0;
        // p_product6 <= 17'h0;
        p_product7 <= 17'h0;
        p_product8 <= 17'h0;
        p_product9 <= 17'h0;
        p_product10 <= 17'h0;
    end
    else begin
        p_product1 <= product1;
        // p_product2 <= product2;
        p_product3 <= product3;
        p_product4 <= product4;
        p_product5 <= product5;
        // p_product6 <= product6;
        p_product7 <= product7;
        p_product8 <= product8;
        p_product9 <= product9;
        p_product10 <= product10;
    end

endmodule
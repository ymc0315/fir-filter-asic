
module pipe_1(
    input clk,
    input n_rst,

    input [8:0] adder1,
    input [8:0] adder2,
    input [8:0] adder3,
    input [8:0] adder4,
    input [8:0] adder5,
    input [8:0] adder6,
    input [8:0] adder7,
    input [8:0] adder8,
    input [8:0] adder9,
    input [8:0] adder10,

    output reg [8:0] p_adder1,
    output reg [8:0] p_adder2,
    output reg [8:0] p_adder3,
    output reg [8:0] p_adder4,
    output reg [8:0] p_adder5,
    output reg [8:0] p_adder6,
    output reg [8:0] p_adder7,
    output reg [8:0] p_adder8,
    output reg [8:0] p_adder9,
    output reg [8:0] p_adder10
);

always @(posedge clk or negedge n_rst)
    if(!n_rst) begin
        p_adder1 <= 9'h0;
        p_adder2 <= 9'h0;
        p_adder3 <= 9'h0;
        p_adder4 <= 9'h0;
        p_adder5 <= 9'h0;
        p_adder6 <= 9'h0;
        p_adder7 <= 9'h0;
        p_adder8 <= 9'h0;
        p_adder9 <= 9'h0;
        p_adder10 <= 9'h0;
    end
    else begin
        p_adder1 <= adder1;
        p_adder2 <= adder2;
        p_adder3 <= adder3;
        p_adder4 <= adder4;
        p_adder5 <= adder5;
        p_adder6 <= adder6;
        p_adder7 <= adder7;
        p_adder8 <= adder8;
        p_adder9 <= adder9;
        p_adder10 <= adder10;
    end


endmodule
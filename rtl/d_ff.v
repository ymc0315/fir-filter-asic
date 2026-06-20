module d_ff(
    input clk,
    input n_rst,
    
    input [7:0] d,

    output reg [7:0] q
);

always @(posedge clk or negedge n_rst)
    if(!n_rst)
        q <= 8'h0;
    else
        q <= d;

endmodule

module adder_behavior_reg(s, co, a, b, ci, clk);
    parameter width = 32;
    output [width-1:0] s;
    output co;
    input [width-1:0] a,b;
    input ci;
    input clk;

    wire cout;
    wire [31:0] sum;

    adder_behavior adder (
        .s(sum),
        .co(cout),
        .a(a),
        .b(b),
        .ci(ci)
    );

    D_FF s_ff_reg (
        .clk(clk),
        .d(sum),
        .q(s)
    );

    D_FF_2 cout_ff_reg (
        .clk(clk),
        .d( cout), 
        .q(co)
    );

endmodule
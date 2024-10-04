module D_FF(q,d,clk);
    output reg [31:0] q;
    input [31:0] d; 
    input clk;

    always @( posedge clk) begin
        q <= d;
    end

endmodule

module D_FF_2(q,d,clk);
    output reg q;
    input d; 
    input clk;

    always @( posedge clk) begin
        q <= d;
    end

endmodule


module adder_structure_reg(s, co, a, b, ci, clk);
    parameter width = 32;
    output [width-1:0] s;
    output co;
    input [width-1:0] a,b;
    input ci;
    input clk;

    wire cout;
    wire [31:0] sum;

    adder_structure adder (
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
module adder_behavior(s,co,a,b,ci);
    parameter width = 32;
    output reg [width-1:0] s;
    output reg co;
    input [width-1:0] a,b;
    input ci;

always @(a,b,ci)
    {co, s} = a + b + ci;

endmodule
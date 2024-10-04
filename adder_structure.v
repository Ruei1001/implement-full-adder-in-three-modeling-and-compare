module FA (sum,cout,a,b,c_in);
    output sum, cout;
    input a,b;
    input c_in;
    wire c1,c2,c3,c4;
    xor(c1,a,b);
    xor(sum, c1, c_in);

    and(c2, a, b);
    and(c3, c1, c_in);
    xor(cout, c2, c3);
endmodule

module adder_structure(a,b,ci,s,co);
    parameter width = 32;
    output [width-1:0] s;
    output co;
    input [width-1:0] a,b;
    input ci;

    wire [width:0] c;

    assign c[0] = ci;
    genvar i;
    generate
        for (i = 0 ;i<width ; i=i+1) 
        begin:FA_loop
            FA full_adder(s[i], c[i+1], a[i], b[i], c[i]);
        end
    endgenerate

    assign co=c[width];
endmodule
/*
module adder_4bit (
    input [3:0] A, B,
    input cin,
    output [3:0] sum,
    output cout
);
    wire [3:0] carry;
    
    FA fa0 (A[0], B[0], cin, sum[0], carry[0]);
    FA fa1 (A[1], B[1], carry[0], sum[1], carry[1]);
    FA fa2 (A[2], B[2], carry[1], sum[2], carry[2]);
    FA fa3 (A[3], B[3], carry[2], sum[3], cout);
    
endmodule

module adder_16bit (
    input [15:0] A, B,
    input cin,
    output [15:0] sum,
    output cout
);
    wire [3:0] carry;
    
    adder_4bit adder0 (A[3:0], B[3:0], cin, sum[3:0], carry[0]);
    adder_4bit adder1 (A[7:4], B[7:4], carry[0], sum[7:4], carry[1]);
    adder_4bit adder2 (A[11:8], B[11:8], carry[1], sum[11:8], carry[2]);
    adder_4bit adder3 (A[15:12], B[15:12], carry[2], sum[15:12], cout);

endmodule

module adder_structure (a,b,ci,s,co);
    parameter width = 32;
    output [width-1:0] s;
    output co;
    input [width-1:0] a,b;
    input ci;
    wire carry;
    
    adder_16bit adder0 (a[15:0], b[15:0], ci, s[15:0], carry);
    adder_16bit adder1 (a[31:16], b[31:16], carry, s[31:16], co);

endmodule
*/
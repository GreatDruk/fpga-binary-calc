module multiplier(
    input  logic [8:0] a,
    input  logic [8:0] b,
    output logic [17:0] product
);

    logic [17:0] p0,p1,p2,p3,p4,p5,p6,p7,p8;

    assign p0 = b[0] ? (a << 0) : 18'b0;
    assign p1 = b[1] ? (a << 1) : 18'b0;
    assign p2 = b[2] ? (a << 2) : 18'b0;
    assign p3 = b[3] ? (a << 3) : 18'b0;
    assign p4 = b[4] ? (a << 4) : 18'b0;
    assign p5 = b[5] ? (a << 5) : 18'b0;
    assign p6 = b[6] ? (a << 6) : 18'b0;
    assign p7 = b[7] ? (a << 7) : 18'b0;
    assign p8 = b[8] ? (a << 8) : 18'b0;

    assign product = p0 + p1 + p2 + p3 + p4 + p5 + p6 + p7 + p8;

endmodule
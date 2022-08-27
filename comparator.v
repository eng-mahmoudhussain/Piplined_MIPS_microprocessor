module comparator(
    input   wire[31:0] in0,in1,
    output  wire        eq
);
assign eq = (in0 ==in1);
endmodule
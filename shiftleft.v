module shiftleft (
    input   wire[31:0]  in,
    output  wire[31:0]  out
);

    assign out = (in<<2);
    
endmodule
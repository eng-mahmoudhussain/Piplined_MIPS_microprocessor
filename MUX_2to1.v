module MUX_2to1 #(parameter size = 32)(
    //inputs & output ports
    input      [size-1:0] input0,
    input      [size-1:0] input1,
    input                 sel,
    output reg [size-1:0] out
);
    always @(*) begin
        
        case (sel)
            1'd0:  out = input0;
            1'd1:  out = input1;
            default: out = {size{1'b0}};
        endcase

    end

endmodule
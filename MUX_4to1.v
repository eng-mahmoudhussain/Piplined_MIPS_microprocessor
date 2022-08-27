module MUX_4to1 #(parameter size = 32)(
    //inputs & output ports
    input      [size-1:0] input0,
    input      [size-1:0] input1,
    input      [size-1:0] input2,
    input      [size-1:0] input3,
    input      [1:0]      sel,
    output reg [size-1:0] out
);
    always @(*) begin
        
        case (sel)
            2'd0:  out = input0;
            2'd1:  out = input1;
            2'd2:  out = input2;
            2'd3:  out = input3;
            default: out = {size{1'b0}};
        endcase
    end

endmodule
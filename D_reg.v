module D_reg(
    input wire clk,en,clr,Reset,
    input wire [31:0] RD,PCPlus4F,
    output reg [31:0] InstrD,PCPlus4D
);


always @(posedge clk , negedge Reset) begin
    
    if (!Reset) begin
        InstrD   <= 0;
        PCPlus4D <= 0;
    end
    
    
    else if((clr==1) && !en) begin
        InstrD   <= 32'b0;
        PCPlus4D <= 32'b0; //UPDATE PCPlus4F
    end

    else if(!en) begin
        InstrD   <= RD;
        PCPlus4D <= PCPlus4F;
    end

    
end

endmodule
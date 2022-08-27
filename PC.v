module PC(
    input wire clk,rst,En,
    input wire [31:0] PCi ,
    output reg [31:0] PCo
);

    always @(posedge clk or negedge rst) begin
        if(!rst)
            PCo <= 32'b0;
        else if(!En)
            PCo <= PCi;
    end

endmodule
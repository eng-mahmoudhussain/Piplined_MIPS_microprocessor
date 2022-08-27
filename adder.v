module adder (
    input wire[31:0] A,
    input wire[31:0] B,
    output reg [31:0] Res
);
always @(*)
begin
Res = A + B;
end
endmodule
module ALU(
    input wire[31:0] SrcA,SrcB,
    input wire [2:0] ALUControl,
    output reg [31:0] ALUResult
);
    
    always @(*)
        begin
            case(ALUControl)
                3'b000:ALUResult = SrcA&SrcB;
                3'b001:ALUResult = SrcA|SrcB;
                3'b010:ALUResult = SrcA+SrcB;
                3'b100:ALUResult = SrcA-SrcB;
                3'b101:ALUResult = SrcA*SrcB;
                3'b110:ALUResult = (SrcA<SrcB);
                default:ALUResult =31'b0;
            endcase
        end

endmodule
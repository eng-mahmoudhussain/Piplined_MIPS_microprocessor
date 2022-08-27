module CU(
    input wire [5:0] Opcode,
    input wire [5:0] Funct,
    output reg MemtoReg,MemWrite,Branch,
    output reg ALUSrc,RegDSt,RegWrite,jump,
    output reg [2:0] ALUControl
);
    reg[1:0] ALUOp;
    always@(*)
        begin
            case (Opcode)
                6'b100011:{jump,ALUOp,MemWrite,RegWrite,RegDSt,ALUSrc,MemtoReg,Branch}=9'b000010110;
                6'b101011:{jump,ALUOp,MemWrite,RegWrite,RegDSt,ALUSrc,MemtoReg,Branch}=9'b000100110;
                6'b000000:{jump,ALUOp,MemWrite,RegWrite,RegDSt,ALUSrc,MemtoReg,Branch}=9'b010011000;
                6'b001000:{jump,ALUOp,MemWrite,RegWrite,RegDSt,ALUSrc,MemtoReg,Branch}=9'b000010100;
                6'b000100:{jump,ALUOp,MemWrite,RegWrite,RegDSt,ALUSrc,MemtoReg,Branch}=9'b001000001;
                6'b000010:{jump,ALUOp,MemWrite,RegWrite,RegDSt,ALUSrc,MemtoReg,Branch}=9'b100000000;
                default: {jump,ALUOp,MemWrite,RegWrite,RegDSt,ALUSrc,MemtoReg,Branch}=9'b000000000;
            endcase
    
        
            casex ({ALUOp,Funct})
                8'b00??????: ALUControl = 3'b010;
                8'b01??????: ALUControl = 3'b100;
                8'b10100000:ALUControl = 3'b010;
                8'b10100010:ALUControl = 3'b100;
                8'b10101010:ALUControl = 3'b110;
                8'b10011100:ALUControl = 3'b101;
    
                default:ALUControl = 3'b010; 
            endcase
        end
    
endmodule
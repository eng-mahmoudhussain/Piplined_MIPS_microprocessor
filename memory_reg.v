module memory_reg (
    input wire clk,
    input wire rst,
    //control sigs
    input wire RegWriteE,
    input wire MemtoRegE,
    input wire MemWriteE,
    //Alu sigs 
    input wire [31:0] AluOutE,
    input wire [31:0] WriteDataE,
    input wire [4:0] WriteRegE,
    //outputs control sigs
    output reg RegWriteM,
    output reg MemtoRegM,
    output reg MemWriteM,
    // outputs sigs
    output reg [31:0] AluOutM,
    output reg [31:0] WriteDataM,
    output reg [4:0] WriteRegM 
);

    always @(posedge clk or negedge rst) begin
        if (!rst)
        begin
            RegWriteM <= 1'b0;
            MemtoRegM <= 1'b0;
            MemWriteM <= 1'b0;
            AluOutM   <= 32'b0;
            WriteDataM<= 32'b0;
            WriteRegM <= 5'b0;  
        end
        else 
        begin
            RegWriteM <= RegWriteE;
            MemtoRegM <= MemtoRegE;
            MemWriteM <= MemWriteE;
            AluOutM   <= AluOutE;
            WriteDataM<= WriteDataE;
            WriteRegM <= WriteRegE;
        end

    end

endmodule
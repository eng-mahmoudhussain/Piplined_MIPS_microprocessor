module Memory_stage (
    input wire clk,
    input wire rst,
    input wire RegWriteE,
    input wire MemtoRegE,
    input wire MemWriteE,
    input wire [31:0] AluOutE,
    input wire [31:0] WriteDataE,
    input wire [4:0]  WriteRegE,
    ////////////////////////////
    output wire RegWriteM,
    output wire MemtoRegM,
    output wire [31:0] AluOutM,
    output wire [31:0] RD,
    output wire [4:0] WriteRegM,
    output wire [31:0] testValue
);
   wire MemWriteM;
   wire [31:0] WriteDataM;

    memory_reg register (.clk (clk), .rst(rst), .RegWriteE(RegWriteE), .MemtoRegE(MemtoRegE), .MemWriteE(MemWriteE), .AluOutE(AluOutE), 
                          .WriteDataE(WriteDataE),.WriteRegE(WriteRegE), .RegWriteM(RegWriteM),.MemtoRegM(MemtoRegM), .MemWriteM(MemWriteM),
                          .AluOutM(AluOutM),.WriteDataM(WriteDataM),.WriteRegM(WriteRegM));
                          
    datamem datamem_M (.clk(clk), .rst (rst), .WE(MemWriteM) ,.addr(AluOutM), .WD (WriteDataM), .RD(RD), .testValue(testValue) );
        
    
endmodule
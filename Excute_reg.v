module Excute_reg (
    // input & output ports
    input  wire            CLK,   
    input  wire            Reset,
    input  wire            CLR,
    input  wire            RegWriteD,
    input  wire            MemtoRegD,
    input  wire            MemWriteD,
    input  wire   [2:0]    ALUControlD,
    input  wire            ALUSrcD,
    input  wire            RegDstD,
    input  wire   [31:0]   RD1D,
    input  wire   [31:0]   RD2D,
    input  wire   [4:0]    RsD,
    input  wire   [4:0]    RtD,
    input  wire   [4:0]    RdE_D,
    input  wire   [31:0]   signImmD,
    output reg    [31:0]   RD1E,
    output reg    [31:0]   RD2E,
    output reg    [4:0]    RsE,
    output reg    [4:0]    RtE,
    output reg    [4:0]    RdE,
    output reg    [31:0]   signImmE,
    output reg             RegWriteE,
    output reg             MemtoRegE,
    output reg             MemWriteE,
    output reg    [2:0]    ALUControlE,
    output reg             ALUSrcE,
    output reg             RegDstE
);

always @(posedge CLK , negedge Reset ) begin
    if (!Reset) begin
        RD1E          <= 0;
        RD2E          <= 0;
        RsE           <= 0;
        RtE           <= 0;
        RdE           <= 0;
        signImmE      <= 0;
        RegWriteE     <= 0;
        MemtoRegE     <= 0;
        MemWriteE     <= 0;
        ALUControlE   <= 0;
        ALUSrcE       <= 0;
        RegDstE       <= 0;
    end
    else if(CLR) begin
        RD1E          <= 0;
        RD2E          <= 0;
        RsE           <= 0;
        RtE           <= 0;
        RdE           <= 0;
        signImmE      <= 0;
        RegWriteE     <= 0;
        MemtoRegE     <= 0;
        MemWriteE     <= 0;
        ALUControlE   <= 0;
        ALUSrcE       <= 0;
        RegDstE       <= 0;
    end
    else begin
        RD1E          <= RD1D;
        RD2E          <= RD2D;
        RsE           <= RsD;
        RtE           <= RtD;
        RdE           <= RdE_D;
        signImmE      <= signImmD;
        RegWriteE     <= RegWriteD;
        MemtoRegE     <= MemtoRegD;
        MemWriteE     <= MemWriteD;
        ALUControlE   <= ALUControlD;
        ALUSrcE       <= ALUSrcD;
        RegDstE       <= RegDstD;
    end

end
    
endmodule
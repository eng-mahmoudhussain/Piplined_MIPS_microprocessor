module Write_back (
    input       [31:0]        RD,
    input       [31:0]        ALUOutM,
    input                     RegWriteM,
    input                     MemtoRegM,
    input       [4:0]         WriteRegM,
    input                     CLK,
    input                     Reset,
    output                    RegWriteW,
    output      [31:0]        ResultW,
    output      [4:0]         WriteRegW
);
wire [31:0] ALUOutW, ReadDataW ;
wire        MemtoRegW ;

 Write_reg  Write_reg_Write (
  .RD(RD),
  .ALUOutM(ALUOutM),
  .RegWriteM(RegWriteM), 
  .MemtoRegM(MemtoRegM), 
  .WriteRegM(WriteRegM), 
  .CLK(CLK),
  .Reset(Reset),
  .ReadDataW(ReadDataW),
  .ALUOutW(ALUOutW),
  .RegWriteW(RegWriteW) ,
  .MemtoRegW(MemtoRegW),
  .WriteRegW(WriteRegW)             
);


MUX_2to1 #(.size(32)) MUX_2to1_Write (.input0(ALUOutW), .input1(ReadDataW), .sel(MemtoRegW), .out(ResultW));
endmodule 
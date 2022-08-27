module Write_reg (
    input       [31:0]        RD,
    input       [31:0]        ALUOutM,
    input                     RegWriteM,
    input                     MemtoRegM,
    input       [4:0]         WriteRegM,
    input                     CLK,
    input                     Reset,
    output reg  [31:0]        ReadDataW,
    output reg  [31:0]        ALUOutW,
    output reg                RegWriteW,
    output reg                MemtoRegW,
    output reg  [4:0]         WriteRegW             
);
always @ (posedge CLK or negedge Reset)
begin
    if(Reset==0)
    begin
   ReadDataW <= 32'b0;
    ALUOutW <= 32'b0;
    RegWriteW <= 1'b0;
    MemtoRegW <= 1'b0;
    WriteRegW <= 5'b0;
    end
    else
    begin
    ReadDataW <= RD;
    ALUOutW <= ALUOutM;
    RegWriteW <= RegWriteM;
    MemtoRegW <= MemtoRegM;
    WriteRegW <= WriteRegM;
    end


end 
endmodule
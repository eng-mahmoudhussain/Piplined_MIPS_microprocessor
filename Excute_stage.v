module Excute_stage (
    //input & output ports
    input   wire    [31:0]   RD1E,
    input   wire    [31:0]   RD2E,
    input   wire    [4:0]    RtE,
    input   wire    [4:0]    RdE,
    input   wire    [31:0]   signImmE,
    input   wire    [2:0]    ALUControlE,
    input   wire             ALUSrcE,
    input   wire             RegDstE,
    input   wire    [1:0]    forwardAE,
    input   wire    [1:0]    forwardBE,
    input   wire    [31:0]   ALUoutM,
    input   wire    [31:0]   ResultW,
    output  wire    [4:0]    WriteRegE,
    output  wire    [31:0]   WriteDataE,
    output  wire    [31:0]   ALUOutE
);

//internal wires

wire [31:0] SrcAE;
wire [31:0] SrcBE;


MUX_2to1 #(.size(5))         MUX1(.input0(RtE), .input1(RdE), .sel(RegDstE), .out(WriteRegE));

MUX_2to1 #(.size(32))        MUX2(.input0(WriteDataE), .input1(signImmE), .sel(ALUSrcE), .out(SrcBE));

MUX_4to1 #(.size(32))        MUX1_E(.input0(RD1E), .input1(ResultW), .input2(ALUoutM),
                                     .input3(0), .sel(forwardAE), .out(SrcAE));

MUX_4to1 #(.size(32))        MUX2_E(.input0(RD2E), .input1(ResultW), .input2(ALUoutM),
                                     .input3(0), .sel(forwardBE), .out(WriteDataE));

ALU                          ALU_(.SrcA(SrcAE), .SrcB(SrcBE), .ALUControl(ALUControlE), .ALUResult(ALUOutE));


endmodule
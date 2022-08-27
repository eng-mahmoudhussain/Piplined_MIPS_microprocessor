module Decode_stage(
    input wire  [31:0]   RD,
    input wire  [31:0]   PCPlusF,
    input wire           StallD,
    input wire           clk,
    input wire           Reset,
    input wire  [31:0]   ALUOutM,
    input wire           ForwardAD,
    input wire           ForwardBD, 
    input wire   [4:0]   WriteRegW,
    input                RegWriteW,
    input wire   [31:0]  ResultW,
    output wire          RegWriteD,
    output wire          MemtoRegD,
    output wire          MemWriteD,
    output wire [2:0]    ALUControlD,
    output wire          ALUSrcD,
    output wire          RegDstD,
    inout wire  [1:0]    PCSrcD,
    output wire [31:0]   RD1,
    output wire [31:0]   RD2,
    output wire [4:0]    RsD,
    output wire [4:0]    RtD,
    output wire [4:0]    RdE,
    output wire [31:0]   SignImmD,
    output wire [31:0]   PCBranchD,
    inout wire [31:0]    PCJumpD,
    inout wire           BranchD,
    inout wire           JumpD

);

    wire    [31:0]  InstrD; 
    wire    [31:0]  PCPlus4D;
    wire    [31:0]  eq1;
    wire    [31:0]  eq2;
    wire    [31:0]  out_shift;
    //wire            BranchD;
    //wire            JumpD;
    wire            EqualD;
    wire            clear;

    assign PCJumpD = {PCPlusF[31:28], InstrD[25:0], 2'b0};
   




    D_reg reg_d(
        .clk(clk),
        .en(StallD),
        .clr(clear),
        .Reset(Reset),
        .RD(RD),
        .PCPlus4F(PCPlusF),
        .InstrD(InstrD),
        .PCPlus4D(PCPlus4D)
);
assign RsD               = InstrD[25:21];
assign RtD               = InstrD[20:16];
assign RdE             = InstrD[15:11];

    CU cu_d(
        .Opcode(InstrD[31:26]),
        .Funct(InstrD[5:0]),
        .MemtoReg(MemtoRegD),
        .MemWrite(MemWriteD),
        .Branch(BranchD),
        .ALUSrc(ALUSrcD),
        .RegDSt(RegDstD),
        .RegWrite(RegWriteD),
        .jump(JumpD),
        .ALUControl(ALUControlD)
);

register_file register_file_D(
    .A1(InstrD[25:21]),
    .A2(InstrD[20:16]),
    .A3(WriteRegW),
    .WE3(RegWriteW), 
    .reset(Reset),
    .WD3(ResultW),
    .clk(clk),
    .RD1(RD1),
    .RD2(RD2)
);

    MUX_2to1 mux1(
    //inputs & output ports
    .input0(RD1),
    .input1(ALUOutM),
    .sel(ForwardAD),
    .out(eq1)
);
    MUX_2to1 mux2(
        //inputs & output ports
        .input0(RD2),
        .input1(ALUOutM),
        .sel(ForwardBD),
        .out(eq2)
);

    comparator comp_d(
        .in0(eq1),
        .in1(eq2),
        .eq(EqualD)
);

    sign_extend extend_d(
        .inst(InstrD[15:0]), 
        .signlmm(SignImmD)
);

    shiftleft sl_d(
        .in(SignImmD),
        .out(out_shift)
);
    adder adder_d(
    .A(out_shift),
    .B(PCPlus4D),
    .Res(PCBranchD)
);






assign PCSrcD = {JumpD,BranchD&EqualD};
assign clear = |PCSrcD;


endmodule
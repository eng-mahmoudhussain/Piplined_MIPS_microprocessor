module TOP_MIPS (
    input           CLK,
    input           Reset,
    output   [31:0]       test_value
);

wire          StallF;
wire [31:0]   InstrF;
wire [31:0]   PcPlus4f; 
wire [31:0]   PCBranchD;  
wire [31:0]    PCJumpD ;  
wire [1:0]     PCSrcD;
wire [31:0]    PCout_F;
wire [31:0]     PCin_F;

 Fetch_stage     Fetch_stage_TOP (
    .CLK(CLK),
    .Reset(Reset),
    .PcScrF(PCSrcD),
    .PcBranchF(PCBranchD),
    .PcjumpF(PCJumpD),
    .stallF(StallF),
    .InstrF(InstrF),
    .PcPlus4f(PcPlus4f),
    .PCin_F(PCin_F),
    .PCout_F(PCout_F)
);

wire           StallD;
wire  [31:0]   ALUOutM;
wire           ForwardAD;
wire           ForwardBD; 
wire   [4:0]   WriteRegW;
wire           RegWriteW;
wire   [31:0]  ResultW;
wire          RegWriteD;
wire          MemtoRegD;
wire          MemWriteD;
wire [2:0]    ALUControlD;
wire          ALUSrcD;
wire          RegDstD;
wire [31:0]   RD1;
wire [31:0]   RD2;
wire [4:0]    RsD;
wire [4:0]    RtD;
wire [4:0]    RdE_D;
wire [31:0]   SignImmD;
wire            BranchD;
wire            JumpD;

 Decode_stage Decode_stage_TOP (
    .RD(InstrF),
    .PCPlusF(PcPlus4f),
    .StallD(StallD),
    .clk(CLK),
    .Reset(Reset),
    .ALUOutM(ALUOutM),
    .ForwardAD(ForwardAD),
    .ForwardBD(ForwardBD), 
    .WriteRegW(WriteRegW),
    .RegWriteW(RegWriteW),
    .ResultW(ResultW),
    .RegWriteD(RegWriteD),
    .MemtoRegD(MemtoRegD),
    .MemWriteD(MemWriteD),
    .ALUControlD(ALUControlD),
    .ALUSrcD(ALUSrcD),
    .RegDstD(RegDstD),
    .PCSrcD(PCSrcD),
    .RD1(RD1),
    .RD2(RD2),
    .RsD(RsD),
    .RtD(RtD),
    .RdE(RdE_D),
    .SignImmD(SignImmD),
    .PCBranchD(PCBranchD),
    .PCJumpD(PCJumpD),
    .BranchD(BranchD),
    .JumpD(JumpD) 
    );

wire     FlushE; //Hazard output
wire    [31:0]   RD1E;
wire    [31:0]   RD2E;
wire    [4:0]    RsE;
wire    [4:0]    RtE;
wire    [4:0]    RdE;
wire    [31:0]   signImmE;
wire             RegWriteE;
wire             MemtoRegE;
wire             MemWriteE;
wire    [2:0]    ALUControlE;
wire             ALUSrcE;
wire             RegDstE;

Excute_reg Excute_reg_TOP (
.CLR(FlushE),
.CLK(CLK),   
.Reset(Reset),
.RegWriteD(RegWriteD),
.MemtoRegD(MemtoRegD),
.MemWriteD(MemWriteD),
.ALUControlD(ALUControlD),
.ALUSrcD(ALUSrcD),
.RegDstD(RegDstD),
.RD1D(RD1),
.RD2D(RD2),
.RsD(RsD),
.RtD(RtD),
.RdE_D(RdE_D),
.signImmD(SignImmD),
.RD1E(RD1E),
.RD2E(RD2E),
.RsE(RsE),
.RtE(RtE),
.RdE(RdE),
.signImmE(signImmE),
.RegWriteE(RegWriteE),
.MemtoRegE(MemtoRegE),
.MemWriteE(MemWriteE),
.ALUControlE(ALUControlE),
.ALUSrcE(ALUSrcE),
.RegDstE(RegDstE)
);

wire    [1:0]    forwardAE;
wire    [1:0]    forwardBE;
wire    [4:0]    WriteRegE;
wire    [31:0]   WriteDataE;
wire    [31:0]   ALUOutE;

 Excute_stage Excute_stage_TOP (
    .RD1E(RD1E),
    .RD2E(RD2E),
    .RtE(RtE),
    .RdE(RdE),
    .signImmE(signImmE),
    .ALUControlE(ALUControlE),
    .ALUSrcE(ALUSrcE),
    .RegDstE(RegDstE), //
    .forwardAE(forwardAE),
    .forwardBE(forwardBE),
    .ALUoutM(ALUOutM),
    .ResultW(ResultW),
    .WriteRegE(WriteRegE),
    .WriteDataE(WriteDataE),
    .ALUOutE(ALUOutE)
);
    wire          RegWriteM;
    wire          MemtoRegM;
    wire [31:0]   RD;
    wire [4:0]    WriteRegM;

Memory_stage Memory_stage_TOP (
    .clk(CLK),
    .rst(Reset),
    .RegWriteE(RegWriteE),
    .MemtoRegE(MemtoRegE),
    .MemWriteE(MemWriteE),
    .AluOutE(ALUOutE),
    .WriteDataE(WriteDataE),
    .WriteRegE(WriteRegE),
    ////////////////////////////
    .RegWriteM(RegWriteM),
    .MemtoRegM(MemtoRegM),
    .AluOutM(ALUOutM),
    .RD(RD),
    .WriteRegM(WriteRegM),
    .testValue(test_value)
);


Write_back Write_back_TOP (
.RD(RD),
.ALUOutM(ALUOutM),
.RegWriteM(RegWriteM),
.MemtoRegM(MemtoRegM),
.WriteRegM(WriteRegM),
.CLK(CLK),
.Reset(Reset),
.RegWriteW(RegWriteW),
.ResultW(ResultW),
.WriteRegW(WriteRegW)
);

Hazard_unit Hazard_unit_TOP (
.MemtoRegE(MemtoRegE),
.RegWriteE(RegWriteE),
.MemtoRegM(MemtoRegM),
.RegWriteM(RegWriteM),
.RegWriteW(RegWriteW),
.RsD(RsD),
.RtD(RtD),
.RsE(RsE),
.RtE(RtE),
.WriteRegE(WriteRegE),
.WriteRegM(WriteRegM),
.WriteRegW(WriteRegW),
.BranchD(BranchD),
.JumpD(JumpD),
.StallF(StallF),
.StallD(StallD),
.ForwardAD(ForwardAD),
.ForwardBD(ForwardBD),
.FlushE(FlushE),
.ForwardAE(forwardAE),
.ForwardBE(forwardBE)
);

endmodule



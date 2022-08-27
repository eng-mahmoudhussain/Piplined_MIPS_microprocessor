module Fetch_stage (
    // input & output ports
    input            CLK,
    input            Reset,
    input   [1:0]    PcScrF,
    input   [31:0]   PcBranchF,
    input   [31:0]   PcjumpF,
    input            stallF,
    output  [31:0]   InstrF,
    output  [31:0]   PCout_F,
    output  [31:0]   PCin_F,
    output  [31:0]   PcPlus4f
);

//wire [31:0] PCin_F;
//wire [31:0] PCout_F;


MUX_4to1 #(.size(32))           MUX1_f(.input0(PcPlus4f), .input1(PcBranchF), .input2(PcjumpF),
                                     .input3(0), .sel(PcScrF), .out(PCin_F));

PC                              PC_F(.clk(CLK), .rst(Reset), .En(stallF), .PCi(PCin_F), .PCo(PCout_F));

adder                           adder(.A(PCout_F), .B(4), .Res(PcPlus4f));

Instruction_mem                 Inst_mem(.Pc(PCout_F), .Instr(InstrF));
    
endmodule
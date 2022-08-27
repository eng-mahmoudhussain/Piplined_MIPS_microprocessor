module Hazard_unit (
input                    MemtoRegE,
input                    RegWriteE,
input                    MemtoRegM,
input                    RegWriteM,
input                    RegWriteW,
input [4:0]              RsD,
input [4:0]              RtD,
input [4:0]              RsE,
input [4:0]              RtE,
input [4:0]              WriteRegE,
input [4:0]              WriteRegM,
input [4:0]              WriteRegW,
input                    BranchD,
input                    JumpD,
output reg               StallF,
output reg               StallD,
output reg               ForwardAD,
output reg               ForwardBD,
output reg               FlushE,
output reg [1:0]         ForwardAE,
output reg  [1:0]        ForwardBE
);
reg  lwstall;
reg  branchstall;
always @(*) 
begin
    if ((RsE != 0) & (RsE == WriteRegM) & RegWriteM)
    begin
        ForwardAE = 2'b10;
    end
    else if ((RsE != 0) & (RsE == WriteRegW) & RegWriteW)
    begin
        ForwardAE = 2'b01;
    end
    else 
    begin
         ForwardAE = 2'b00;
    end

    if ((RtE != 0) & (RtE == WriteRegM) & RegWriteM)
    begin
        ForwardBE = 2'b10;
    end
    else if ((RtE != 0) & (RtE == WriteRegW) & RegWriteW)
    begin
        ForwardBE = 2'b01;
    end
    else 
    begin
         ForwardBE = 2'b00;
    end
    lwstall = ((RsD == RtE) | (RtD == RtE)) & MemtoRegE;
    ForwardAD = (RsD != 0) & (RsD == WriteRegM) & RegWriteM;
    ForwardBD = (RtD != 0) & (RtD == WriteRegM) & RegWriteM;
    branchstall = (BranchD & RegWriteE & (WriteRegE == RsD | WriteRegE == RtD)) | (BranchD & MemtoRegM & (WriteRegM == RsD | WriteRegM == RtD));
    StallF = lwstall | branchstall ;
    StallD = StallF;
    FlushE = StallF| JumpD ;
    //FlushE = StallF | JumpD;

end
endmodule  
        
module register_file (
  input   wire  [4:0]      A1,
  input   wire  [4:0]      A2,
  input   wire  [4:0]      A3,
  input   wire             WE3, reset,
  input   reg   [31:0]     WD3,
  input   wire             clk,
  output  reg   [31:0]     RD1,
  output  reg   [31:0]     RD2
);

  reg [31:0] regfile [0:31];
  integer i;

  always @(*) begin

    RD1= regfile[A1];
    RD2= regfile[A2];

  end

  always @(negedge clk, negedge reset) begin
    if(!reset) begin

      for(i=0; i<32; i=i+1) begin
        regfile[i]<=32'b0;
      end

    end 

    else if(WE3) begin
      regfile[A3]<= WD3 ;
    end

  end

endmodule
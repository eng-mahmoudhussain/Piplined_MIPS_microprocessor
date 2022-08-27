module sign_extend (
  input wire [15:0] inst, 
  output wire [31:0] signlmm
  );
  
  assign signlmm = {{16 {inst[15]}} , inst[15:0]};
endmodule

module datamem (

output wire [31: 0] RD,
output wire [31:0] testValue,

input wire [31: 0] WD,
input wire [31: 0] addr,
input wire  WE, clk, rst
);
    
reg [31: 0] mem[99: 0];
integer i;

always @(posedge clk or negedge rst)
    begin
        if(!rst)
            for(i = 8'b0; i < 100; i = i + 1'b1)
                mem[i] <= 32'b0;
        else if(WE) //Write active low
                mem[addr] <= WD;            
    end

assign RD = mem [addr] ;
assign testValue = mem[32'd0];

endmodule
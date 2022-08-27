module Data_mem (
    input CLK, reset, WE,
    input [31:0] A,
    input [31:0] WD,
    output reg [31:0] RD,
    output reg [31:0] test_value
);
    
    reg [31:0] RAM [99:0];
    integer i;

    always@(posedge CLK, negedge reset) begin
        if (!reset) begin
            for (i = 32'b0; i<100; i=i+1) begin
                RAM[i] <= 32'b0;
            end 
        end
    
        else if (WE) begin
            RAM[A] <= WD; 
        end
    end 

    always @(*) begin
        RD = RAM[A];
        test_value = RAM[0];
    end


endmodule
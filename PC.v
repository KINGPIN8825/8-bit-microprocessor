module PC(input clk,input [4:0]pcfb,output [4:0]pc);
reg[4:0] pc;

always @(posedge clk)
pc=pcfb;

endmodule
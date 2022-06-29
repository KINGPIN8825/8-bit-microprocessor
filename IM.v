'timescale 1ns/1ps
module IM(input clk,RD,WR,addr,ipdb, output reg opdb);

reg [7:0] mem [0:31];

always @(posedge clk)
begin

if (RD) begin
opdb = mem[addr];
end

if (WR) begin
mem[addr] = ipdb;
end

end

endmodule
'timescale 1ns/1ps

module pmem(input [4:0]PC,clk, output reg [18:0] pline);

reg [18:0] pmem[31:0];

initial begin
//enter program code here
end

always @ (posedge clk)
begin
pline= pmem[PC];
end

endmodule
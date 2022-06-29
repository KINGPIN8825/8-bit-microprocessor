'timescale 1ns/1ps

module PC(input clk,[4:0]pcfb output [4:0]pc);
reg [4:0]counter=pcfb

always @(posedge clk)
pc=counter

endmodule
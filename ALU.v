'timescale 1ns / 1ps

module ALU( input [7:0]A,[7:0]B,[1:0]FS, output reg [7:0]C, output reg [3:0]flag);

wire [8:0]op;

always @ *
case(FS)

2'b00: //ADD
op=A+B;
C=op[7:0];
flag[3]=op[8];

2'b01: //CMP
C=(A>=B)?8'd1:8'd0;

2'b10: //SUB
op=A-B;
C=op[7:0];
flag[3]=op[8];

2'b11: //INC
op=A+ 1'b1;
C=op[7:0];
flag[3]=op[8];

endmodule

//0000 <5><5><5>	ADD Rx,Ry,Rz	Rx=Ry+Rz
//0001 <5><5>{5}	CMP Rx,Ry		Rx>=Ry => F3=1
//0010 <5><5><5>	SUB Rx,Ry,Rz 	Rx=Ry-Rz
//0011 <5>{5}{5}	INC Rx		Rx=Rx+1
//0100 <5><5>{5}	MOV Ry,Rx		Rx->Ry
//0101 <5><5>{5}	MVI Ry,(Rx)		(Rx)->Ry
//0110 <5><5>{5}	MVI (Ry),Rx		Rx->(Ry)
//0111 <5><8>{2}	LD  Rx,D7-0		D7-0->Rx
//1000 <2><5>{5}	if Fx=0 jump <topc> 
//1001 <2><5>{5}	if Fx=1 jump <topc>

module pmem(
    input [4:0]PC,
    input clk, 
    output[18:0] pline
);

reg [18:0] pmem[31:0];

dff pm[18:0](pmem[PC],clk,pline);

initial begin
//enter program code here
end


endmodule
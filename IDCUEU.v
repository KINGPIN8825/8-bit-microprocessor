'timescale 1ns/1ps
'include "ALU.v"
module IDCUEU(input clk,[18:0]pline,[7:0]opdb,output [7:0]ipdb);


//0000 <5><5><5>	ADD Rx,Ry,Rz	Rx=Ry+Rz
//0001 <5><5>{5}	CMP Rx,Ry		Rx>=Ry => F3=1
//0010 <5><5><5>	SUB Rx,Ry,Rz 	Rx=Ry-Rz
//0011 <5>{5}{5}	INC Rx		Rx=Rx+1
//0100 <5><5>{5}	MOV Ry,Rx		Rx->Ry
//0101 <5><5>{5}	MVI Ry,(Rx)		(Rx)->Ry
//0110 <5><5>{5}	MVI (Ry),Rx		Rx->(Ry)
//0111 <5><8>{2}	LD  Rx,D0-7		D0-7->Rx
//1000 <2><5>{5}	if Fx=0 jump <topc> 
//1001 <2><5>{5}	if Fx=1 jump <topc>


always @ (posedge clk)
begin
case(pline[18:15])

4'b00??:
begin

ALU ALU1(.A,.B,.FS,.C,.flag)
end

end

endmodule


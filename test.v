// ALU test
/*
module alutest;
    reg[7:0] R0,R1;
    wire [7:0] R2;
    wire [3:0] flaga;
    reg[1:0] fs;

    ALU a1(R0,R1,fs,R2,flaga);
    //ALU a2(.A(R0),.FS(fs),.);
    initial begin
        $dumpfile("test.vcd");
        $dumpvars(0,alutest);
        fs=2'b00; R0=8'b01010101;R1=8'b10101011;
        $display("%b",R0+R1);
       #10  fs=2'b01; R0=8'b01010101;R1=8'b01010101;
       #10  fs=2'b10; R0=8'b11110000;R1=8'b11100000;
       #10  fs=2'b11; R0=8'b00000000;
       #10  $finish;
    end
endmodule */
/*

module pctest;
    reg clk;
    wire[4:0] pc,pcfb;

    initial begin
    clk=0;
    end  
    always  begin
       #1 clk=~clk;
    end

    PC prcnt(clk,pcfb,pc);
    IDCUEU id(clk,pcfb);

    initial begin
    $dumpfile("test.vcd");
    $dumpvars(0,pctest);
    #20 $finish;
    end
    endmodule
*/
/*
module dmtest;
    reg [7:0] datain;
    wire[7:0] datout;
    reg clr,rd,wr;

    reg clk;
    initial begin
    clk=0;
    end  
    always  begin
    #1 clk=~clk;
    end

    reg8 R0(datain,datout,clk,rd,wr);

    initial begin
        $dumpfile("test.vcd");
        $dumpvars(0,dmtest);
        rd=0;wr=0;
        #2 datain=8'b11001010;

         wr=1;
        #5 $finish;
    end

endmodule*/

module FSMtest;
    reg clk;
    wire RD,WR;
    wire [4:0]RDsel,WRsel,PCfb;
    wire[1:0] ALU_fs;
    reg[4:0] PC;
    reg[18:0] pline;
    wire[6:0] en;

    reg[7:0] R0,R1;
    wire[7:0] R2,R31;

    initial begin
        $dumpfile("test.vcd");
        $dumpvars(0,FSMtest);
        pline=19'b0000_11110_01111_01010;PC=5'b0;
        clk=0;
        #30 $finish;
    end
    always begin
        #1 clk=~clk;
    end
   ID insd(pline[18:15],en); 
   MOV_fsm F0(clk,en[1],PC,pline,RD,WR,RDsel,WRsel,PCfb);
   ALU_fsm F1(clk,en[0],PC,pline,RD,WR,C_en,F_en,RDsel,WRsel,PCfb,ALU_fs);

   ALU  a1(R0,R1,ALU_fs,R2,R31);
endmodule

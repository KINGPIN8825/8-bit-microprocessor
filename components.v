
module mux2to1 (
    input [1:0] in,
    input sel,
    output out
);
    wire [1:0] w;
    wire n;
    nand  g1(n,sel),
     g2(w[0],in[0],n),
     g3(w[1],in[1],sel),
     g4(out,w[0],w[1]);
endmodule

module deco_5to32(
    input[4:0] in,
    output[31:0] Out
);

   not  Inv4(Nota, in[4]);
   not  Inv3(Notb, in[3]);
   not  Inv2(Notc, in[2]);
   not  Inv1(Notd, in[1]);
   not  Inv0(Note, in[0]);

   and a0(Out[0],  Nota,Notb,Notc,Notd,Note); // 00000
   and a1(Out[1],  Nota,Notb,Notc,Notd,in[0]); // 00001
   and a2(Out[2],  Nota,Notb,Notc,in[1],Note); //00010
   and a3(Out[3],  Nota,Notb,Notc,in[1],in[0]);
   and a4(Out[4],  Nota,Notb,in[2],Notd,Note);
   and a5(Out[5],  Nota,Notb,in[2],Notd,in[0]);
   and a6(Out[6],  Nota,Notb,in[2],in[1],Note);
   and a7(Out[7],  Nota,Notb,in[2],in[1],in[0]);
   and a8(Out[8],    Nota,in[3],Notc,Notd,Note);
   and a9(Out[9],    Nota,in[3],Notc,Notd,in[0]);
   and a10(Out[10],  Nota,in[3],Notc,in[1],Note);
   and a11(Out[11],  Nota,in[3],Notc,in[1],in[0]);
   and a12(Out[12],  Nota,in[3],in[2],Notd,Note);
   and a13(Out[13],  Nota,in[3],in[2],Notd,in[0]);
   and a14(Out[14],  Nota,in[3],in[2],in[1],Note);
   and a15(Out[15],  Nota,in[3],in[2],in[1],in[0]);
   and a16(Out[16],  in[4],Notb,Notc,Notd,Note);
   and a17(Out[17],  in[4],Notb,Notc,Notd,in[0]);
   and a18(Out[18],  in[4],Notb,Notc,in[1],Note);
   and a19(Out[19],  in[4],Notb,Notc,in[1],in[0]);
   and a20(Out[20],  in[4],Notb,in[2],Notd,Note);
   and a21(Out[21],  in[4],Notb,in[2],Notd,in[0]);
   and a22(Out[22],  in[4],Notb,in[2],in[1],Note);
   and a23(Out[23],  in[4],Notb,in[2],in[1],in[0]);
   and a24(Out[24],  in[4],in[3],Notc,Notd,Note);
   and a25(Out[25],  in[4],in[3],Notc,Notd,in[0]);
   and a26(Out[26],  in[4],in[3],Notc,in[1],Note);
   and a27(Out[27],  in[4],in[3],Notc,in[1],in[0]);
   and a28(Out[28],  in[4],in[3],in[2],Notd,Note);
   and a29(Out[29],  in[4],in[3],in[2],Notd,in[0]);
   and a30(Out[30],  in[4],in[3],in[2],in[1],Note);
   and a31(Out[31],  in[4],in[3],in[2],in[1],in[0]); // 11111
endmodule

module tristate (
    input in,en,
    output out
);
  assign  out=en?in:1'bz;  
endmodule

module dff(D,clk,Q);
    input D;  
    input clk; 
    output reg Q; 

    always @(posedge clk) 
    Q<=D;

endmodule 


module reg8 (
    input[7:0]  datain,
    output [7:0] dataout,Q,
    input clk,rd,wr
);
    wire[7:0] D;
    dff word[7:0](D,clk,Q);

    genvar i;
    generate
        for(i=0;i<8;i=i+1) begin: dmw
        mux2to1 M({datain[i],Q[i]},wr,D[i]);
        end
    endgenerate
    tristate t[7:0](Q,rd,dataout);
endmodule 

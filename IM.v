
module IM(
        input clk,RD,WR,LD_en,C_en,F_en,
        input[4:0] RDsel,WRsel,
        input[7:0] C_alu,F_alu,Load_reg,
        output[7:0] A_alu,B_alu,
        output[255:0] data
);
    wire[7:0] databus;
    wire[31:0] reads,writes;

    deco_5to32 D1(RDsel,reads),
           D2(WRsel,writes);

    genvar i;
    for(i=0;i<32;i=i+1) begin:dat
        reg8 word(databus,databus,data[7+8*i:8*i],clk,reads[i],writes[i]);    
    end

    tristate loader[7:0](Load_reg,LD_en,databus);
    tristate cc[7:0](C_alu,C_en,databus);
    tristate ff[7:0](F_alu,F_en,databus);
endmodule
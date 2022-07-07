//ALU_fs,C_en,F_en,LDreg,LD_en
module CUEU(
    input clk,pc_in,
    input[4:0] pc_ini,pc_curr,
    input [18:0]pline,
    output[4:0] PCfb,
    output  RD,WR,C_en,F_en,
    output [4:0] RDsel,WRsel
); 
    wire[4:0] PC;
    wire[6:0] en;
    wire[1:0] ALU_fs;

    ID insdec(pline[18:15],en);

    genvar i;
    for(i=0;i<5;i=i+1) begin:pcn
       mux2to1 M({pc_ini[i],PC[i]},pc_in,PCfb[i]);
    end

    MOV_fsm F0(clk,en[1],PC,pline,RD,WR,RDsel,WRsel,PCfb);
    ALU_fsm F1(clk,en[0],PC,pline,RD,WR,C_en,F_en,RDsel,WRsel,PCfb,ALU_fs);
endmodule

module ID (
    input[18:15] pline,
    output[6:0] en
);
    wire[18:15] plbar;
    not n[18:15](plbar,pline);

    and a1(en[0],plbar[18],plbar[17]),
        a5(en[1],plbar[18],pline[17],plbar[16],plbar[15]),
        a6(en[2],plbar[18],pline[17],plbar[16],pline[15]),
        a7(en[3],plbar[18],pline[17],pline[16],plbar[15]),
        a8(en[4],plbar[18],pline[17],pline[16],pline[15]),
        a9(en[5],pline[18],plbar[17],plbar[16],plbar[15]),
        a0(en[6],pline[18],plbar[17],plbar[16],pline[15]);
endmodule

module MOV_fsm(
    input clk,en,
    input[4:0] PC,
    input[18:0] pline,
    output RD,WR,
    output [4:0] RDsel,WRsel,
    output [4:0] PCfb
);
    reg[1:0] state;
    reg[4:0]PCfbx,RDselx,WRselx;
    reg RDx,WRx;

    always@(posedge clk)
    case(state)
        2'b00:begin state <= en?2'b01:2'b00;PCfbx=PC;
        end
        2'b01:begin state <= en?2'b10:2'b00;
        RDselx=pline[9:5];WRselx=pline[14:10];
        RDx=1'b1;WRx=1'b1;PCfbx=PC;
        end
        2'b10:begin state <=2'b00;
        RDx=1'b0;WRx=1'b0;
        PCfbx=PC+1'b1;
        end
        default: state <=2'b00;
    endcase

    tristate t1[4:0](PCfbx,en,PCfb);
    tristate t2[4:0](RDselx,en,RDsel);
    tristate t3[4:0](WRselx,en,WRsel);
    tristate t4(RDx,en,RD);
    tristate t5(WRx,en,WR);
endmodule

module ALU_fsm(
    input clk,en,
    input[4:0] PC,
    input[18:0] pline,
    output RD,WR,C_en,F_en,
    output [4:0] RDsel,WRsel,
    output [4:0] PCfb,
    output [1:0] ALU_fs
);
    reg[4:0]PCfbx,RDselx,WRselx;
    reg RDx,WRx,C_enx,F_enx;
    reg [1:0]ALU_fsx;
    reg[2:0] state;
    always@(posedge clk)
    case(state)
    3'b000:begin state <= en?3'b001:3'b000;PCfbx=PC; end
    3'b001:begin state <=en?3'b010:3'b000;RDselx=pline[4:0];WRselx=5'b00000;RDx=1'b1;WRx=1'b1;PCfbx=PC; end
    3'b010:begin state <=en?3'b011:3'b000;RDx=1'b0;WRx=1'b0;PCfbx=PC; end
    3'b011:begin state <=en?3'b100:3'b000;RDselx=pline[9:5];WRselx=5'b00001;RDx=1'b1;WRx=1'b1;PCfbx=PC; end
    3'b100:begin state <=en?3'b101:3'b000;RDx=1'b0;WRx=1'b0;PCfbx=PC; end
    3'b101:begin state <=en?3'b110:3'b000;ALU_fsx=pline[16:15];C_enx=1'b1;WRselx=pline[14:10];WRx=1'b1;PCfbx=PC; end
    3'b110:begin state <=en?3'b111:3'b000;WRselx=5'b11111;C_enx=1'b0;F_enx=1'b1;PCfbx=PC; end
    3'b111:begin state <=3'b000; WRx=1'b0;F_enx=1'b0;PCfbx=PC+1'b1; end
    default: state=3'b0;
    endcase

    tristate t1[4:0](PCfbx,en,PCfb);
    tristate t2[4:0](RDselx,en,RDsel);
    tristate t3[4:0](WRselx,en,WRsel);
    tristate t4(RDx,en,RD);
    tristate t5(WRx,en,WR);
    tristate t6[1:0](ALU_fsx,en,ALU_fs);
endmodule

module ALU( input[7:0] A,B,input[1:0] FS, output reg [7:0]C, output reg [7:0]flag);

reg [8:0]op;

always @(*) 
begin
case(FS)
    2'b00:begin op=A+B;C=op[7:0];flag[0]=op[8];flag[3:1]=3'b0;
    end 
    2'b01:begin flag[3]=(A>=B)?8'd1:8'd0;flag[2:0]=3'b0;
    end
    2'b10:begin op=A-B;C=op[7:0];flag[3]=op[8];
    end
    2'b11:begin op=A+ 1'b1;C=op[7:0];flag[3]=op[8];
    end
endcase
end
endmodule
module mux(
    input [3:0] A, B, C, D,
    input en, 
    input [1:0] sel,
    output reg [3:0] Y
);

    always@(sel,en)begin
        if(en)begin
            case(sel)
                2'b00: Y = A;
                2'b01: Y = B;
                2'b10: Y = C;
                2'b11: Y = D;
                default: Y = 0;
                endcase
        end else  
          Y = 0;
         end        
endmodule

module demux(
    input [3:0] A,
    input en, 
    input [1:0] sel,
    output reg [3:0] Y1, Y2, Y3, Y4
);

    always@(*)begin
        if(en)begin
            case(sel)
                2'b00:    begin Y1 = A; Y2=0; Y3=0; Y4=0;  end 
                2'b01:    begin Y1 = 0; Y2=A; Y3=0; Y4=0;  end           
                2'b10:    begin Y1 = 0; Y2=0; Y3=A; Y4=0;  end           
                2'b11:    begin Y1 = 0; Y2=0; Y3=0; Y4=A;  end           
                default:  begin Y1 = 0; Y2=0; Y3=0; Y4=0;  end           
                endcase
        end
   end         
endmodule

module top(
    input [15:0] sw,
    input btnU, btnL, btnR, btnC, btnD,
    output [15:0] led,
    input [1:0] sel
 );
    wire  [1:0] Y;

    wire [3:0] middle_connection;
    wire [1:0] muxSel;
    wire [1:0] demuxSel;
    assign muxSel[0] = btnL;
    assign muxSel[1] = btnU;
    assign demuxSel[0] = btnD;
    assign demuxSel[1] = btnR;
   
mux mux1(
            .A(sw[3:0]), 
            .B(sw[7:4]),
            .C(sw[11:8]),
            .D(sw[15:12]),
            .en(1), 
            .sel(muxSel),
            .Y(middle_connection)
);

demux demux1 (
.A(middle_connection),
.en(1), 
.sel(demuxSel),
.Y1(led[3:0]), 
.Y2(led[7:4]),
.Y3(led[11:8]), 
.Y4(led[15:12])
);

endmodule


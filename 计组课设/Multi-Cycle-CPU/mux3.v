module mux3(alusrc,bushB,extout,b);
//choose the second input to ALU
    input [31:0] bushB;
    input [31:0] extout;
    input alusrc;
    output reg[31:0] b;
    
    always@(alusrc or bushB or extout)
    begin
      case(alusrc)
          1'd0:b=bushB;
          1'd1:b=extout;
      endcase
    end
endmodule
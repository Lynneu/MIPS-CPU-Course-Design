module mux1(regdst,ins,m1out); //choose write register
    input [1:0] regdst;
    input [31:0] ins;
    output reg[4:0] m1out;

    always@(regdst or ins)
    begin
      case(regdst)
          2'b00: m1out = ins[20:16]; //rt
          2'b01: m1out = ins[15:11]; //rd
          2'b10: m1out = 5'd31;     //$31
          default: m1out = 5'd0;
      endcase
    end
endmodule

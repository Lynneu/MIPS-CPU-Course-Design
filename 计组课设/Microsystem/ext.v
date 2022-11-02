module ext(extop,ins,extout);
    input [1:0] extop;
    input [31:0] ins;
    output reg [31:0] extout;

    always@(ins or extop)
    begin
      case(extop)
          2'b00: extout = {16'h0000,ins[15:0]};       //zero extend
          2'b01: extout = {{16{ins[15]}},ins[15:0]}; //sign extend
          2'b10: extout = {ins[15:0],16'h0000};       //lui
          default: extout=0;
      endcase
    end
endmodule

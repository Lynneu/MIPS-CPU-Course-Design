module B_reg(clk,b,b_reg);
  input clk;
  input[31:0] b;
  output reg[31:0] b_reg;
  always@(posedge clk)
    b_reg<=b;
endmodule





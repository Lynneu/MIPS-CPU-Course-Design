module A_reg(clk,a,a_reg);
  input clk;
  input[31:0] a;
  output reg[31:0] a_reg;
  always@(posedge clk)
    a_reg<=a;
endmodule
